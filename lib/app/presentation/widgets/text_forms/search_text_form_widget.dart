import 'package:flutter/material.dart';
import 'package:wubba_lubba/core/responsive_helper.dart';

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
    final isSmallScreen = ResponsiveHelper.isSmallScreen(context);
    final responsivePadding = ResponsiveHelper.getResponsivePadding(context);
    final fontSize = ResponsiveHelper.getResponsiveFontSize(
      context,
      ResponsiveFontSize.medium,
    );

    return Semantics(
      label: 'Campo de busca de personagens',
      hint: 'Digite o nome do personagem que deseja encontrar',
      textField: true,
      child: Padding(
        padding: responsivePadding,
        child: TextField(
          controller: controller,
          onSubmitted: onSubmitted,
          textInputAction: TextInputAction.search,
          style: TextStyle(
            color: Colors.white,
            fontSize: fontSize,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              color: Colors.white70,
              fontSize: fontSize,
            ),
            fillColor: Colors.white.withAlpha(15),
            filled: true,
            contentPadding: EdgeInsets.symmetric(
              horizontal: isSmallScreen ? 12.0 : 16.0,
              vertical: isSmallScreen ? 12.0 : 16.0,
            ),
            prefixIcon: Semantics(
              label: 'Ícone de busca',
              excludeSemantics: true,
              child: Icon(
                Icons.search,
                color: Colors.white70,
                size: isSmallScreen ? 20.0 : 24.0,
              ),
            ),
            suffixIcon: Semantics(
              label: 'Limpar busca',
              hint: 'Toque para limpar o campo de busca',
              button: true,
              child: IconButton(
                icon: Icon(
                  Icons.clear,
                  color: Colors.white70,
                  size: isSmallScreen ? 20.0 : 24.0,
                ),
                onPressed: onClear,
                tooltip: 'Limpar busca',
                splashRadius: isSmallScreen ? 20.0 : 24.0,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(isSmallScreen ? 8.0 : 12.0),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(isSmallScreen ? 8.0 : 12.0),
              borderSide: const BorderSide(
                color: Colors.green,
                width: 2.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
