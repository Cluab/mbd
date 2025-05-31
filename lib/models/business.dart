// lib/models/business.dart

// Data model representing a business.
// This should mirror the structure of your 'businesses' table in Supabase.
class Business {
  final int id;
  final String name;
  final String? description;
  final int primaryCategoryId; // Assuming a foreign key relationship
  final String? address;
  final double? latitude;
  final double? longitude;
  final String? imageUrl;
  final DateTime? createdAt;

  Business({
    required this.id,
    required this.name,
    this.description,
    required this.primaryCategoryId,
    this.address,
    this.latitude,
    this.longitude,
    this.imageUrl,
    this.createdAt,
  });

  // Factory constructor to create a Business from a JSON map.
  factory Business.fromJson(Map<String, dynamic> json) {
    return Business(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String?,
      primaryCategoryId: json['primary_category_id'] as int, // Adjust key name if different in Supabase
      address: json['address'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(), // Handle potential null and num type
      longitude: (json['longitude'] as num?)?.toDouble(), // Handle potential null and num type
      imageUrl: json['image_url'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
    );
  }

  // Method to convert a Business to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'primary_category_id': primaryCategoryId,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'image_url': imageUrl,
      'created_at': createdAt?.toIso8601String(),
    };
  }
} 