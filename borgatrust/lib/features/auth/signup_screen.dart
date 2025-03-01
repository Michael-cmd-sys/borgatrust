import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../core/services/auth_service.dart';
import '../home/home_screen.dart';
import '../../core/widgets/custom_text_field.dart';
import '../../core/widgets/custom_button.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.signupTitle)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CustomTextField(
                controller: _emailController,
                labelText: AppStrings.emailLabel,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppStrings.emailRequired;
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              CustomTextField(
                controller: _passwordController,
                labelText: AppStrings.passwordLabel,
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppStrings.passwordRequired;
                  }
                  return null;
                },
              ),
              SizedBox(height: 30),
              CustomButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    String? result = await _authService.createUserWithEmailAndPassword(
                      _emailController.text,
                      _passwordController.text,
                    );
                    if (result == null) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(result)),
                      );
                    }
                  }
                },
                text: AppStrings.signupButton,
              ),
            ],
          ),
        ),
      ),
    );
  }
}