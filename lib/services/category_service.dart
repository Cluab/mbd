import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/category.dart';

class CategoryService {
  final SupabaseClient _supabase = Supabase.instance.client;

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