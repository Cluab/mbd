/// A model class representing a category in the application.
/// This class is used to structure category data fetched from Supabase.
class Category {
  /// Unique identifier for the category
  final int id;
  
  /// Name of the category
  final String name;
  
  /// Optional description of the category
  final String? description;
  
  /// Timestamp when the category was created
  final DateTime? createdAt;

  /// Constructor for creating a new Category instance
  Category({
    required this.id,
    required this.name,
    this.description,
    this.createdAt,
  });

  /// Creates a Category instance from a JSON map.
  /// Used when deserializing data from Supabase.
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
    );
  }

  /// Converts the Category instance to a JSON map.
  /// Used when serializing data to send to Supabase.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      if (createdAt != null) 'created_at': createdAt!.toIso8601String(),
    };
  }
} 