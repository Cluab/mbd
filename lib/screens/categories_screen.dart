import 'package:flutter/material.dart';
import '../models/category.dart'; // Data model for a category.
import '../services/category_service.dart'; // Service for interacting with Supabase categories table.
import '../widgets/loading_indicator.dart'; // Reusable loading indicator widget.
import '../widgets/error_display.dart'; // Reusable error display widget.

/// A screen that displays a list of business categories fetched from Supabase.
///
/// This screen is a [StatefulWidget] because its content (the list of categories,
/// loading state, and error state) can change over time based on user interaction
/// or network responses.
///
/// It demonstrates:
/// - Fetching data from a service (`CategoryService`).
/// - Managing loading and error states.
/// - Displaying data in a [ListView].
/// - Providing a way to refresh the data.
/// - A FloatingActionButton to (currently) create a test category.
class CategoriesScreen extends StatefulWidget {
  /// Constructor for CategoriesScreen.
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

/// The state associated with the [CategoriesScreen].
///
/// Manages the mutable state for the screen, including the list of categories,
/// loading status, and any error messages.
class _CategoriesScreenState extends State<CategoriesScreen> {
  // Service instance to interact with the category data source (Supabase).
  final CategoryService _categoryService = CategoryService();

  // Holds the list of categories fetched from the service.
  List<Category> _categories = [];

  // Indicates whether the screen is currently fetching data.
  bool _isLoading = true;

  // Stores an error message if data fetching fails.
  String? _error;

  /// Called when this widget is inserted into the tree.
  /// This is a good place to perform initial data loading.
  @override
  void initState() {
    super.initState();
    // Load categories when the screen is first initialized.
    _loadCategories();
  }

  /// Asynchronously loads categories from the [CategoryService].
  ///
  /// This method updates the UI state to reflect loading, success, or error conditions:
  /// - Sets `_isLoading` to true and clears any previous `_error` at the start.
  /// - Fetches categories using `_categoryService.getCategories()`.
  /// - On success, updates `_categories` with the fetched data and sets `_isLoading` to false.
  /// - On failure, sets `_error` to the error message and `_isLoading` to false.
  Future<void> _loadCategories() async {
    try {
      // Update UI to show loading state and clear previous errors.
      setState(() {
        _isLoading = true;
        _error = null;
      });

      // Fetch categories from the service.
      final categories = await _categoryService.getCategories();

      // Update UI with the fetched categories and stop loading.
      setState(() {
        _categories = categories;
        _isLoading = false;
      });
    } catch (e) {
      // If an error occurs, update UI to show the error and stop loading.
      setState(() {
        _error = "Failed to load categories: ${e.toString()}";
        _isLoading = false;
      });
    }
  }

  /// Builds the UI for the CategoriesScreen.
  ///
  /// It returns a [Scaffold] containing an [AppBar], the main body content
  /// (determined by `_buildBody()`), and a [FloatingActionButton] for adding categories.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Business Categories'),
        actions: [
          // Refresh button in the AppBar to manually reload categories.
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh Categories',
            onPressed: _loadCategories, // Calls the _loadCategories method.
          ),
        ],
      ),
      // The body of the Scaffold is determined by the _buildBody method,
      // which handles different states (loading, error, empty, data).
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: _createTestCategory, // Action to create a new test category.
        tooltip: 'Add Test Category',
        child: const Icon(Icons.add),
      ),
    );
  }

  /// Builds the main content widget for the screen based on the current state.
  ///
  /// - If `_isLoading` is true, displays a [LoadingIndicator].
  /// - If `_error` is not null, displays an [ErrorDisplay] with a retry option.
  /// - If `_categories` is empty (and not loading and no error), shows a message
  ///   indicating that no categories were found.
  /// - Otherwise, displays a [ListView] of the fetched categories.
  Widget _buildBody() {
    if (_isLoading) {
      // Show a loading indicator while data is being fetched.
      return const LoadingIndicator(message: 'Loading categories...');
    }

    if (_error != null) {
      // Show an error message and a retry button if fetching failed.
      return ErrorDisplay(
        message: _error!,
        onRetry: _loadCategories, // Allows the user to try loading again.
      );
    }

    if (_categories.isEmpty) {
      // Show a message if no categories are found (and not loading, no error).
      return const Center(
        child: Text('No categories found. Try adding some!'),
      );
    }

    // If data is loaded successfully and is not empty, display it in a ListView.
    return ListView.builder(
      itemCount: _categories.length, // Number of items in the list.
      itemBuilder: (context, index) {
        // Get the category for the current list item.
        final category = _categories[index];
        // Display each category in a Card with a ListTile.
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          elevation: 2,
          child: ListTile(
            title: Text(
              category.name,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w500),
            ),
            subtitle: category.description != null && category.description!.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text(category.description!),
                  )
                : null,
            trailing: category.createdAt != null
                ? Text(
                    'Added: ${_formatDate(category.createdAt!)}',
                    style: Theme.of(context).textTheme.bodySmall,
                  )
                : null,
            // onTap: () { /* TODO: Implement navigation to category details or businesses */ },
          ),
        );
      },
    );
  }

  /// Asynchronously creates a new test category using the [CategoryService].
  ///
  /// After attempting to create the category, it reloads the list of categories
  /// to reflect the new addition. If an error occurs during creation, it displays
  /// a [SnackBar] with the error message.
  /// This is primarily for testing and demonstration.
  Future<void> _createTestCategory() async {
    try {
      // Attempt to create a new category with a unique name and description.
      await _categoryService.createCategory(
        name: 'Test Category ${DateTime.now().millisecondsSinceEpoch}',
        description: 'This is a dynamically created test category.',
      );
      // If creation is successful, reload the categories to show the new one.
      _loadCategories();
      // Show a success message (optional).
      if (mounted) { // Check if the widget is still in the tree.
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Test category created successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      // If an error occurs during creation, show an error message in a SnackBar.
      if (mounted) { // Check if the widget is still in the tree.
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error creating category: ${e.toString()}'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }

  /// Formats a [DateTime] object into a more readable date string (YYYY-MM-DD).
  ///
  /// Example: `_formatDate(DateTime(2023, 5, 1))` would return `"2023-05-01"`.
  String _formatDate(DateTime date) {
    // Pad month and day with a leading zero if they are single digit.
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
} 