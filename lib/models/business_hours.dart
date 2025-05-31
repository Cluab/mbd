// lib/models/business_hours.dart

// Data model representing business hours.
// This should mirror the structure of your 'business_hours' table in Supabase.
class BusinessHours {
  final int id;
  final int businessId; // Foreign key to the business table
  final String? monday;
  final String? tuesday;
  final String? wednesday;
  final String? thursday;
  final String? friday;
  final String? saturday;
  final String? sunday;

  BusinessHours({
    required this.id,
    required this.businessId,
    this.monday,
    this.tuesday,
    this.wednesday,
    this.thursday,
    this.friday,
    this.saturday,
    this.sunday,
  });

  // Factory constructor to create BusinessHours from a JSON map.
  factory BusinessHours.fromJson(Map<String, dynamic> json) {
    return BusinessHours(
      id: json['id'] as int,
      businessId: json['business_id'] as int, // Adjust key name if different
      monday: json['monday'] as String?,
      tuesday: json['tuesday'] as String?,
      wednesday: json['wednesday'] as String?,
      thursday: json['thursday'] as String?,
      friday: json['friday'] as String?,
      saturday: json['saturday'] as String?,
      sunday: json['sunday'] as String?,
    );
  }

  // Method to convert BusinessHours to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'business_id': businessId,
      'monday': monday,
      'tuesday': tuesday,
      'wednesday': wednesday,
      'thursday': thursday,
      'friday': friday,
      'saturday': saturday,
      'sunday': sunday,
    };
  }
} 