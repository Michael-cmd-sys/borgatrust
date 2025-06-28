import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

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
  final Widget? leadingIcon;
  final bool isLoading;
  final bool isGoogleButton;
  final String? googleLogoPath;

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
    this.leadingIcon,
    this.isLoading = false,
    this.isGoogleButton = false,
    this.googleLogoPath,
  });

  @override
  Widget build(BuildContext context) {
    // Google button styling
    if (isGoogleButton) {
      return SizedBox(
        width: isFullWidth ? double.infinity : null,
        height: height ?? 56,
        child: OutlinedButton.icon(
          onPressed: isLoading ? null : onPressed,
          icon: isLoading 
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : leadingIcon ?? (googleLogoPath != null 
                ? Container(
                    width: 20,
                    height: 20,
                    child: Image.asset(
                      googleLogoPath!,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.g_mobiledata, color: Color(0xFFDB4437));
                      },
                    ),
                  )
                : const Icon(Icons.g_mobiledata, color: Color(0xFFDB4437))),
          label: Text(
            text,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFFDB4437),
            ),
          ),
          style: OutlinedButton.styleFrom(
            backgroundColor: Colors.white,
            side: const BorderSide(color: Color(0xFFDB4437)),
            padding: padding ?? const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
      );
    }

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

    Widget buttonChild = leadingIcon != null
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              leadingIcon!,
              const SizedBox(width: 12),
              Text(
                text,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ],
          )
        : isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Text(text, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600));

    return isPrimary
        ? ElevatedButton(
            style: effectiveButtonStyle,
            onPressed: isLoading ? null : onPressed,
            child: buttonChild,
          )
        : OutlinedButton(
            style: effectiveButtonStyle,
            onPressed: isLoading ? null : onPressed,
            child: buttonChild,
          );
  }
}
