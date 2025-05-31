import 'package:flutter/material.dart';

// Define simple mock data structures for business details, contact, and hours.
// These mirror potential Supabase table structures for UI layout purposes.
class MockBusinessDetail {
  final int id;
  final String name;
  final String description;
  final String primaryCategory;
  // Add other business fields as needed for UI layout

  MockBusinessDetail({
    required this.id,
    required this.name,
    required this.description,
    required this.primaryCategory,
  });
}

class MockContactInfo {
  final String phone;
  final String email;
  final String website;
  final String address;
  // Add other contact fields

  MockContactInfo({
    required this.phone,
    required this.email,
    required this.website,
    required this.address,
  });
}

class MockBusinessHours {
  final String monday;
  final String tuesday;
  final String wednesday;
  final String thursday;
  final String friday;
  final String saturday;
  final String sunday;

  MockBusinessHours({
    required this.monday,
    required this.tuesday,
    required this.wednesday,
    required this.thursday,
    required this.friday,
    required this.saturday,
    required this.sunday,
  });
}

// Mock data for a single business detail.
final MockBusinessDetail mockDetail = MockBusinessDetail(
  id: 1,
  name: 'Halal Meats & Groceries',
  description: 'Your one-stop shop for fresh halal meats, groceries, and ethnic foods.',
  primaryCategory: 'Grocery Stores',
);

// Mock data for contact information.
final MockContactInfo mockContact = MockContactInfo(
  phone: '(123) 456-7890',
  email: 'info@halalmeats.com',
  website: 'www.halalmeats.com',
  address: '123 Main St, Anytown, Canada',
);

// Mock data for business hours.
final MockBusinessHours mockHours = MockBusinessHours(
  monday: '9:00 AM - 7:00 PM',
  tuesday: '9:00 AM - 7:00 PM',
  wednesday: '9:00 AM - 7:00 PM',
  thursday: '9:00 AM - 7:00 PM',
  friday: '9:00 AM - 8:00 PM',
  saturday: '10:00 AM - 6:00 PM',
  sunday: '11:00 AM - 5:00 PM',
);

/// A screen that displays detailed information for a specific business.
/// Accepts a business ID to load dynamic content (currently using mock data).
class BusinessDetailScreen extends StatelessWidget {
  /// The ID of the business to display.
  final int businessId;

  /// Constructor for BusinessDetailScreen.
  const BusinessDetailScreen({super.key, required this.businessId});

  @override
  Widget build(BuildContext context) {
    // In a real implementation, you would fetch data based on businessId here.
    // For now, we use mock data.
    final businessDetail = mockDetail; // Assuming businessId matches the mock for now.
    final contactInfo = mockContact;
    final businessHours = mockHours;

    return Scaffold(
      appBar: AppBar(
        title: Text(businessDetail.name),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              businessDetail.name,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8.0),
            Text(
              businessDetail.primaryCategory,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              businessDetail.description,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const Divider(height: 32.0),
            Text(
              'Contact Information',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8.0),
            Text('Phone: ${contactInfo.phone}'),
            Text('Email: ${contactInfo.email}'),
            Text('Website: ${contactInfo.website}'),
            Text('Address: ${contactInfo.address}'),
            const Divider(height: 32.0),
            Text(
              'Business Hours',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8.0),
            Text('Monday: ${businessHours.monday}'),
            Text('Tuesday: ${businessHours.tuesday}'),
            Text('Wednesday: ${businessHours.wednesday}'),
            Text('Thursday: ${businessHours.thursday}'),
            Text('Friday: ${businessHours.friday}'),
            Text('Saturday: ${businessHours.saturday}'),
            Text('Sunday: ${businessHours.sunday}'),
            // TODO: Add a Map widget here later
            const SizedBox(height: 32.0),
            Text(
              'Location',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8.0),
            Container(
              height: 200, // Placeholder height for the map
              color: Colors.grey[300], // Placeholder background color
              child: const Center(
                child: Text(
                  'Map Placeholder',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 