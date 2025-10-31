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

  // Add more methods as needed for bookings, users, etc.
}
