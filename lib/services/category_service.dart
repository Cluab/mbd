import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/category.dart';

/// Service class responsible for handling all category-related operations with Supabase.
/// This class provides methods for CRUD operations on categories.
class CategoryService {
  /// Supabase client instance used for database operations
  final SupabaseClient _supabase = Supabase.instance.client;

  /// Fetches all categories from Supabase, ordered by creation date (newest first).
  /// Returns a list of Category objects.
  /// Throws an exception if the operation fails.
  Future<List<Category>> getCategories() async {
    try {
      final response = await _supabase
          .from('categories')
          .select()
          .order('created_at', ascending: false);

      return (response as List)
          .map((category) => Category.fromJson(category))
          .toList();
    } catch (e) {
      print('Error fetching categories: $e');
      rethrow;
    }
  }

  /// Fetches a single category by its ID.
  /// Returns null if no category is found with the given ID.
  /// Throws an exception if the operation fails.
  Future<Category?> getCategoryById(int id) async {
    try {
      final response = await _supabase
          .from('categories')
          .select()
          .eq('id', id)
          .single();

      return response != null ? Category.fromJson(response) : null;
    } catch (e) {
      print('Error fetching category: $e');
      rethrow;
    }
  }

  /// Creates a new category in Supabase.
  /// Requires a name and optionally accepts a description.
  /// Returns the newly created Category object.
  /// Throws an exception if the operation fails.
  Future<Category> createCategory({
    required String name,
    String? description,
  }) async {
    try {
      final response = await _supabase.from('categories').insert({
        'name': name,
        'description': description,
      }).select().single();

      return Category.fromJson(response);
    } catch (e) {
      print('Error creating category: $e');
      rethrow;
    }
  }

  /// Updates an existing category in Supabase.
  /// Requires the category ID and optionally accepts new name and description.
  /// Throws an exception if the operation fails.
  Future<void> updateCategory({
    required int id,
    String? name,
    String? description,
  }) async {
    try {
      await _supabase
          .from('categories')
          .update({
            if (name != null) 'name': name,
            if (description != null) 'description': description,
          })
          .eq('id', id);
    } catch (e) {
      print('Error updating category: $e');
      rethrow;
    }
  }

  /// Deletes a category from Supabase by its ID.
  /// Throws an exception if the operation fails.
  Future<void> deleteCategory(int id) async {
    try {
      await _supabase
          .from('categories')
          .delete()
          .eq('id', id);
    } catch (e) {
      print('Error deleting category: $e');
      rethrow;
    }
  }
} 