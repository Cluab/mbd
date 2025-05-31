// lib/models/contact_info.dart

// Data model representing contact information for a business.
// This should mirror the structure of your 'contacts' table in Supabase.
class ContactInfo {
  final int id;
  final int businessId; // Foreign key to the business table
  final String? phone;
  final String? email;
  final String? website;
  final String? address;
  // Add other contact fields

  ContactInfo({
    required this.id,
    required this.businessId,
    this.phone,
    this.email,
    this.website,
    this.address,
  });

  // Factory constructor to create ContactInfo from a JSON map.
  factory ContactInfo.fromJson(Map<String, dynamic> json) {
    return ContactInfo(
      id: json['id'] as int,
      businessId: json['business_id'] as int, // Adjust key name if different
      phone: json['phone'] as String?,
      email: json['email'] as String?,
      website: json['website'] as String?,
      address: json['address'] as String?,
    );
  }

  // Method to convert ContactInfo to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'business_id': businessId,
      'phone': phone,
      'email': email,
      'website': website,
      'address': address,
    };
  }
} 