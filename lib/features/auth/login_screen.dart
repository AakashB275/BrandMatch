import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:supabase_flutter/supabase_flutter.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final supabase = Supabase.instance.client;
  bool _isObscure = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    // Validate form first
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    String phoneText = _phoneController.text.trim();
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    try {
      // Step 1: Create authentication account
      final AuthResponse response = await supabase.auth.signUp(
        email: email,
        password: password,
        data: {'phone': phoneText},
        emailRedirectTo: kIsWeb 
            ? 'https://your-app-url.com/auth/callback' 
            : null,
      );

      if (response.user != null) {
        // Step 2: Insert user data into your table
        await _insertUserData(
          authUserId: response.user!.id,
          phone: phoneText,
          email: email,
        );

        if (mounted) {
          await _showMessageDialog(
            "Registration successful! Please check your email for verification.",
            isSuccess: true,
          );
        }
      } else {
        if (mounted) {
          await _showMessageDialog(
            "Registration failed. Please try again.",
            isSuccess: false,
          );
        }
      }
    } on AuthException catch (e) {
      if (mounted) {
        String errorMessage = "Registration failed: ${e.message}";
        
        // Handle specific error cases
        if (e.message.contains('already registered')) {
          errorMessage = "This email is already registered. Please login instead.";
        } else if (e.message.contains('weak password')) {
          errorMessage = "Password is too weak. Please use a stronger password.";
        }
        
        await _showMessageDialog(errorMessage, isSuccess: false);
      }
    } catch (e) {
      if (mounted) {
        String errorMessage = "An unexpected error occurred: ${e.toString()}";
        
        if (kIsWeb) {
          errorMessage = "Network error on web. Please check CORS settings and try again.";
        }
        
        await _showMessageDialog(errorMessage, isSuccess: false);
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _insertUserData({
    required String authUserId,
    required String phone,
    required String email,
  }) async {
    try {
      await supabase.from('users').insert({
        'auth_user_id': authUserId,
        'phone': phone,
        'email': email,
        'role': 'Employee',
        'created_at': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      print("Error inserting user data: $e");
      throw Exception('Failed to create user profile');
    }
  }

  Future<void> _showMessageDialog(String message, {required bool isSuccess}) async {
    if (!mounted) return;
    
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text(isSuccess ? "Success" : "Error"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              if (isSuccess && mounted) {
                // Navigate to role selection after successful registration
                context.go('/role');
              }
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    
    return Scaffold(
      appBar: AppBar(title: const Text('Welcome')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Sign up to create account',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 16),
                    
                    // Email Field
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.email_outlined),
                        hintText: 'example@email.com',
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Email is required";
                        } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                            .hasMatch(value.trim())) {
                          return "Enter a valid email";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    
                    // Password Field
                    TextFormField(
                      controller: _passwordController,
                      obscureText: _isObscure,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: const Icon(Icons.lock_outlined),
                        hintText: 'At least 6 characters',
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isObscure
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                          ),
                          onPressed: () {
                            setState(() {
                              _isObscure = !_isObscure;
                            });
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Password is required";
                        } else if (value.length < 6) {
                          return "Password must be at least 6 characters";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    
                    // Phone Field
                    TextFormField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        labelText: 'Phone number',
                        prefixIcon: Icon(Icons.phone_outlined),
                        hintText: '+1 555 555 5555',
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Phone number is required";
                        }
                        
                        // Remove spaces, dashes, and other non-digit characters for validation
                        String digitsOnly = value.replaceAll(RegExp(r'\D'), '');
                        
                        if (digitsOnly.length < 10) {
                          return "Phone number must be at least 10 digits";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8),
                    
                    Text(
                      'We\'ll verify via email link and OTP to secure your account.',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: cs.onSurfaceVariant),
                    ),
                    const SizedBox(height: 24),
                    
                    // Register Button
                    FilledButton(
                      onPressed: _isLoading ? null : _register,
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: _isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Text(
                              "Register",
                              style: TextStyle(fontSize: 16),
                            ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Login Link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account? ',
                          style: TextStyle(color: cs.onSurfaceVariant),
                        ),
                        TextButton(
                          onPressed: () => context.go('/login'),
                          child: const Text('Login'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}