import 'package:flutter/material.dart';
import 'package:wubba_lubba/app/presentation/theme/app_colors.dart';

class CustomAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final String text;
  final void Function()? onPressed;
  final double height;
  const CustomAppBarWidget({
    super.key,
    required this.text,
    this.onPressed,
    this.height = kToolbarHeight,
  });

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        text,
        style: const TextStyle(color: AppColors.textPrimary),
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(16),
        ),
      ),
      automaticallyImplyLeading: false,
      centerTitle: true,
      toolbarHeight: height,
      backgroundColor: const Color(0xFF0D1421),
      leading: onPressed == null
          ? null
          : IconButton(
              onPressed: onPressed,
              icon: const Icon(
                Icons.arrow_back,
                color: AppColors.textPrimary,
              ),
            ),
    );
  }
}
