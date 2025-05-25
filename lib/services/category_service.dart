import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/category.dart'; // Data model for Category.

/// A service class that encapsulates all category-related operations
/// with the Supabase backend.
///
/// This class provides methods for common CRUD (Create, Read, Update, Delete)
/// operations on the 'categories' table in Supabase.
/// It handles the direct interaction with the Supabase client and maps
/// the data to and from the [Category] model.
///
/// Error handling typically involves printing an error to the console and re-throwing
/// the exception to be handled by the calling UI layer (e.g., to show a SnackBar
/// or an error message to the user).
class CategoryService {
  // Instance of the Supabase client, used to interact with the Supabase backend.
  // Supabase.instance.client provides the initialized Supabase client singleton.
  final SupabaseClient _supabase = Supabase.instance.client;

  /// Fetches all categories from the 'categories' table in Supabase.
  ///
  /// The categories are ordered by their 'id' in descending order (newest first).
  ///
  /// Returns a [Future] that completes with a list of [Category] objects.
  /// If an error occurs during the fetch operation (e.g., network issue, Supabase error),
  /// it prints the error and re-throws the exception.
  Future<List<Category>> getCategories() async {
    try {
      // Perform a select query on the 'categories' table.
      // .select() fetches all columns.
      // .order() specifies the sorting order.
      final response = await _supabase
          .from('categories') // Specifies the table name.
          .select() // Selects all columns for each category.
          .order('id', ascending: false); // Orders by 'id' descending.

      // The response from Supabase is a List of Maps (List<Map<String, dynamic>>).
      // Each map needs to be converted into a Category object.
      return (response as List)
          .map((categoryJson) => Category.fromJson(categoryJson as Map<String, dynamic>))
          .toList();
    } catch (e) {
      // Log the error for debugging purposes.
      print('Error fetching categories: $e');
      // Re-throw the caught exception to allow higher-level error handling.
      rethrow;
    }
  }

  /// Fetches a single category by its unique [id] from Supabase.
  ///
  /// Returns a [Future] that completes with a [Category] object if found,
  /// or `null` if no category exists with the given [id].
  /// Throws an exception if the operation fails.
  Future<Category?> getCategoryById(int id) async {
    try {
      // Perform a select query filtered by the 'id' column.
      // .eq('id', id) filters for rows where 'id' equals the provided id.
      // .single() expects at most one row; throws an error if multiple rows are found,
      // or returns the single row data if one is found.
      final response = await _supabase
          .from('categories')
          .select()
          .eq('id', id) // Filters by the category ID.
          .single(); // Expects a single record or throws PostgrestException if not found or multiple.

      // If response is not null (i.e., a category was found), convert it to a Category object.
      // Note: .single() itself will throw if no row is found. If it returns null here, it implies
      // the Supabase client configuration might be different or an older version.
      // Modern Supabase .single() typically throws if not found.
      // For safety, we check for null, though it might be redundant with current Supabase behavior.
      return Category.fromJson(response as Map<String, dynamic>); // Cast is safe if single() guarantees a map or throws.
    } on PostgrestException catch (e) {
      // Specifically catch PostgrestException, which Supabase client throws for API errors.
      // If the error indicates no rows were found (PGRST116), it means category doesn't exist.
      if (e.code == 'PGRST116') {
        print('Category with id $id not found: $e');
        return null; // Return null if category not found.
      }
      // For other PostgREST errors, log and rethrow.
      print('Error fetching category by id $id: $e');
      rethrow;
    } catch (e) {
      // Catch any other unexpected errors.
      print('Unexpected error fetching category by id $id: $e');
      rethrow;
    }
  }

  /// Creates a new category in the 'categories' table in Supabase.
  ///
  /// Requires the [name] of the category.
  /// Optionally accepts a [description].
  /// The `created_at` field is typically handled by Supabase (e.g., default value `now()`).
  ///
  /// Returns a [Future] that completes with the newly created [Category] object,
  /// including its database-assigned ID and `created_at` timestamp.
  /// Throws an exception if the operation fails.
  Future<Category> createCategory({
    required String name,
    String? description,
  }) async {
    try {
      // Prepare the data map for insertion.
      // Only include 'description' if it's not null.
      final Map<String, dynamic> categoryData = {
        'name': name,
        if (description != null) 'description': description,
      };

      // Perform an insert operation.
      // .insert() takes the data to be inserted.
      // .select() immediately after insert fetches the newly created row(s).
      // .single() ensures we get back the single newly created category object.
      final response = await _supabase
          .from('categories')
          .insert(categoryData)
          .select() // Select the newly inserted row to get its ID and created_at.
          .single(); // Expects the single inserted record.

      // Convert the JSON response of the new category into a Category object.
      return Category.fromJson(response as Map<String, dynamic>);
    } catch (e) {
      print('Error creating category with name \'$name\': $e');
      rethrow;
    }
  }

  /// Updates an existing category in the 'categories' table in Supabase.
  ///
  /// Requires the [id] of the category to update.
  /// Optionally accepts a new [name] and/or [description]. Only provided fields are updated.
  ///
  /// Returns a [Future] that completes when the update operation is finished.
  /// Throws an exception if the operation fails (e.g., category with ID not found).
  Future<void> updateCategory({
    required int id,
    String? name,       // Optional new name.
    String? description, // Optional new description.
  }) async {
    try {
      // Prepare the data map for update. Only include fields that are provided (not null).
      final Map<String, dynamic> updates = {};
      if (name != null) updates['name'] = name;
      if (description != null) updates['description'] = description;

      // If there are no updates to make, we can return early.
      if (updates.isEmpty) {
        print('No updates provided for category ID: $id');
        return;
      }

      // Perform an update operation on the row matching the 'id'.
      await _supabase
          .from('categories')
          .update(updates) // Provide the map of fields to update.
          .eq('id', id);    // Specify which row to update using its ID.
      // .execute(); // Supabase versions might vary; .execute() might be needed or implied.
      // Check Supabase docs if .eq() alone triggers execution or returns a builder.

    } catch (e) {
      print('Error updating category ID $id: $e');
      rethrow;
    }
  }

  /// Deletes a category from the 'categories' table in Supabase by its [id].
  ///
  /// Returns a [Future] that completes when the delete operation is finished.
  /// Throws an exception if the operation fails (e.g., category with ID not found).
  Future<void> deleteCategory(int id) async {
    try {
      // Perform a delete operation on the row matching the 'id'.
      await _supabase
          .from('categories')
          .delete()
          .eq('id', id); // Specify which row to delete.
    } catch (e) {
      print('Error deleting category ID $id: $e');
      rethrow;
    }
  }
} 