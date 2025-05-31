// lib/screens/business_list_screen.dart

import 'package:flutter/material.dart';
import '../config/routes.dart'; // Import routes to enable navigation.
import '../models/business.dart'; // Import the Business model.
import '../services/mock_business_service.dart'; // Import the mock service.
import '../widgets/loading_indicator.dart'; // Import loading indicator.
import '../widgets/error_display.dart'; // Import error display.
import '../models/category.dart'; // Import the Category model.

/// A screen that displays a list of businesses.
/// Fetches mock data using MockBusinessService for UI development.
/// Will be updated later to fetch live data from Supabase.
class BusinessListScreen extends StatefulWidget {
  /// Constructor for BusinessListScreen.
  const BusinessListScreen({super.key});

  @override
  State<BusinessListScreen> createState() => _BusinessListScreenState();
}

class _BusinessListScreenState extends State<BusinessListScreen> {
  // List to hold businesses fetched from the service.
  List<Business> _businesses = [];
  // List to hold categories fetched from the service.
  List<Category> _categories = [];
  // Loading state.
  bool _isLoading = true;
  // Error state.
  String? _error;

  // Instance of the mock service.
  final MockBusinessService _businessService = MockBusinessService();

  @override
  void initState() {
    super.initState();
    _fetchBusinesses(); // Fetch businesses when the widget is initialized.
  }

  /// Fetches the list of businesses and categories using the mock service.
  Future<void> _fetchBusinesses() async {
    try {
      // Fetch businesses and categories concurrently
      final results = await Future.wait([
        _businessService.getBusinesses(),
        _businessService.getCategories(),
      ]);

      final businesses = results[0] as List<Business>;
      final categories = results[1] as List<Category>;

      setState(() {
        _businesses = businesses;
        _categories = categories;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Failed to load businesses: ${e.toString()}';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Businesses'),
        centerTitle: true,
      ),
      body: _isLoading // Check if data is loading.
          ? const Center(child: LoadingIndicator()) // Show loading indicator.
          : _error != null // Check if there is an error.
              ? Center(child: ErrorDisplay(message: _error!)) // Show error message.
              : _businesses.isEmpty // Check if the list is empty.
                  ? const Center(
                      child: Text('No businesses found.'),
                    ) // Show empty state message.
                  : ListView.builder(
                      itemCount: _businesses.length,
                      itemBuilder: (context, index) {
                        final business = _businesses[index];
                        // Display each business as a ListTile.
                        return Card(
                          margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                          child: ListTile(
                            leading: CircleAvatar(child: Text(business.name[0])),
                            title: Text(business.name),
                            // Find the category name for the current business.
                            // Use a default value if the category is not found.
                            subtitle: Text(
                              'Category: ${ _categories.firstWhere(
                                  (cat) => cat.id == business.primaryCategoryId,
                                  orElse: () => Category(id: -1, name: 'Unknown'),
                                ).name}',
                            ),
                            onTap: () {
                              // Navigate to the BusinessDetailScreen, passing the business ID.
                              Navigator.pushNamed(
                                context,
                                AppRoutes.businessDetail,
                                arguments: business.id, // Pass the business ID as an argument.
                              );
                              // print('Tapped on ${business.name}'); // Removed print statement as it's no longer needed for confirmation.
                            },
                          ),
                        );
                      },
                    ),
    );
  }
} 