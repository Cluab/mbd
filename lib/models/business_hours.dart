/// A model class representing the operating hours of a business.
/// This class is used to structure business hours data fetched from Supabase.
class BusinessHours {
  /// Unique identifier for the business hours entry
  final int id;
  
  /// ID of the business these hours belong to
  final int businessId;
  
  /// Day of the week (0-6, where 0 is Sunday)
  final int dayOfWeek;
  
  /// Opening time in 24-hour format (HH:mm)
  final String openTime;
  
  /// Closing time in 24-hour format (HH:mm)
  final String closeTime;
  
  /// Whether the business is closed on this day
  final bool isClosed;
  
  /// Timestamp when the hours were created
  final DateTime createdAt;

  /// Constructor for creating a new BusinessHours instance
  BusinessHours({
    required this.id,
    required this.businessId,
    required this.dayOfWeek,
    required this.openTime,
    required this.closeTime,
    required this.isClosed,
    required this.createdAt,
  });

  /// Creates a BusinessHours instance from a JSON map.
  /// Used when deserializing data from Supabase.
  factory BusinessHours.fromJson(Map<String, dynamic> json) {
    return BusinessHours(
      id: json['id'],
      businessId: json['business_id'],
      dayOfWeek: json['day_of_week'],
      openTime: json['open_time'],
      closeTime: json['close_time'],
      isClosed: json['is_closed'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  /// Converts the BusinessHours instance to a JSON map.
  /// Used when serializing data to send to Supabase.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'business_id': businessId,
      'day_of_week': dayOfWeek,
      'open_time': openTime,
      'close_time': closeTime,
      'is_closed': isClosed,
      'created_at': createdAt.toIso8601String(),
    };
  }
} 