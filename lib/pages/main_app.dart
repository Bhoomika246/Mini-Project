import 'package:flutter/material.dart';
import 'dashboard.dart';

class MainApp extends StatelessWidget {
  final Function onLogout;
  final Function onNavigateToProfile;
  final Map<String, dynamic> currentUser;
  final String userRole;

  const MainApp({
    super.key,
    required this.onLogout,
    required this.onNavigateToProfile,
    required this.currentUser,
    required this.userRole,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Raitha Mithra'),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () => onNavigateToProfile(),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => onLogout(),
          ),
        ],
      ),
      body: Dashboard(
        currentUser: currentUser,
        userRole: userRole,
      ),
    );
  }
}