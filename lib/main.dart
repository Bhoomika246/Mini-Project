import 'package:flutter/material.dart';
import 'pages/login_page.dart';
import 'pages/main_app.dart';
import 'services/supabase_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SupabaseService.initialize();
  runApp(const RaithaMithraApp());
}

class RaithaMithraApp extends StatelessWidget {
  const RaithaMithraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Raitha Mithra',
      theme: ThemeData(
        primarySwatch: Colors.green,
        useMaterial3: true,
      ),
      home: const AppWrapper(),
    );
  }
}

class AppWrapper extends StatefulWidget {
  const AppWrapper({super.key});

  @override
  State<AppWrapper> createState() => _AppWrapperState();
}

class _AppWrapperState extends State<AppWrapper> {
  String _currentView = 'login';
  String _userRole = 'farmer';
  Map<String, dynamic> _currentUser = {};

  void _handleLogin(String role, Map<String, dynamic> userData) {
    setState(() {
      _userRole = role;
      _currentUser = userData;
      _currentView = 'main';
    });
  }

  void _handleLogout() {
    setState(() {
      _currentUser = {};
      _currentView = 'login';
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (_currentView) {
      case 'login':
        return LoginPage(onLogin: _handleLogin);
      case 'main':
        return MainApp(
          onLogout: _handleLogout,
          onNavigateToProfile: () {}, // We'll add later
          currentUser: _currentUser,
          userRole: _userRole,
        );
      default:
        return LoginPage(onLogin: _handleLogin);
    }
  }
}