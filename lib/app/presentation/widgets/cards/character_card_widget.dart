import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wubba_lubba/app/domain/domain.dart';
import 'package:wubba_lubba/app/presentation/presentation.dart';
import 'package:wubba_lubba/core/responsive_helper.dart';

class CharacterCardWidget extends StatelessWidget {
  final CharacterEntity character;

  const CharacterCardWidget({
    super.key,
    required this.character,
  });

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'alive':
        return Colors.green;
      case 'dead':
        return Colors.red;
      default:
        return Colors.orange;
    }
  }

  String _getStatusDescription(String status) {
    switch (status.toLowerCase()) {
      case 'alive':
        return 'vivo';
      case 'dead':
        return 'morto';
      default:
        return 'status desconhecido';
    }
  }

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = ResponsiveHelper.isSmallScreen(context);
    final cardHeight = ResponsiveHelper.getCardHeight(context);
    final spacing = ResponsiveHelper.getResponsiveSpacing(context);

    // Tamanhos responsivos
    final imageSize = isSmallScreen ? 60.0 : 80.0;
    final nameFontSize = ResponsiveHelper.getResponsiveFontSize(
      context,
      ResponsiveFontSize.large,
    );
    final speciesFontSize = ResponsiveHelper.getResponsiveFontSize(
      context,
      ResponsiveFontSize.medium,
    );
    final statusFontSize = ResponsiveHelper.getResponsiveFontSize(
      context,
      ResponsiveFontSize.small,
    );

    return Semantics(
      label: 'Personagem ${character.name}',
      hint:
          'Toque para ver detalhes do personagem ${character.name}, espécie ${character.species}, status ${_getStatusDescription(character.status)}',
      button: true,
      enabled: true,
      child: Container(
        height: cardHeight,
        margin: EdgeInsets.only(bottom: spacing),
        decoration: BoxDecoration(
          color: Colors.white.withAlpha(05),
          borderRadius: BorderRadius.circular(isSmallScreen ? 12.0 : 16.0),
          border: Border.all(
            color: Colors.white.withAlpha(1),
          ),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(isSmallScreen ? 12.0 : 16.0),
            onTap: () {
              context.read<CharactersBloc>().add(
                LoadCharacterById(character.id),
              );
              context.push('/details/${character.id}');
            },
            child: Padding(
              padding: EdgeInsets.all(isSmallScreen ? 12.0 : 16.0),
              child: Row(
                children: [
                  // Character Image - Responsiva
                  Semantics(
                    label: 'Imagem do personagem ${character.name}',
                    image: true,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                        isSmallScreen ? 8.0 : 12.0,
                      ),
                      child: Image.network(
                        character.image,
                        width: imageSize,
                        height: imageSize,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: imageSize,
                            height: imageSize,
                            color: Colors.grey.shade800,
                            child: Icon(
                              Icons.person,
                              size: imageSize * 0.5,
                              color: Colors.white54,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(width: isSmallScreen ? 12.0 : 16.0),

                  // Character Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Nome do personagem
                        Semantics(
                          label: 'Nome: ${character.name}',
                          header: true,
                          child: Text(
                            character.name,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: nameFontSize,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: isSmallScreen ? 1 : 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(height: spacing),

                        // Espécie
                        Semantics(
                          label: 'Espécie: ${character.species}',
                          child: Text(
                            character.species,
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.8),
                              fontSize: speciesFontSize,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(height: spacing),

                        // Status com indicador visual
                        Semantics(
                          label:
                              'Status: ${_getStatusDescription(character.status)}',
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Semantics(
                                label:
                                    'Indicador de status ${_getStatusDescription(character.status)}',
                                child: Container(
                                  width: isSmallScreen ? 6.0 : 8.0,
                                  height: isSmallScreen ? 6.0 : 8.0,
                                  decoration: BoxDecoration(
                                    color: _getStatusColor(character.status),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                              SizedBox(width: spacing),
                              Flexible(
                                child: Text(
                                  character.status,
                                  style: TextStyle(
                                    color: _getStatusColor(character.status),
                                    fontSize: statusFontSize,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Arrow Icon
                  Semantics(
                    label: 'Navegar para detalhes',
                    excludeSemantics: true,
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white.withValues(alpha: 0.5),
                      size: isSmallScreen ? 14.0 : 16.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
