import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import '../../../shared/theme/app_theme.dart';
import '../../../shared/widgets/custom_button.dart';
import '../../../shared/widgets/custom_text_field.dart';
import '../../../data/repositories/user_service.dart';
import '../../../shared/widgets/african_pattern_container.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  int _currentStep = 0;
  String? _selectedRole;
  bool _isLoading = false;
  bool _agreedToTerms = false;

  // Controllers for all steps
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  
  // Service Agent specific controllers
  final TextEditingController _businessNameController = TextEditingController();
  final TextEditingController _businessEmailController = TextEditingController();
  final TextEditingController _businessRegNumberController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _serviceAgentFormKey = GlobalKey<FormState>();

  // Document upload variables
  PlatformFile? _idDocument;
  PlatformFile? _businessDocument;
  bool _isUploadingId = false;
  bool _isUploadingBusiness = false;

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _businessNameController.dispose();
    _businessEmailController.dispose();
    _businessRegNumberController.dispose();
    _phoneController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  void _nextStep() {
    if (_currentStep == 0) {
      // Role selection - validate role is selected
      if (_selectedRole != null) {
        setState(() {
          _currentStep = 1;
        });
      }
    } else if (_currentStep == 1) {
      // Basic info - validate form
      if (_formKey.currentState?.validate() ?? false) {
        if (_selectedRole == 'service_agent') {
          setState(() {
            _currentStep = 2;
          });
        } else {
          // Client - go to terms
          setState(() {
            _currentStep = 2;
          });
        }
      }
    } else if (_currentStep == 2) {
      // Service agent business info - validate form
      if (_selectedRole == 'service_agent') {
        if (_serviceAgentFormKey.currentState?.validate() ?? false) {
          setState(() {
            _currentStep = 3; // Go to ID verification
          });
        }
      } else {
        // Client - already at terms step
        setState(() {
          _currentStep = 2; // Stay at terms
        });
      }
    } else if (_currentStep == 3) {
      // ID verification - validate documents
      if (_selectedRole == 'service_agent') {
        if (_validateIdDocuments()) {
          setState(() {
            _currentStep = 4; // Go to terms
          });
        }
      }
    }
  }

  bool _validateIdDocuments() {
    // TODO: Implement actual ID document validation
    // For now, just check if documents are "uploaded"
    if (_idDocument == null || _businessDocument == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please upload all required documents"),
          backgroundColor: AppColors.error,
        ),
      );
      return false;
    }
    return true;
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
    }
  }

  Future<void> _completeSignup() async {
    if (!_agreedToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please agree to the terms and conditions"),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      
      // Prepare signup data
      final signupData = {
        'role': _selectedRole,
        'fullName': _fullNameController.text,
        'email': _emailController.text,
        'phone': _phoneController.text,
        'location': _locationController.text,
      };

      if (_selectedRole == 'service_agent') {
        signupData.addAll({
          'businessName': _businessNameController.text,
          'businessEmail': _businessEmailController.text,
          'businessRegNumber': _businessRegNumberController.text,
        });
      }

      // Use UserService to create account
      final userService = UserService();
      userService.signup(signupData);

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
            content: Text('Signup failed: ${e.toString()}'),
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

  Future<void> _handleGoogleSignUp() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // TODO: Implement Google Sign Up
      await Future.delayed(const Duration(seconds: 2));
      
      // For demo purposes, create a mock user
      final userService = UserService();
      final userData = userService.createUserData(
        fullName: "Google User",
        email: "googleuser@gmail.com",
        role: UserRole.client,
        phone: "+233 20 123 4567",
        location: "Accra, Ghana",
      );
      userService.setUserData(userData);
      
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
            content: Text('Google sign up failed: ${e.toString()}'),
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

  Widget _buildStepIndicator() {
    int totalSteps = _selectedRole == 'service_agent' ? 5 : 3;
    return Row(
      children: List.generate(totalSteps, (index) {
        bool isActive = index == _currentStep;
        bool isCompleted = index < _currentStep;
        
        return Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            child: Column(
              children: [
                Container(
                  height: 8,
                  decoration: BoxDecoration(
                    color: isActive 
                        ? AppColors.primary 
                        : isCompleted 
                            ? AppColors.primaryLight 
                            : AppColors.textLight.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  _getStepTitle(index),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                    color: isActive 
                        ? AppColors.primary 
                        : isCompleted 
                            ? AppColors.textMedium 
                            : AppColors.textLight,
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  String _getStepTitle(int step) {
    if (_selectedRole == 'service_agent') {
      switch (step) {
        case 0: return 'Role';
        case 1: return 'Basic Info';
        case 2: return 'Business';
        case 3: return 'ID Verify';
        case 4: return 'Terms';
        default: return '';
      }
    } else {
      switch (step) {
        case 0: return 'Role';
        case 1: return 'Details';
        case 2: return 'Terms';
        default: return '';
      }
    }
  }

  Widget _buildCurrentStep() {
    switch (_currentStep) {
      case 0:
        return _buildRoleSelection();
      case 1:
        return _buildBasicInfo();
      case 2:
        return _selectedRole == 'service_agent' 
            ? _buildBusinessInfo() 
            : _buildTermsAndConditions();
      case 3:
        return _selectedRole == 'service_agent' 
            ? _buildIdVerification() 
            : _buildTermsAndConditions();
      case 4:
        return _buildTermsAndConditions();
      default:
        return _buildRoleSelection();
    }
  }

  Widget _buildRoleSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Choose Your Role",
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "Select how you'll use BorgaTrust",
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: AppColors.textMedium,
          ),
        ),
        const SizedBox(height: 32),
        
        // Client Card
        _buildRoleCard(
          title: "I'm a Client",
          subtitle: "Looking for services",
          description: "Find and hire trusted service providers for your projects",
          icon: Icons.person_outline,
          isSelected: _selectedRole == 'client',
          onTap: () => setState(() => _selectedRole = 'client'),
        ),
        
        const SizedBox(height: 16),
        
        // Service Agent Card
        _buildRoleCard(
          title: "I'm a Service Provider",
          subtitle: "Offering services",
          description: "Join our network of verified professionals and grow your business",
          icon: Icons.business_outlined,
          isSelected: _selectedRole == 'service_agent',
          onTap: () => setState(() => _selectedRole = 'service_agent'),
        ),
      ],
    );
  }

  Widget _buildRoleCard({
    required String title,
    required String subtitle,
    required String description,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary.withOpacity(0.1) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.textLight.withOpacity(0.3),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : AppColors.primaryLight.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: isSelected ? Colors.white : AppColors.primary,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? AppColors.primary : AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? AppColors.primary : AppColors.textMedium,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textMedium,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: AppColors.primary,
                size: 24,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildBasicInfo() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Basic Information",
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Tell us about yourself",
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppColors.textMedium,
            ),
          ),
          const SizedBox(height: 32),
          
          CustomTextField(
            label: "Full Name",
            hintText: "Enter your full name",
            controller: _fullNameController,
            isRequired: true,
            prefix: const Icon(Icons.person_outlined, color: AppColors.textLight),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter your full name";
              }
              return null;
            },
          ),
          
          const SizedBox(height: 20),
          
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
          
          CustomTextField(
            label: "Password",
            hintText: "Create a strong password",
            controller: _passwordController,
            obscureText: true,
            isRequired: true,
            prefix: const Icon(Icons.lock_outlined, color: AppColors.textLight),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter a password";
              }
              if (value.length < 8) {
                return "Password must be at least 8 characters";
              }
              return null;
            },
          ),
          
          const SizedBox(height: 20),
          
          CustomTextField(
            label: "Confirm Password",
            hintText: "Confirm your password",
            controller: _confirmPasswordController,
            obscureText: true,
            isRequired: true,
            prefix: const Icon(Icons.lock_outlined, color: AppColors.textLight),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please confirm your password";
              }
              if (value != _passwordController.text) {
                return "Passwords do not match";
              }
              return null;
            },
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
          
          // Google Sign Up Button
          CustomButton(
            text: "Continue with Google",
            onPressed: _handleGoogleSignUp,
            isGoogleButton: true,
            isLoading: _isLoading,
            googleLogoPath: "assets/images/google_logo.png",
          ),
        ],
      ),
    );
  }

  Widget _buildBusinessInfo() {
    return Form(
      key: _serviceAgentFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Business Information",
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Tell us about your business",
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppColors.textMedium,
            ),
          ),
          const SizedBox(height: 32),
          
          CustomTextField(
            label: "Business Name",
            hintText: "Enter your business name",
            controller: _businessNameController,
            isRequired: true,
            prefix: const Icon(Icons.business_outlined, color: AppColors.textLight),
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
            controller: _businessEmailController,
            keyboardType: TextInputType.emailAddress,
            isRequired: true,
            prefix: const Icon(Icons.email_outlined, color: AppColors.textLight),
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
            label: "Phone Number",
            hintText: "Enter your phone number",
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            isRequired: true,
            prefix: const Icon(Icons.phone_outlined, color: AppColors.textLight),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter your phone number";
              }
              return null;
            },
          ),
          
          const SizedBox(height: 20),
          
          CustomTextField(
            label: "Location",
            hintText: "Enter your city/location",
            controller: _locationController,
            isRequired: true,
            prefix: const Icon(Icons.location_on_outlined, color: AppColors.textLight),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter your location";
              }
              return null;
            },
          ),
          
          const SizedBox(height: 20),
          
          CustomTextField(
            label: "Business Registration Number",
            hintText: "Enter registration number (optional)",
            controller: _businessRegNumberController,
            prefix: const Icon(Icons.numbers_outlined, color: AppColors.textLight),
          ),
        ],
      ),
    );
  }

  Widget _buildTermsAndConditions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Terms & Conditions",
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "Please review and accept our terms",
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: AppColors.textMedium,
          ),
        ),
        const SizedBox(height: 32),
        
        Container(
          padding: const EdgeInsets.all(20),
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
                  Icon(Icons.description_outlined, color: AppColors.primary, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    "Terms of Service",
                    style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                "By creating an account, you agree to our Terms of Service and Privacy Policy. You acknowledge that you have read and understood our community guidelines and agree to comply with them.",
                style: TextStyle(
                  color: AppColors.textMedium,
                  fontSize: 14,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
        
        const SizedBox(height: 24),
        
        Row(
          children: [
            Checkbox(
              value: _agreedToTerms,
              activeColor: AppColors.primary,
              onChanged: (value) {
                setState(() {
                  _agreedToTerms = value ?? false;
                });
              },
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
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // TODO: Show terms of service
                        },
                    ),
                    const TextSpan(text: " and "),
                    TextSpan(
                      text: "Privacy Policy",
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // TODO: Show privacy policy
                        },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildIdVerification() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Identity Verification",
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "Please upload required documents for verification",
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: AppColors.textMedium,
          ),
        ),
        const SizedBox(height: 32),
        
        // ID Document Upload
        _buildDocumentUploadCard(
          title: "Government-Issued ID",
          subtitle: "National ID, Passport, or Driver's License",
          description: "Upload a clear photo of your government-issued identification document",
          icon: Icons.credit_card,
          document: _idDocument,
          isUploading: _isUploadingId,
          onUpload: () => _uploadDocument('id'),
        ),
        
        const SizedBox(height: 20),
        
        // Business Document Upload
        _buildDocumentUploadCard(
          title: "Business Registration",
          subtitle: "Business License or Registration Certificate",
          description: "Upload your business registration document (if applicable)",
          icon: Icons.business,
          document: _businessDocument,
          isUploading: _isUploadingBusiness,
          onUpload: () => _uploadDocument('business'),
        ),
        
        const SizedBox(height: 24),
        
        // Dummy ML Kit verification button
        CustomButton(
          text: "Verify with ML Kit (Demo)",
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('ML Kit Verification'),
                content: const Text('ML Kit document verification coming soon!'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
          },
          isPrimary: false,
        ),
        
        const SizedBox(height: 24),
        
        // Security notice
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.primaryLight.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.primaryLight.withOpacity(0.3)),
          ),
          child: Row(
            children: [
              Icon(Icons.security, color: AppColors.primary, size: 20),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  "Your documents are encrypted and securely stored. We only use them for verification purposes.",
                  style: TextStyle(
                    color: AppColors.textMedium,
                    fontSize: 14,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDocumentUploadCard({
    required String title,
    required String subtitle,
    required String description,
    required IconData icon,
    required PlatformFile? document,
    required bool isUploading,
    required VoidCallback onUpload,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: document != null 
              ? AppColors.success 
              : AppColors.textLight.withOpacity(0.3),
          width: document != null ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: document != null 
                      ? AppColors.success.withOpacity(0.1)
                      : AppColors.primaryLight.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: document != null 
                      ? AppColors.success 
                      : AppColors.primary,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: document != null 
                            ? AppColors.success 
                            : AppColors.textDark,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: document != null 
                            ? AppColors.success 
                            : AppColors.textMedium,
                      ),
                    ),
                  ],
                ),
              ),
              if (document != null)
                Icon(
                  Icons.check_circle,
                  color: AppColors.success,
                  size: 24,
                ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textMedium,
              height: 1.4,
            ),
          ),
          if (document != null) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.success.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: AppColors.success.withOpacity(0.3),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.description,
                    color: AppColors.success,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          document.name,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textDark,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          '${(document.size / 1024 / 1024).toStringAsFixed(2)} MB',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.textMedium,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        if (title.contains('ID')) {
                          _idDocument = null;
                        } else {
                          _businessDocument = null;
                        }
                      });
                    },
                    icon: const Icon(
                      Icons.close,
                      color: AppColors.error,
                      size: 20,
                    ),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(height: 16),
          CustomButton(
            text: isUploading 
                ? "Uploading..." 
                : document != null ? "Change Document" : "Upload Document",
            onPressed: isUploading ? () {} : onUpload,
            isPrimary: document == null && !isUploading,
            isFullWidth: true,
            isLoading: isUploading,
          ),
        ],
      ),
    );
  }

  Future<void> _uploadDocument(String type) async {
    try {
      setState(() {
        if (type == 'id') {
          _isUploadingId = true;
        } else {
          _isUploadingBusiness = true;
        }
      });

      // Pick file
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx', 'jpg', 'jpeg', 'png'],
        allowMultiple: false,
      );

      if (result != null && result.files.isNotEmpty) {
        final file = result.files.first;
        
        // Validate file size (max 10MB)
        if (file.size > 10 * 1024 * 1024) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('File size must be less than 10MB'),
              backgroundColor: AppColors.error,
            ),
          );
          return;
        }

        setState(() {
          if (type == 'id') {
            _idDocument = file;
            _isUploadingId = false;
          } else {
            _businessDocument = file;
            _isUploadingBusiness = false;
          }
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${type.toUpperCase()} document uploaded successfully: ${file.name}'),
            backgroundColor: AppColors.success,
          ),
        );
      } else {
        setState(() {
          if (type == 'id') {
            _isUploadingId = false;
          } else {
            _isUploadingBusiness = false;
          }
        });
      }
    } catch (e) {
      setState(() {
        if (type == 'id') {
          _isUploadingId = false;
        } else {
          _isUploadingBusiness = false;
        }
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error uploading document: ${e.toString()}'),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AfricanPatternContainer(
      opacity: 0.03,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Step indicator
            _buildStepIndicator(),
            
            const SizedBox(height: 32),
            
            // Current step content
            _buildCurrentStep(),
            
            const SizedBox(height: 40),
            
            // Navigation buttons
            Row(
              children: [
                if (_currentStep > 0)
                  Expanded(
                    child: CustomButton(
                      text: "Back",
                      onPressed: _previousStep,
                      isPrimary: false,
                    ),
                  ),
                
                if (_currentStep > 0) const SizedBox(width: 16),
                
                Expanded(
                  child: CustomButton(
                    text: _currentStep == (_selectedRole == 'service_agent' ? 4 : 2) 
                        ? "Create Account" 
                        : "Next",
                    onPressed: _currentStep == (_selectedRole == 'service_agent' ? 4 : 2)
                        ? () async {
                            await _completeSignup();
                            // Dummy email verification dialog
                            if (mounted) {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('Verify Your Email'),
                                  content: const Text('A verification link has been sent to your email. Please check your inbox to verify your account. (Demo only)'),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.of(context).pop(),
                                      child: const Text('OK'),
                                    ),
                                  ],
                                ),
                              );
                            }
                          }
                        : _nextStep,
                    isLoading: _isLoading,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
