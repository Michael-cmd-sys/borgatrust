import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class AfricanPatternContainer extends StatelessWidget {
  final Widget child;
  final double opacity;
  final bool useGradient;
  final bool usePattern;

  const AfricanPatternContainer({
    super.key,
    required this.child,
    this.opacity = 0.05,
    this.useGradient = true,
    this.usePattern = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: useGradient ? AppColors.backgroundGradient : null,
        color: useGradient ? null : AppColors.background,
      ),
      child: Stack(
        children: [
          if (usePattern) _buildElegantPattern(),
          child,
        ],
      ),
    );
  }

  Widget _buildElegantPattern() {
    return Positioned.fill(
      child: CustomPaint(
        painter: ElegantPatternPainter(opacity: opacity),
      ),
    );
  }
}

class ElegantPatternPainter extends CustomPainter {
  final double opacity;

  ElegantPatternPainter({this.opacity = 0.05});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.primary.withOpacity(opacity)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    final fillPaint = Paint()
      ..color = AppColors.primary.withOpacity(opacity * 0.3)
      ..style = PaintingStyle.fill;

    // Draw elegant geometric patterns
    _drawGeometricPattern(canvas, size, paint, fillPaint);
    _drawSubtleDots(canvas, size, paint);
  }

  void _drawGeometricPattern(Canvas canvas, Size size, Paint paint, Paint fillPaint) {
    const double spacing = 80.0;
    const double patternSize = 40.0;

    for (double x = 0; x < size.width + spacing; x += spacing) {
      for (double y = 0; y < size.height + spacing; y += spacing) {
        final center = Offset(x, y);
        
        // Draw diamond pattern
        final path = Path();
        path.moveTo(center.dx, center.dy - patternSize / 2);
        path.lineTo(center.dx + patternSize / 2, center.dy);
        path.lineTo(center.dx, center.dy + patternSize / 2);
        path.lineTo(center.dx - patternSize / 2, center.dy);
        path.close();
        
        canvas.drawPath(path, fillPaint);
        canvas.drawPath(path, paint);
        
        // Draw inner circle
        canvas.drawCircle(center, patternSize / 4, paint);
      }
    }
  }

  void _drawSubtleDots(Canvas canvas, Size size, Paint paint) {
    const double dotSpacing = 120.0;
    const double dotSize = 2.0;

    final dotPaint = Paint()
      ..color = AppColors.primary.withOpacity(opacity * 0.5)
      ..style = PaintingStyle.fill;

    for (double x = dotSpacing / 2; x < size.width; x += dotSpacing) {
      for (double y = dotSpacing / 2; y < size.height; y += dotSpacing) {
        canvas.drawCircle(Offset(x, y), dotSize, dotPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Elegant gradient background widget
class ElegantGradientBackground extends StatelessWidget {
  final Widget child;
  final bool usePattern;

  const ElegantGradientBackground({
    super.key,
    required this.child,
    this.usePattern = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: AppColors.backgroundGradient,
      ),
      child: Stack(
        children: [
          if (usePattern) _buildSubtlePattern(),
          child,
        ],
      ),
    );
  }

  Widget _buildSubtlePattern() {
    return Positioned.fill(
      child: CustomPaint(
        painter: SubtlePatternPainter(),
      ),
    );
  }
}

class SubtlePatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.primary.withOpacity(0.02)
      ..strokeWidth = 0.5
      ..style = PaintingStyle.stroke;

    // Draw very subtle lines
    const double spacing = 100.0;
    
    for (double x = 0; x < size.width; x += spacing) {
      canvas.drawLine(
        Offset(x, 0),
        Offset(x, size.height),
        paint,
      );
    }
    
    for (double y = 0; y < size.height; y += spacing) {
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}