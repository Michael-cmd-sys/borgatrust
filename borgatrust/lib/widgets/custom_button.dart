import 'package:flutter/material.dart';
import '../utils/app_theme.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isPrimary;
  final bool isFullWidth;
  final EdgeInsetsGeometry? padding;
  final double? height;

  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.isPrimary = true,
    this.isFullWidth = true,
    this.padding,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final buttonStyle = isPrimary
        ? ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            elevation: 0,
            padding: padding ?? const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            minimumSize: Size(isFullWidth ? double.infinity : 0, height ?? 56),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          )
        : OutlinedButton.styleFrom(
            foregroundColor: AppColors.primary,
            side: const BorderSide(color: AppColors.primary),
            padding: padding ?? const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            minimumSize: Size(isFullWidth ? double.infinity : 0, height ?? 56),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          );

    return isPrimary
        ? ElevatedButton(
            style: buttonStyle,
            onPressed: onPressed,
            child: Text(text, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          )
        : OutlinedButton(
            style: buttonStyle,
            onPressed: onPressed,
            child: Text(text, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          );
  }
}
