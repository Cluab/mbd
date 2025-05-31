import '../models/business.dart';
import '../models/contact_info.dart';
import '../models/business_hours.dart';
import './mock_business_data.dart'; // Import the mock data.
import '../models/category.dart'; // Import Category for joining.

// Assuming you have a mock category list or can retrieve mock categories.
// For simplicity in this mock service, we might hardcode category names
// or pass in a mock category service dependency if needed.

/// A mock service for fetching business data.
/// This service simulates network requests and uses predefined mock data.
/// It serves as a placeholder until the actual Supabase service is integrated.
class MockBusinessService {
  /// Simulates fetching a list of businesses.
  /// Returns the predefined mock business list after a delay.
  Future<List<Business>> getBusinesses() async {
    // Simulate network delay.
    await Future.delayed(const Duration(seconds: 1));
    // In a real service, you would join with categories here to get the category name.
    // For this mock, we'll return the raw business objects.
    return mockBusinessList;
  }

  /// Simulates fetching a single business and its related details by ID.
  /// Returns a Map containing the business, contact info, and hours.
  Future<Map<String, dynamic>?> getBusinessDetails(int businessId) async {
    // Simulate network delay.
    await Future.delayed(const Duration(seconds: 1));

    // Find the mock business by ID.
    final business = mockBusinessDetails[businessId];

    if (business != null) {
      // Find related mock contact info and hours.
      final contact = mockContactInfo[businessId];
      final hours = mockBusinessHours[businessId];

      // In a real service, you would also fetch the category name here.

      return {
        'business': business,
        'contact': contact,
        'hours': hours,
      };
    } else {
      return null; // Return null if the business is not found.
    }
  }

  /// Simulates fetching a single category by ID.
  /// Returns the Category object if found, otherwise null.
  Future<Category?> getCategoryById(int categoryId) async {
    // Simulate network delay.
    await Future.delayed(const Duration(milliseconds: 500)); // Shorter delay for category lookup
    
    // Find the mock category by ID.
    try {
      final category = mockCategoryList.firstWhere((cat) => cat.id == categoryId);
      return category;
    } catch (e) {
      // Return null if category is not found (e.g., id not in mock list)
      return null;
    }
  }

  /// Simulates fetching a list of categories.
  /// Returns the predefined mock category list after a delay.
  Future<List<Category>> getCategories() async {
    // Simulate network delay.
    await Future.delayed(const Duration(milliseconds: 500));
    return mockCategoryList;
  }

  // TODO: Add a method to fetch Category by ID or name for displaying category in list.
} 