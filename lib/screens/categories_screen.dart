import 'package:flutter/material.dart';
import '../models/category.dart';
import '../services/category_service.dart';
import '../widgets/loading_indicator.dart';
import '../widgets/error_display.dart';

/// A screen that displays a list of categories and allows creating new ones.
/// This screen demonstrates the integration with Supabase for category management.
class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  /// Service instance for handling category operations
  final CategoryService _categoryService = CategoryService();
  
  /// List of categories to display
  List<Category> _categories = [];
  
  /// Loading state indicator
  bool _isLoading = true;
  
  /// Error message if something goes wrong
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  /// Loads categories from Supabase and updates the UI state accordingly.
  /// Handles loading states and errors.
  Future<void> _loadCategories() async {
    try {
      setState(() {
        _isLoading = true;
        _error = null;
      });

      final categories = await _categoryService.getCategories();
      
      setState(() {
        _categories = categories;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
        actions: [
          // Refresh button to reload categories
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadCategories,
          ),
        ],
      ),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: _createTestCategory,
        child: const Icon(Icons.add),
      ),
    );
  }

  /// Builds the main body of the screen based on the current state
  Widget _buildBody() {
    if (_isLoading) {
      return const LoadingIndicator(message: 'Loading categories...');
    }

    if (_error != null) {
      return ErrorDisplay(
        message: _error!,
        onRetry: _loadCategories,
      );
    }

    if (_categories.isEmpty) {
      return const Center(
        child: Text('No categories found'),
      );
    }

    return ListView.builder(
      itemCount: _categories.length,
      itemBuilder: (context, index) {
        final category = _categories[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: ListTile(
            title: Text(
              category.name,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            subtitle: category.description != null
                ? Text(category.description!)
                : null,
            trailing: category.createdAt != null
                ? Text(
                    'Created: ${_formatDate(category.createdAt!)}',
                    style: Theme.of(context).textTheme.bodySmall,
                  )
                : null,
          ),
        );
      },
    );
  }

  /// Creates a test category for demonstration purposes
  Future<void> _createTestCategory() async {
    try {
      await _categoryService.createCategory(
        name: 'Test Category ${DateTime.now().millisecondsSinceEpoch}',
        description: 'This is a test category',
      );
      _loadCategories(); // Reload the list after creating
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error creating category: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  /// Formats a DateTime object into a readable string
  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
} 