import 'package:flutter/material.dart';
import 'package:wubba_lubba/app/presentation/theme/app_colors.dart';

class SearchTextFormWidget extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onSubmitted;
  final VoidCallback onClear;
  final String hintText;

  const SearchTextFormWidget({
    super.key,
    required this.controller,
    required this.onSubmitted,
    required this.onClear,
    this.hintText = 'Search...',
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        controller: controller,
        onSubmitted: onSubmitted,
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: AppColors.textPrimary),
          fillColor: AppColors.secondaryBackground,
          filled: true,
          prefixIcon: const Icon(
            Icons.search,
            color: AppColors.textPrimary,
          ),
          suffixIcon: IconButton(
            icon: const Icon(
              Icons.clear,
              color: AppColors.textPrimary,
            ),
            onPressed: onClear,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
        style: const TextStyle(color: AppColors.textPrimary),
      ),
    );
  }
}
