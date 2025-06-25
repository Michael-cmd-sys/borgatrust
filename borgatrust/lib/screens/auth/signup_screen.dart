import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import '../../utils/app_theme.dart';
import '../../widgets/custom_button.dart';
// CustomTextField is not directly used in signup_screen anymore, but kept if needed by future direct modifications.
// import '../../widgets/custom_text_field.dart';
import '../../widgets/auth/client_signup_form.dart';
import '../../widgets/auth/service_agent_signup_step1_doc.dart';
import '../../widgets/auth/service_agent_signup_step2_details.dart';
import 'package:file_picker/file_picker.dart'; // For PlatformFile type

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _agreedToTerms = false;

  // 0: Role selection, 1: Client form,
  // For Service Agent: 2: Doc Upload (Step 1), 3: Details Form (Step 2)
  int _currentStep = 0;
  String? _selectedRole; // 'client' or 'service_agent'

  // Controllers for Service Agent Step 2
  final TextEditingController _businessNameController = TextEditingController();
  final TextEditingController _businessEmailController = TextEditingController();
  final TextEditingController _businessRegNumberController = TextEditingController();
  final TextEditingController _agentFullNameController = TextEditingController(); // Different from client's _fullNameController
  final TextEditingController _agentEmailController = TextEditingController(); // Different from client's _emailController
  // Password controllers can be reused if we ensure they are cleared, or use separate ones.
  // For clarity, let's use separate ones for service agent, though they share same var names as client form for now.
  // final TextEditingController _agentPasswordController = TextEditingController();
  // final TextEditingController _agentConfirmPasswordController = TextEditingController();
  // Reusing _passwordController and _confirmPasswordController for service agent as well.
  // Ensure they are cleared when switching forms or roles if necessary.

  PlatformFile? _pickedBusinessDocument;
  final _serviceAgentFormKey = GlobalKey<FormState>(); // Separate form key for service agent details

  @override
  void dispose() {
    _fullNameController.dispose(); // Client form
    _businessNameController.dispose();
    _businessEmailController.dispose();
    _businessRegNumberController.dispose();
    _agentFullNameController.dispose();
    _agentEmailController.dispose();
    // _agentPasswordController.dispose();
    // _agentConfirmPasswordController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _signup() {
    if (_formKey.currentState?.validate() ?? false) {
      if (!_agreedToTerms) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Please agree to the terms and conditions"),
            backgroundColor: AppColors.error,
          ),
        );
        return;
      }
      
      // In a real app, implement proper registration
      Navigator.of(context).pushNamedAndRemoveUntil(
        '/main',
        (Route<dynamic> route) => false,
      );
    }
  }

  Widget _buildRoleSelectionStep(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        Text(
          "Create Account As",
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          "Choose whether you're looking for services or offering them.",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 32),
        CustomButton(
          text: "Client",
          onPressed: () {
            setState(() {
              _selectedRole = 'client';
              _currentStep = 1; // Move to client form
            });
          },
          isPrimary: _selectedRole == 'client',
        ),
        const SizedBox(height: 16),
        CustomButton(
          text: "Service Agent (Business)",
          onPressed: () {
            setState(() {
              _selectedRole = 'service_agent';
              _currentStep = 2; // Move to Service Agent Step 1: Document Upload
              _clearClientFormFields(); // Clear client fields if switching
            });
          },
          isPrimary: _selectedRole == 'service_agent',
        ),
        const SizedBox(height: 32),
      ],
    );
  }

  Widget _buildClientForm(BuildContext context) {
    return Column(
      children: [
        ClientSignupForm(
          formKey: _formKey, // Use the existing _formKey from SignupScreen state
          fullNameController: _fullNameController,
          emailController: _emailController,
          passwordController: _passwordController,
          confirmPasswordController: _confirmPasswordController,
          agreedToTerms: _agreedToTerms,
          onAgreeToTermsChanged: (value) {
            setState(() {
              _agreedToTerms = value;
            });
          },
          onSignup: _signup, // Use the existing _signup method
          onGoogleSignup: () {
            // TODO: Implement Google Sign up
          },
          onAppleSignup: () {
            // TODO: Implement Apple Sign up
          },
          onFacebookSignup: () {
            // TODO: Implement Facebook Sign up
          },
          onShowTerms: () {
            // TODO: Implement show terms
          },
          onShowPrivacy: () {
            // TODO: Implement show privacy policy
          },
        ),
        const SizedBox(height: 16),
        TextButton(
          onPressed: () {
            setState(() {
              _currentStep = 0; // Go back to role selection
              _selectedRole = null;
              _clearClientFormFields();
            });
          },
          child: const Text("Back to role selection"),
        ),
      ],
    );
  }

  void _clearClientFormFields() {
    _formKey.currentState?.reset();
    _fullNameController.clear();
    _emailController.clear();
    _passwordController.clear();
    _confirmPasswordController.clear();
    _agreedToTerms = false;
  }

  void _clearServiceAgentFormFields() {
    _serviceAgentFormKey.currentState?.reset();
    _businessNameController.clear();
    _businessEmailController.clear();
    _businessRegNumberController.clear();
    _agentFullNameController.clear();
    _agentEmailController.clear();
    _passwordController.clear(); // Assuming reuse, clear them
    _confirmPasswordController.clear(); // Assuming reuse, clear them
    _pickedBusinessDocument = null;
    _agreedToTerms = false; // Reset terms for service agent too
  }


  Widget _buildServiceAgentStep1DocUpload(BuildContext context) {
    return Column(
      children: [
        ServiceAgentSignupStep1Doc(
          pickedFile: _pickedBusinessDocument,
          onFilePicked: (file) {
            setState(() {
              _pickedBusinessDocument = file;
            });
          },
        ),
        const SizedBox(height: 32),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () {
                setState(() {
                  _currentStep = 0; // Go back to role selection
                  _selectedRole = null;
                  _clearServiceAgentFormFields();
                });
              },
              child: const Text("Back to Roles"),
            ),
            CustomButton(
              text: "Next",
              onPressed: () {
                if (_pickedBusinessDocument != null) {
                  setState(() {
                    _currentStep = 3; // Move to Step 2: Details
                  });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Please select a business document to continue."),
                      backgroundColor: AppColors.error,
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildServiceAgentStep2Details(BuildContext context) {
    return Column(
      children: [
        ServiceAgentSignupStep2Details(
          formKey: _serviceAgentFormKey,
          businessNameController: _businessNameController,
          businessEmailController: _businessEmailController,
          businessRegNumberController: _businessRegNumberController,
          agentFullNameController: _agentFullNameController,
          agentEmailController: _agentEmailController,
          passwordController: _passwordController, // Reusing for now
          confirmPasswordController: _confirmPasswordController, // Reusing for now
        ),
        const SizedBox(height: 20),
        _buildTermsAndConditions(context), // Re-use T&C for service agent
        const SizedBox(height: 32),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () {
                setState(() {
                  _currentStep = 2; // Go back to Step 1: Doc Upload
                });
              },
              child: const Text("Back"),
            ),
            CustomButton(
              text: "Create Service Agent Account",
              onPressed: _signupServiceAgent,
            ),
          ],
        ),
         const SizedBox(height: 16),
         TextButton(
            onPressed: () {
              setState(() {
                _currentStep = 0; // Go back to role selection
                _selectedRole = null;
                _clearServiceAgentFormFields();
              });
            },
            child: const Text("Back to role selection"),
          ),
      ],
    );
  }

  void _signupServiceAgent() {
    if (_serviceAgentFormKey.currentState?.validate() ?? false) {
      if (_pickedBusinessDocument == null) {
         ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Business document is missing."),
            backgroundColor: AppColors.error,
          ),
        );
        return;
      }
      if (!_agreedToTerms) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Please agree to the terms and conditions"),
            backgroundColor: AppColors.error,
          ),
        );
        return;
      }
      // In a real app, implement proper registration for service agent
      // This would involve uploading the _pickedBusinessDocument and saving other details
      print("Service Agent Signup Initiated");
      print("Business Name: ${_businessNameController.text}");
      print("Business Email: ${_businessEmailController.text}");
      print("Document: ${_pickedBusinessDocument!.name}");
      print("Agent Name: ${_agentFullNameController.text}");
      // ... etc.

      Navigator.of(context).pushNamedAndRemoveUntil(
        '/main', // Placeholder
        (Route<dynamic> route) => false,
      );
    }
  }

  Widget _buildTermsAndConditions(BuildContext context) {
    return Row(
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
                      // Show terms of service
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
                      // Show privacy policy
                    },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOrDivider(BuildContext context) {
    return const Row(
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
    );
  }

  Widget _buildSocialLoginButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _socialLoginButton(
          icon: Icons.facebook,
          color: const Color(0xFF3B5998),
          onPressed: () {},
        ),
        const SizedBox(width: 20),
        _socialLoginButton(
          icon: Icons.g_mobiledata, // Assuming this is for Google
          color: const Color(0xFFDB4437),
          onPressed: () {},
        ),
        const SizedBox(width: 20),
        _socialLoginButton(
          icon: Icons.apple,
          color: Colors.black,
          onPressed: () {},
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget currentFormView;
    Key currentFormKey = ValueKey<int>(_currentStep); // Key for AnimatedSwitcher

    if (_currentStep == 0) {
      currentFormView = _buildRoleSelectionStep(context);
    } else if (_currentStep == 1 && _selectedRole == 'client') {
      currentFormView = _buildClientForm(context);
    } else if (_currentStep == 2 && _selectedRole == 'service_agent') {
      currentFormView = _buildServiceAgentStep1DocUpload(context);
    } else if (_currentStep == 3 && _selectedRole == 'service_agent') {
      currentFormView = _buildServiceAgentStep2Details(context);
    }
    else {
      // Fallback to role selection if state is inconsistent
      currentFormView = _buildRoleSelectionStep(context);
      currentFormKey = const ValueKey<String>("role_selection_fallback");
    }

    // Determine which form key to use for the main Form widget
    // The individual forms (ClientSignupForm, ServiceAgentSignupStep2Details) manage their own keys
    // The top-level Form widget in SignupScreen might not be strictly necessary if sub-forms have their own
    // and validation is triggered within those sub-forms.
    // However, keeping it for structure, but its key might not be actively used for validation here.
    // Or, we can remove the top-level Form if sub-forms handle everything.
    // For now, let's assume sub-forms handle their own validation triggers.
    // The _formKey is for client, _serviceAgentFormKey is for service agent step 2.
    // Step 1 (doc upload) doesn't have a Form.

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      // The outer Form might be redundant if inner widgets handle their own Form and GlobalKey
      // For this iteration, we'll keep it simple and assume validation is handled by buttons within each step/form.
      child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(child: child, opacity: animation);
          },
          child: Container( // Use a Container with a Key for AnimatedSwitcher
            key: currentFormKey, // Ensures AnimatedSwitcher properly handles transitions
            child: currentFormView,
          )
        ),
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
