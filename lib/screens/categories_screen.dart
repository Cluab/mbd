import 'package:flutter/material.dart';
import '../models/category.dart';
import '../services/category_service.dart';

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
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Error: $_error',
                        style: const TextStyle(color: Colors.red),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _loadCategories,
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                )
              : _categories.isEmpty
                  ? const Center(
                      child: Text('No categories found'),
                    )
                  : ListView.builder(
                      itemCount: _categories.length,
                      itemBuilder: (context, index) {
                        final category = _categories[index];
                        return ListTile(
                          title: Text(category.name),
                          subtitle: category.description != null
                              ? Text(category.description!)
                              : null,
                          trailing: Text(
                            'Created: ${category.createdAt.toString().split('.')[0]}',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        );
                      },
                    ),
      // Floating action button to create a new test category
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
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
        },
        child: const Icon(Icons.add),
      ),
    );
  }
} 