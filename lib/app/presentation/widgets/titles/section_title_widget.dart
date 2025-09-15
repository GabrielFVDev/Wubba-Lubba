import 'package:flutter/material.dart';
import 'package:wubba_lubba/app/presentation/theme/app_colors.dart';

class SectionTitleWidget extends StatelessWidget {
  final String title;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;

  const SectionTitleWidget({
    super.key,
    required this.title,
    this.fontSize = 20,
    this.fontWeight = FontWeight.bold,
    this.color = AppColors.textPrimary,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    );
  }
}
