// File: lib/presentation/screens/auth/login_screen.dart

import 'package:flutter/material.dart';
import '../../../shared/theme/app_theme.dart';
import '../../../shared/widgets/custom_button.dart';
import '../../../shared/widgets/custom_text_field.dart';
import '../../../data/repositories/user_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  bool _isLoading = false;
  bool _isGoogleLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true;
      });

      try {
        // Simulate authentication
        await Future.delayed(const Duration(seconds: 1));
        // Dummy logic: only allow password 'password123'
        if (_passwordController.text != 'password123') {
          throw Exception('Invalid email or password.');
        }
        final userService = UserService();
        userService.login(_emailController.text, _passwordController.text);

        if (mounted) {
          Navigator.of(context).pushNamedAndRemoveUntil(
            '/main',
            (Route<dynamic> route) => false,
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Login failed: Invalid email or password.'),
              backgroundColor: AppColors.error,
            ),
          );
        }
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }
  }

  Future<void> _handleGoogleSignIn() async {
    setState(() {
      _isGoogleLoading = true;
    });

    try {
      // TODO: Implement Google Sign In (Firebase)
      await Future.delayed(const Duration(seconds: 1));
      if (mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Coming Soon'),
            content: const Text('Google sign-in will be available in a future update.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isGoogleLoading = false;
        });
      }
    }
  }

  void _showForgotPasswordDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Forgot Password?'),
        content: const Text('A password reset link would be sent to your email (demo only).'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome text
            Text(
              "Welcome Back",
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.textDark,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Sign in to your account to continue",
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.textMedium,
              ),
            ),
            
            const SizedBox(height: 32),
            
            // Email field
            CustomTextField(
              label: "Email Address",
              hintText: "Enter your email address",
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              isRequired: true,
              prefix: const Icon(Icons.email_outlined, color: AppColors.textLight),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter your email address";
                }
                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                  return "Please enter a valid email address";
                }
                return null;
              },
            ),
            
            const SizedBox(height: 20),
            
            // Password field
            CustomTextField(
              label: "Password",
              hintText: "Enter your password",
              controller: _passwordController,
              obscureText: _obscurePassword,
              isRequired: true,
              prefix: const Icon(Icons.lock_outlined, color: AppColors.textLight),
              suffix: IconButton(
                icon: Icon(
                  _obscurePassword ? Icons.visibility_off : Icons.visibility,
                  color: AppColors.textLight,
                ),
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter your password";
                }
                if (value.length < 8) {
                  return "Password must be at least 8 characters";
                }
                return null;
              },
            ),
            
            const SizedBox(height: 16),
            
            // Forgot password
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: _showForgotPasswordDialog,
                child: const Text(
                  'Forgot Password?',
                  style: TextStyle(color: AppColors.primary),
                ),
              ),
            ),
            
            const SizedBox(height: 32),
            
            // Sign in button
            CustomButton(
              text: "Sign In",
              onPressed: _login,
              isLoading: _isLoading,
            ),
            
            const SizedBox(height: 24),
            
            // Divider
            Row(
              children: [
                const Expanded(child: Divider(color: AppColors.textLight)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    "or",
                    style: TextStyle(
                      color: AppColors.textLight,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const Expanded(child: Divider(color: AppColors.textLight)),
              ],
            ),
            
            const SizedBox(height: 24),
            
            // Google Sign In Button
            CustomButton(
              text: 'Sign in with Google',
              onPressed: _handleGoogleSignIn,
              isPrimary: false,
              isFullWidth: true,
              isLoading: _isGoogleLoading,
              leadingIcon: const Icon(Icons.g_mobiledata, color: Colors.red),
            ),
            
            const SizedBox(height: 24),
            
            // Demo credentials hint
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.primaryLight.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.primaryLight.withOpacity(0.3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.info_outline, color: AppColors.primary, size: 20),
                      const SizedBox(width: 8),
                      Text(
                        "Demo Credentials",
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Client: client@example.com / password123\nAgent: agent@example.com / password123",
                    style: TextStyle(
                      color: AppColors.textMedium,
                      fontSize: 12,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

