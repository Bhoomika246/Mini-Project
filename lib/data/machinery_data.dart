import '../models/machinery.dart';
import '../services/supabase_service.dart';

class MachineryData {
  static Future<List<Machinery>> getMachineryList() async {
    try {
      final data = await SupabaseService.getMachinery();
      return data.map((item) => Machinery.fromJson(item)).toList();
    } catch (e) {
      // Fallback to empty list if Supabase fails
      return [];
    }
  }

  static Future<Machinery?> getMachineryById(int id) async {
    try {
      final data = await SupabaseService.getMachineryById(id.toString());
      return Machinery.fromJson(data);
    } catch (e) {
      return null;
    }
  }
}

// Legacy list for backward compatibility (can be removed later)
List<Machinery> machineryList = [];
