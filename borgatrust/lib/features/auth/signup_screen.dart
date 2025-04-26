import 'package:borgatrust/features/auth/login_screen.dart';
import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../home/home_screen.dart';
import '../../services/auth.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final AuthService _authService = AuthService();
  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _rememberMe = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _signUp() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        await _authService.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 24, 24, 24),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 24, 24, 24),
            // image: DecorationImage(
            //   image: AssetImage('assets/images/auth_background.jpg'),
            //   fit: BoxFit.cover,
            //   opacity: 0.1, // Subtle background image
            // ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Back button
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => Navigator.of(context).pop(),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        iconSize: 24,
                      ),

                      const SizedBox(height: 24),

                      // Title
                      const Text(
                        'Create your \naccount',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 35,
                          fontWeight: FontWeight.w900,
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Email field label
                      const Text(
                        'Your number & email address',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),

                      const SizedBox(height: 8),

                      // Email field
                      _buildTextField(
                        controller: _emailController,
                        hintText: 'youremail@example.com',
                        obscureText: false,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 20),

                      // Password field label
                      const Text(
                        'Enter your password',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),

                      const SizedBox(height: 8),

                      // Password field
                      _buildTextField(
                        controller: _passwordController,
                        hintText: '••••••••••••',
                        obscureText: _obscurePassword,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                            color: Colors.grey,
                            size: 20,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a password';
                          }
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 20),

                      // Confirm password field label
                      const Text(
                        'Confirm your password',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),

                      const SizedBox(height: 8),

                      // Confirm password field
                      _buildTextField(
                        controller: _confirmPasswordController,
                        hintText: '••••••••••••',
                        obscureText: _obscureConfirmPassword,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureConfirmPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                            color: Colors.grey,
                            size: 20,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureConfirmPassword = !_obscureConfirmPassword;
                            });
                          },
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please confirm your password';
                          }
                          if (value != _passwordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 20),

                      // Remember me checkbox
                      Row(
                        children: [
                          SizedBox(
                            height: 24,
                            width: 24,
                            child: Checkbox(
                              value: _rememberMe,
                              onChanged: (value) {
                                setState(() {
                                  _rememberMe = value!;
                                });
                              },
                              activeColor: const Color(0xFFF5871F), // Orange
                              checkColor: Colors.black,
                              side: const BorderSide(color: Colors.grey),
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Remember me',
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),

                      // Sign up button
                      SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _signUp,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFF5871F), // Orange
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 0,
                            disabledBackgroundColor: const Color(0xFFF5871F).withOpacity(0.5),
                          ),
                          child: _isLoading
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Text(
                                  'Sign up',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Or divider
                      const Row(
                        children: [
                          Expanded(child: Divider(color: Colors.grey, thickness: 0.5)),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Text('Or', style: TextStyle(color: Colors.grey)),
                          ),
                          Expanded(child: Divider(color: Colors.grey, thickness: 0.5)),
                        ],
                      ),

                      const SizedBox(height: 20),

                      // Sign in with Google
                      _buildSocialButton(
                        onPressed: () {
                          // Implement Google sign in
                        },
                        text: 'Sign up with google',
                        icon: 'assets/images/google_icon.png',
                      ),

                      const SizedBox(height: 12),

                      // Sign in with Facebook
                      _buildSocialButton(
                        onPressed: () {
                          // Implement Facebook sign in
                        },
                        text: 'Sign up with facebook',
                        icon: 'assets/images/facebook_icon.png',
                        iconColor: Colors.blue,
                      ),

                      const SizedBox(height: 20),

                      // Already have account
                      Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              'Already have an account? ',
                              style: TextStyle(color: Colors.grey),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LoginScreen(),
                                  ),
                                );
                              },
                              child: const Text(
                                'Login',
                                style: TextStyle(
                                  color: Color(0xFFF5871F),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required bool obscureText,
    Widget? suffixIcon,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.grey),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: const Color(0xFF1C1C1E), // Dark gray
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFF1C1C1E)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFFF5871F)), // Orange
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red),
        ),
        errorStyle: const TextStyle(color: Colors.red),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
      validator: validator,
    );
  }

  Widget _buildSocialButton({
    required VoidCallback onPressed,
    required String text,
    required String icon,
    Color? iconColor,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          side: const BorderSide(color: Color.fromARGB(255, 55, 55, 55), width: 1),
          foregroundColor: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            iconColor != null ? Icon(Icons.facebook, color: iconColor, size: 24) : Image.asset(icon, width: 24, height: 24),
            const SizedBox(width: 12),
            Text(
              text,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
