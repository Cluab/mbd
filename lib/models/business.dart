import 'business_contact.dart';
import 'business_hours.dart';

/// A model class representing a business in the application.
/// This class is used to structure business data fetched from Supabase.
class Business {
  /// Unique identifier for the business
  final int id;
  
  /// Name of the business
  final String name;
  
  /// Optional description of the business
  final String? description;
  
  /// Address of the business
  final String address;
  
  /// Phone number of the business
  final String phone;
  
  /// Email of the business
  final String email;
  
  /// Website of the business
  final String? website;
  
  /// Category ID this business belongs to
  final int categoryId;
  
  /// Timestamp when the business was created
  final DateTime createdAt;
  
  /// List of contacts associated with this business
  final List<BusinessContact>? contacts;
  
  /// List of business hours associated with this business
  final List<BusinessHours>? hours;

  /// Constructor for creating a new Business instance
  Business({
    required this.id,
    required this.name,
    this.description,
    required this.address,
    required this.phone,
    required this.email,
    this.website,
    required this.categoryId,
    required this.createdAt,
    this.contacts,
    this.hours,
  });

  /// Creates a Business instance from a JSON map.
  /// Used when deserializing data from Supabase.
  factory Business.fromJson(Map<String, dynamic> json) {
    return Business(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      address: json['address'],
      phone: json['phone'],
      email: json['email'],
      website: json['website'],
      categoryId: json['category_id'],
      createdAt: DateTime.parse(json['created_at']),
      contacts: json['contacts'] != null
          ? List<BusinessContact>.from(
              json['contacts'].map((x) => BusinessContact.fromJson(x)))
          : null,
      hours: json['business_hours'] != null
          ? List<BusinessHours>.from(
              json['business_hours'].map((x) => BusinessHours.fromJson(x)))
          : null,
    );
  }

  /// Converts the Business instance to a JSON map.
  /// Used when serializing data to send to Supabase.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'address': address,
      'phone': phone,
      'email': email,
      'website': website,
      'category_id': categoryId,
      'created_at': createdAt.toIso8601String(),
    };
  }
} 