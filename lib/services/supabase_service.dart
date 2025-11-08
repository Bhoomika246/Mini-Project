import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static const String supabaseUrl = 'https://ruexiieghjkqngcspnmw.supabase.co';
  static const String supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJ1ZXhpaWVnaGprcW5nY3Nwbm13Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjE5Mjc0MjUsImV4cCI6MjA3NzUwMzQyNX0.ljw7DbG6F1yTuT4T5lLPdXSDyQgXQ5dWIs5iMyONOjE';

  static Future<void> initialize() async {
    await Supabase.initialize(
      url: supabaseUrl,
      anonKey: supabaseAnonKey,
    );
  }

  static SupabaseClient get client => Supabase.instance.client;

  // Authentication methods
  static Future<AuthResponse> signUp({
    required String email,
    required String password,
    required Map<String, dynamic> userData,
  }) async {
    return await client.auth.signUp(
      email: email,
      password: password,
      data: userData,
    );
  }

  static Future<AuthResponse> signIn({
    required String email,
    required String password,
  }) async {
    return await client.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  static Future<void> signOut() async {
    await client.auth.signOut();
  }

  static User? get currentUser => client.auth.currentUser;

  // Machinery data methods
  static Future<List<Map<String, dynamic>>> getMachinery() async {
    final response = await client.from('machinery').select();
    return response;
  }

  static Future<Map<String, dynamic>> getMachineryById(String id) async {
    final response = await client.from('machinery').select().eq('id', id).single();
    return response;
  }

  // Booking methods
  static Future<List<Map<String, dynamic>>> getUserBookings(String userId) async {
    final response = await client.from('bookings').select().eq('user_id', userId);
    return response;
  }

  static Future<Map<String, dynamic>> createBooking(Map<String, dynamic> bookingData) async {
    final response = await client.from('bookings').insert(bookingData).select().single();
    return response;
  }

  static Future<void> updateBookingStatus(int bookingId, String status) async {
    await client.from('bookings').update({'status': status}).eq('id', bookingId);
  }

  // User profile methods
  static Future<Map<String, dynamic>> getUserProfile(String userId) async {
    final response = await client.from('users').select().eq('id', userId).single();
    return response;
  }

  static Future<void> updateUserProfile(String userId, Map<String, dynamic> profileData) async {
    await client.from('users').update(profileData).eq('id', userId);
  }

  static Future<void> logout() async {
    await client.auth.signOut();
  }

  // Add more methods as needed for bookings, users, etc.
}
