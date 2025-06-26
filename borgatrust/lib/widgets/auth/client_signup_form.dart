import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../utils/app_theme.dart';
import '../custom_button.dart';
import '../custom_text_field.dart';

class ClientSignupForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController fullNameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final VoidCallback onSignup;
  final VoidCallback onGoogleSignup;
  final VoidCallback onAppleSignup;
  final VoidCallback onFacebookSignup; // Added for completeness, though not explicitly in plan
  final VoidCallback onShowTerms;
  final VoidCallback onShowPrivacy;
  final Function(bool) onAgreeToTermsChanged;
  final bool agreedToTerms;

  const ClientSignupForm({
    super.key,
    required this.formKey,
    required this.fullNameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.onSignup,
    required this.onGoogleSignup,
    required this.onAppleSignup,
    required this.onFacebookSignup,
    required this.onShowTerms,
    required this.onShowPrivacy,
    required this.onAgreeToTermsChanged,
    required this.agreedToTerms,
  });

  @override
  State<ClientSignupForm> createState() => _ClientSignupFormState();
}

class _ClientSignupFormState extends State<ClientSignupForm> {
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          CustomTextField(
            label: "Full Name",
            hintText: "Enter your full name",
            controller: widget.fullNameController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter your full name";
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          CustomTextField(
            label: "Email",
            hintText: "Enter your email",
            controller: widget.emailController,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter your email";
              }
              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                return "Please enter a valid email";
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          CustomTextField(
            label: "Password",
            hintText: "Enter your password",
            controller: widget.passwordController,
            obscureText: _obscurePassword,
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
              if (value.length < 6) {
                return "Password must be at least 6 characters";
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          CustomTextField(
            label: "Confirm Password",
            hintText: "Confirm your password",
            controller: widget.confirmPasswordController,
            obscureText: _obscureConfirmPassword,
            suffix: IconButton(
              icon: Icon(
                _obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
                color: AppColors.textLight,
              ),
              onPressed: () {
                setState(() {
                  _obscureConfirmPassword = !_obscureConfirmPassword;
                });
              },
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please confirm your password";
              }
              if (value != widget.passwordController.text) {
                return "Passwords do not match";
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Checkbox(
                value: widget.agreedToTerms,
                activeColor: AppColors.primary,
                onChanged: (value) => widget.onAgreeToTermsChanged(value ?? false),
              ),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(color: AppColors.textMedium, fontSize: 14),
                    children: [
                      const TextSpan(text: "I agree to the "),
                      TextSpan(
                        text: "Terms of Service",
                        style: const TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                        recognizer: TapGestureRecognizer()..onTap = widget.onShowTerms,
                      ),
                      const TextSpan(text: " and "),
                      TextSpan(
                        text: "Privacy Policy",
                        style: const TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                        recognizer: TapGestureRecognizer()..onTap = widget.onShowPrivacy,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          CustomButton(
            text: "Create Client Account",
            onPressed: widget.onSignup,
          ),
          const SizedBox(height: 24),
          const Row(
            children: [
              Expanded(child: Divider()),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "OR",
                  style: TextStyle(
                    color: AppColors.textLight,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Expanded(child: Divider()),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _socialLoginButton(
                icon: Icons.facebook, // Placeholder, replace with actual Facebook icon if available
                color: const Color(0xFF3B5998),
                onPressed: widget.onFacebookSignup,
              ),
              const SizedBox(width: 20),
              _socialLoginButton(
                icon: Icons.g_mobiledata, // Placeholder, replace with actual Google icon
                color: const Color(0xFFDB4437),
                onPressed: widget.onGoogleSignup,
              ),
              const SizedBox(width: 20),
              _socialLoginButton(
                icon: Icons.apple,
                color: Colors.black,
                onPressed: widget.onAppleSignup,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _socialLoginButton({
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(50),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Icon(
          icon,
          color: color,
          size: 30,
        ),
      ),
    );
  }
}
