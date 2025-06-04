import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/business.dart';
import '../models/business_contact.dart';
import '../models/business_hours.dart';

/// A service class that handles business-related operations with Supabase.
class BusinessService {
  final SupabaseClient _client;

  BusinessService(this._client);

  /// Fetches a business and all its associated details (contacts and hours)
  /// from Supabase using the provided business ID.
  /// 
  /// Returns a [Business] object with all its related data.
  /// Throws an exception if the business is not found or if there's an error.
  Future<Business> getBusinessDetails(int businessId) async {
    try {
      final response = await _client
          .from('businesses')
          .select('''
            *,
            contacts:business_contacts(*),
            business_hours(*)
          ''')
          .eq('id', businessId)
          .single();

      if (response == null) {
        throw Exception('Business not found');
      }

      return Business.fromJson(response);
    } catch (e) {
      throw Exception('Failed to fetch business details: $e');
    }
  }
} 