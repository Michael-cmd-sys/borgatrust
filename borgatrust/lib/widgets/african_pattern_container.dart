import 'package:flutter/material.dart';
import '../utils/app_theme.dart';

class AfricanPatternContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final double opacity;

  const AfricanPatternContainer({
    Key? key,
    required this.child,
    this.padding = const EdgeInsets.all(20),
    this.opacity = 0.03,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: AppColors.background,
        image: DecorationImage(
          image: const AssetImage('assets/images/borgatrust_logo.png'),
          opacity: opacity,
          repeat: ImageRepeat.repeat,
          scale: 10.0,
        ),
      ),
      child: child,
    );
  }
}