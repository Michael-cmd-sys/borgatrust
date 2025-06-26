import 'package:flutter/material.dart';
import '../../utils/app_theme.dart';
import '../custom_text_field.dart';

class ServiceAgentSignupStep2Details extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController businessNameController;
  final TextEditingController businessEmailController;
  final TextEditingController businessRegNumberController; // Example: Business Registration Number
  final TextEditingController agentFullNameController;
  final TextEditingController agentEmailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  const ServiceAgentSignupStep2Details({
    super.key,
    required this.formKey,
    required this.businessNameController,
    required this.businessEmailController,
    required this.businessRegNumberController,
    required this.agentFullNameController,
    required this.agentEmailController,
    required this.passwordController,
    required this.confirmPasswordController,
  });

  @override
  State<ServiceAgentSignupStep2Details> createState() => _ServiceAgentSignupStep2DetailsState();
}

class _ServiceAgentSignupStep2DetailsState extends State<ServiceAgentSignupStep2Details> {
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Business Details",
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          CustomTextField(
            label: "Business Name",
            hintText: "Enter your business name",
            controller: widget.businessNameController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter your business name";
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          CustomTextField(
            label: "Business Email",
            hintText: "Enter your business email",
            controller: widget.businessEmailController,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter your business email";
              }
              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                return "Please enter a valid business email";
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          CustomTextField(
            label: "Business Registration Number (Optional)",
            hintText: "Enter your business registration number",
            controller: widget.businessRegNumberController,
            // No validator means it's optional
          ),

          const SizedBox(height: 32),
          Text(
            "Account Holder Details",
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          CustomTextField(
            label: "Your Full Name (Agent/Owner)",
            hintText: "Enter your full name",
            controller: widget.agentFullNameController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter your full name";
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          CustomTextField(
            label: "Your Email (for login)",
            hintText: "Enter your email for account login",
            controller: widget.agentEmailController,
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
        ],
      ),
    );
  }
}
