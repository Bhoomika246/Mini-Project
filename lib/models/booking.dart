class Booking {
  final int id;
  final String userId;
  final int machineryId;
  final String machineryName;
  final String machineryType;
  final double price;
  final DateTime startDate;
  final DateTime endDate;
  final String status; // 'pending', 'confirmed', 'completed', 'cancelled'
  final DateTime createdAt;
  final String? notes;

  Booking({
    required this.id,
    required this.userId,
    required this.machineryId,
    required this.machineryName,
    required this.machineryType,
    required this.price,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.createdAt,
    this.notes,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? '',
      machineryId: json['machinery_id'] ?? 0,
      machineryName: json['machinery_name'] ?? '',
      machineryType: json['machinery_type'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      startDate: DateTime.parse(json['start_date'] ?? DateTime.now().toIso8601String()),
      endDate: DateTime.parse(json['end_date'] ?? DateTime.now().toIso8601String()),
      status: json['status'] ?? 'pending',
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toIso8601String()),
      notes: json['notes'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'machinery_id': machineryId,
      'machinery_name': machineryName,
      'machinery_type': machineryType,
      'price': price,
      'start_date': startDate.toIso8601String(),
      'end_date': endDate.toIso8601String(),
      'status': status,
      'created_at': createdAt.toIso8601String(),
      'notes': notes,
    };
  }
}
