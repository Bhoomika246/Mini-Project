import 'package:flutter/material.dart';
import 'signup_page.dart';
import '../services/supabase_service.dart';

class LoginPage extends StatefulWidget {
  final Function(String, Map<String, dynamic>) onLogin;
  
  const LoginPage({super.key, required this.onLogin});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String _selectedRole = 'farmer';
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      try {
        final response = await SupabaseService.signIn(
          email: _emailController.text,
          password: _passwordController.text,
        );

        if (response.user != null) {
          final userData = {
            'name': response.user!.userMetadata?['name'] ?? 'User',
            'email': response.user!.email ?? '',
            'phone': response.user!.userMetadata?['phone'] ?? '',
            'memberSince': '2024',
            'totalBookings': 0,
          };
          widget.onLogin(_selectedRole, userData);
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Login failed: $e')),
          );
        }
      } finally {
        if (mounted) {
          setState(() => _isLoading = false);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFE3F2FD), Color(0xFFF3E5F5)],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                // Logo/Title
                const CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.green,
                  child: Icon(Icons.agriculture, size: 50, color: Colors.white),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Raitha Mithra',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.green),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Agricultural Machinery Rental',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 32),
                
                // Login Form
                Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          // Role Selection
                          DropdownButtonFormField<String>(
                            initialValue: _selectedRole,
                            items: ['farmer', 'owner']
                                .map((role) => DropdownMenuItem(
                                      value: role,
                                      child: Text(role.toUpperCase()),
                                    ))
                                .toList(),
                            onChanged: (value) => setState(() => _selectedRole = value!),
                            decoration: const InputDecoration(labelText: 'Login As'),
                          ),
                          const SizedBox(height: 16),
                          
                          // Email Field
                          TextFormField(
                            controller: _emailController,
                            decoration: const InputDecoration(labelText: 'Email'),
                            validator: (value) => value!.isEmpty ? 'Enter email' : null,
                          ),
                          const SizedBox(height: 16),

                          // Password Field
                          TextFormField(
                            controller: _passwordController,
                            decoration: const InputDecoration(labelText: 'Password'),
                            obscureText: true,
                            validator: (value) => value!.isEmpty ? 'Enter password' : null,
                          ),
                          const SizedBox(height: 24),
                          
                          // Login Button
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: _isLoading ? null : _handleLogin,
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                backgroundColor: Colors.green,
                              ),
                              child: _isLoading
                                  ? const CircularProgressIndicator(color: Colors.white)
                                  : const Text('LOGIN', style: TextStyle(color: Colors.white)),
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignupPage(
                                    onSignup: (role, userData) {
                                      // Auto-login after signup
                                      widget.onLogin(role, userData);
                                    },
                                  ),
                                ),
                              );
                            },
                            child: const Text('Don\'t have an account? Sign up'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}