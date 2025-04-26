import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const CustomButton({super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary, // Changed from primary to backgroundColor
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
        textStyle: const TextStyle(fontSize: 18),
      ),
      child: Text(text),
    );
  }
}
