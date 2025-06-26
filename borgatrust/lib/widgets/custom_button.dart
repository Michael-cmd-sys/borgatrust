import 'package:flutter/material.dart';
import '../utils/app_theme.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isPrimary;
  final bool isFullWidth;
  final EdgeInsetsGeometry? padding;
  final double? height;
  final Color? backgroundColor; // Allow overriding background color
  final Color? foregroundColor; // Allow overriding text/icon color
  final ButtonStyle? buttonStyle; // Allow providing a full custom ButtonStyle

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isPrimary = true,
    this.isFullWidth = true,
    this.padding,
    this.height,
    this.backgroundColor,
    this.foregroundColor,
    this.buttonStyle,
  });

  @override
  Widget build(BuildContext context) {
    // Use provided buttonStyle if available, otherwise construct based on other params
    final ButtonStyle effectiveButtonStyle = buttonStyle ??
        (isPrimary
            ? ElevatedButton.styleFrom(
                backgroundColor: backgroundColor ?? AppColors.primary,
                foregroundColor: foregroundColor ?? Colors.white,
                elevation: 0, // Default to 0 elevation for a flatter design consistent with theme
                padding: padding ?? const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                minimumSize: Size(isFullWidth ? double.infinity : 0, height ?? 56),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              )
            : OutlinedButton.styleFrom(
                backgroundColor: backgroundColor, // Outlined buttons typically don't have BG unless specified
                foregroundColor: foregroundColor ?? AppColors.primary,
                side: BorderSide(color: foregroundColor ?? AppColors.primary),
                padding: padding ?? const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                minimumSize: Size(isFullWidth ? double.infinity : 0, height ?? 56),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ));

    return isPrimary
        ? ElevatedButton(
            style: effectiveButtonStyle,
            onPressed: onPressed,
            child: Text(text, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          )
        : OutlinedButton(
            style: effectiveButtonStyle,
            onPressed: onPressed,
            child: Text(text, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          );
  }
}
