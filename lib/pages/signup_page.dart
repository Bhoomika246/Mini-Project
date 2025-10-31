import 'package:flutter/material.dart';
import '../services/supabase_service.dart';

class SignupPage extends StatefulWidget {
  final Function(String, Map<String, dynamic>) onSignup;
  
  const SignupPage({super.key, required this.onSignup});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  String _selectedRole = 'user';
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _handleSignup() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      try {
        final userData = {
          'name': _nameController.text,
          'phone': _phoneController.text,
        };

        final response = await SupabaseService.signUp(
          email: _emailController.text,
          password: _passwordController.text,
          userData: userData,
        );

        if (response.user != null) {
          final userInfo = {
            'name': _nameController.text,
            'email': _emailController.text,
            'phone': _phoneController.text,
            'memberSince': '2024',
            'totalBookings': 0,
          };
          widget.onSignup(_selectedRole, userInfo);
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Signup failed: $e')),
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
                // Back Button
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                
                // Logo/Title
                const CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.green,
                  child: Icon(Icons.agriculture, size: 50, color: Colors.white),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Create Account',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.green),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Join Raitha Mithra today',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 32),
                
                // Signup Form
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
                            items: ['user', 'owner']
                                .map((role) => DropdownMenuItem(
                                      value: role,
                                      child: Text(role.toUpperCase()),
                                    ))
                                .toList(),
                            onChanged: (value) => setState(() => _selectedRole = value!),
                            decoration: const InputDecoration(labelText: 'Register As'),
                          ),
                          const SizedBox(height: 16),
                          
                          // Name Field
                          TextFormField(
                            controller: _nameController,
                            decoration: const InputDecoration(labelText: 'Full Name'),
                            validator: (value) => value!.isEmpty ? 'Enter name' : null,
                          ),
                          const SizedBox(height: 16),
                          
                          // Email Field
                          TextFormField(
                            controller: _emailController,
                            decoration: const InputDecoration(labelText: 'Email'),
                            validator: (value) => value!.isEmpty ? 'Enter email' : null,
                          ),
                          const SizedBox(height: 16),
                          
                          // Phone Field
                          TextFormField(
                            controller: _phoneController,
                            decoration: const InputDecoration(labelText: 'Phone'),
                            validator: (value) => value!.isEmpty ? 'Enter phone' : null,
                          ),
                          const SizedBox(height: 16),
                          
                          // Password Field
                          TextFormField(
                            controller: _passwordController,
                            obscureText: true,
                            decoration: const InputDecoration(labelText: 'Password'),
                            validator: (value) => value!.isEmpty ? 'Enter password' : null,
                          ),
                          const SizedBox(height: 24),
                          
                          // Signup Button
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: _isLoading ? null : _handleSignup,
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                backgroundColor: Colors.green,
                              ),
                              child: _isLoading
                                  ? const CircularProgressIndicator(color: Colors.white)
                                  : const Text('SIGN UP', style: TextStyle(color: Colors.white)),
                            ),
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