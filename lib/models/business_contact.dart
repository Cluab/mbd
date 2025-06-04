/// A model class representing a contact associated with a business.
/// This class is used to structure contact data fetched from Supabase.
class BusinessContact {
  /// Unique identifier for the contact
  final int id;
  
  /// ID of the business this contact belongs to
  final int businessId;
  
  /// Name of the contact person
  final String name;
  
  /// Position/role of the contact person
  final String? position;
  
  /// Phone number of the contact person
  final String? phone;
  
  /// Email of the contact person
  final String? email;
  
  /// Timestamp when the contact was created
  final DateTime createdAt;

  /// Constructor for creating a new BusinessContact instance
  BusinessContact({
    required this.id,
    required this.businessId,
    required this.name,
    this.position,
    this.phone,
    this.email,
    required this.createdAt,
  });

  /// Creates a BusinessContact instance from a JSON map.
  /// Used when deserializing data from Supabase.
  factory BusinessContact.fromJson(Map<String, dynamic> json) {
    return BusinessContact(
      id: json['id'],
      businessId: json['business_id'],
      name: json['name'],
      position: json['position'],
      phone: json['phone'],
      email: json['email'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  /// Converts the BusinessContact instance to a JSON map.
  /// Used when serializing data to send to Supabase.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'business_id': businessId,
      'name': name,
      'position': position,
      'phone': phone,
      'email': email,
      'created_at': createdAt.toIso8601String(),
    };
  }
} 