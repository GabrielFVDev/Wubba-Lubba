import 'package:flutter/material.dart';
import 'package:wubba_lubba/core/responsive_helper.dart';

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
    final titleFontSize = ResponsiveHelper.getResponsiveFontSize(
      context,
      ResponsiveFontSize.large,
    );
    final isSmallScreen = ResponsiveHelper.isSmallScreen(context);

    return Semantics(
      label: onPressed == null
          ? 'Cabeçalho $text'
          : 'Cabeçalho $text com botão voltar',
      header: true,
      child: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(isSmallScreen ? 12.0 : 16.0),
          ),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: const Color(0xFF0D1421),
        elevation: 0,
        title: Semantics(
          label: 'Título do aplicativo: $text',
          header: true,
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: titleFontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        leading: onPressed == null
            ? null
            : Semantics(
                label: 'Voltar para tela anterior',
                hint: 'Toque para voltar',
                button: true,
                child: IconButton(
                  onPressed: onPressed,
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: isSmallScreen ? 20.0 : 24.0,
                  ),
                  tooltip: 'Voltar',
                  splashRadius: isSmallScreen ? 20.0 : 24.0,
                ),
              ),
      ),
    );
  }
}
