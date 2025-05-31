import '../models/business.dart';
import '../models/contact_info.dart';
import '../models/business_hours.dart';
import '../models/category.dart';

// Mock data for categories.
final List<Category> mockCategoryList = [
  Category(id: 1, name: 'Grocery Stores', description: 'Stores selling groceries and food items.'),
  Category(id: 2, name: 'Bookstores', description: 'Stores selling books and educational materials.'),
  Category(id: 3, name: 'Restaurants', description: 'Places to eat.'),
  Category(id: 4, name: 'Clothing', description: 'Stores selling clothing and apparel.'),
  // Add more mock categories here...
];

// Mock data for businesses.
final List<Business> mockBusinessList = [
  Business(
    id: 1,
    name: 'Halal Meats & Groceries',
    description: 'Your one-stop shop for fresh halal meats, groceries, and ethnic foods.',
    primaryCategoryId: 1, // Assuming category ID 1 is 'Grocery Stores'
    address: '123 Main St, Anytown, Canada',
    latitude: 43.651070,
    longitude: -79.347015,
    imageUrl: null, // Placeholder
    createdAt: DateTime.parse('2023-01-15T10:00:00Z'),
  ),
  Business(
    id: 2,
    name: 'Islamic Bookstore & Gifts',
    description: 'Wide selection of Islamic books, art, clothing, and gifts.',
    primaryCategoryId: 2, // Assuming category ID 2 is 'Bookstores'
    address: '456 Elm Ave, Anytown, Canada',
    latitude: 43.653225,
    longitude: -79.383186,
    imageUrl: null,
    createdAt: DateTime.parse('2023-02-20T11:30:00Z'),
  ),
  // Add more mock businesses here...
];

// Mock data for business details, keyed by business ID.
final Map<int, Business> mockBusinessDetails = {
  for (var business in mockBusinessList) business.id: business,
};

// Mock data for contact information, keyed by business ID.
final Map<int, ContactInfo> mockContactInfo = {
  1: ContactInfo(
    id: 101,
    businessId: 1,
    phone: '(123) 456-7890',
    email: 'info@halalmeats.com',
    website: 'www.halalmeats.com',
    address: '123 Main St, Anytown, Canada',
  ),
  2: ContactInfo(
    id: 102,
    businessId: 2,
    phone: '(987) 654-3210',
    email: 'contact@islamicbooks.com',
    website: 'www.islamicbooks.com',
    address: '456 Elm Ave, Anytown, Canada',
  ),
  // Add more mock contact info...
};

// Mock data for business hours, keyed by business ID.
final Map<int, BusinessHours> mockBusinessHours = {
  1: BusinessHours(
    id: 201,
    businessId: 1,
    monday: '9:00 AM - 7:00 PM',
    tuesday: '9:00 AM - 7:00 PM',
    wednesday: '9:00 AM - 7:00 PM',
    thursday: '9:00 AM - 7:00 PM',
    friday: '9:00 AM - 8:00 PM',
    saturday: '10:00 AM - 6:00 PM',
    sunday: '11:00 AM - 5:00 PM',
  ),
  2: BusinessHours(
    id: 202,
    businessId: 2,
    monday: '10:00 AM - 6:00 PM',
    tuesday: '10:00 AM - 6:00 PM',
    wednesday: '10:00 AM - 6:00 PM',
    thursday: '10:00 AM - 6:00 PM',
    friday: '10:00 AM - 7:00 PM',
    saturday: '11:00 AM - 5:00 PM',
    sunday: 'Closed',
  ),
  // Add more mock business hours...
}; 