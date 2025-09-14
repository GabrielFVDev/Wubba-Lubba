import 'package:flutter/material.dart';

class CustomAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final String text;
  final void Function()? onPressed;
  const CustomAppBarWidget({
    super.key,
    required this.text,
    this.onPressed,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(16),
        ),
      ),
      automaticallyImplyLeading: false,
      centerTitle: true,
      backgroundColor: const Color(0xFF0D1421),
      title: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
      leading: onPressed == null
          ? null
          : IconButton(
              onPressed: onPressed,
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
    );
  }
}
