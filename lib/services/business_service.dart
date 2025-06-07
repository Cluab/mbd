import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/business.dart';

class BusinessService {
  final SupabaseClient _supabase;

  BusinessService(this._supabase);

  Future<List<Business>> getAllBusinesses() async {
    try {
      final response = await _supabase
          .from('businesses')
          .select()
          .order('created_at', ascending: false);

      return (response as List)
          .map((json) => Business.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch businesses: $e');
    }
  }

  Future<Business?> getBusinessById(String id) async {
    try {
      final response = await _supabase
          .from('businesses')
          .select()
          .eq('id', id)
          .single();

      return Business.fromJson(response);
    } catch (e) {
      throw Exception('Failed to fetch business: $e');
    }
  }
} 