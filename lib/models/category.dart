/// Represents a business category within the ISN application.
///
/// This class is a data model that structures the information for a category,
/// including its ID, name, an optional description, and an optional creation timestamp.
/// It includes methods for serializing to and deserializing from JSON, which is
/// essential for interacting with the Supabase backend.
class Category {
  /// The unique identifier for the category, typically an integer assigned by the database.
  final int id;
  
  /// The name of the category (e.g., "Restaurants", "Clothing Stores").
  /// This field is required.
  final String name;
  
  /// An optional textual description providing more details about the category.
  /// This field can be null if no description is available.
  final String? description;
  
  /// An optional timestamp indicating when the category record was created in the database.
  /// This field can be null, for example, if the data source doesn't provide it or
  /// if it's a newly created object not yet persisted.
  final DateTime? createdAt;

  /// Constructs a [Category] instance.
  ///
  /// Requires `id` and `name`.
  /// `description` and `createdAt` are optional and can be null.
  Category({
    required this.id,
    required this.name,
    this.description, // Optional: can be omitted or explicitly set to null.
    this.createdAt,   // Optional: can be omitted or explicitly set to null.
  });

  /// Creates a [Category] instance from a JSON (Map<String, dynamic>) object.
  ///
  /// This factory constructor is used for deserializing category data received
  /// from an external source, such as the Supabase API.
  /// It handles potential null values for `description` and `created_at`.
  /// The `created_at` field, if present and not null in the JSON, is parsed into a [DateTime] object.
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] as int, // Assumes 'id' is always present and an integer.
      name: json['name'] as String, // Assumes 'name' is always present and a string.
      description: json['description'] as String?, // Allows for a null description.
      // Parses 'created_at' string to DateTime if present, otherwise null.
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
    );
  }

  /// Converts the [Category] instance into a JSON (Map<String, dynamic>) object.
  ///
  /// This method is used for serializing category data to be sent to an external
  /// source, like the Supabase API, typically for creating or updating records.
  /// The `created_at` field is only included in the JSON if it's not null,
  /// and it's converted to an ISO 8601 string format.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description, // Will be null in JSON if description is null.
      // Conditionally include 'created_at' only if it's not null.
      if (createdAt != null) 'created_at': createdAt!.toIso8601String(),
    };
  }
} 