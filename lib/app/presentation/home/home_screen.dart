import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wubba_lubba/app/presentation/presentation.dart';
import 'package:wubba_lubba/app/domain/domain.dart';
import 'package:wubba_lubba/app/presentation/widgets/app_bar/custom_app_bar_widget.dart';
import 'package:wubba_lubba/app/presentation/widgets/cards/character_card_widget.dart';
import 'package:wubba_lubba/core/responsive_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  // TODO alterar a tela e criar os componentes
  @override
  void initState() {
    super.initState();
    // Ensure characters are loaded when screen opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CharactersBloc>().add(LoadCharacters());
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    context.read<CharactersBloc>().add(RefreshCharacters());
    // wait a bit for refresh to complete (bloc will emit states)
    await Future.delayed(const Duration(milliseconds: 800));
  }

  void _onSearch(String query) {
    if (query.trim().isEmpty) {
      context.read<CharactersBloc>().add(LoadCharacters());
    } else {
      context.read<CharactersBloc>().add(SearchCharacters(query.trim()));
    }
  }

  void _onClearSearch() {
    _searchController.clear();
    _onSearch('');
  }

  @override
  Widget build(BuildContext context) {
    final responsivePadding = ResponsiveHelper.getResponsivePadding(context);
    final spacing = ResponsiveHelper.getResponsiveSpacing(context);
    final isSmallScreen = ResponsiveHelper.isSmallScreen(context);
    final errorFontSize = ResponsiveHelper.getResponsiveFontSize(
      context,
      ResponsiveFontSize.medium,
    );

    return Semantics(
      label: 'Tela principal do aplicativo Rick and Morty',
      child: Scaffold(
        backgroundColor: const Color(0xFF0D1421),
        appBar: CustomAppBarWidget(
          text: 'Wubba Lubba',
          onPressed: null,
        ),
        body: SafeArea(
          child: RefreshIndicator(
            onRefresh: _onRefresh,
            child: BlocConsumer<CharactersBloc, CharactersState>(
              listener: (context, state) {
                if (state is CharactersError) {
                  final snack = SnackBar(
                    content: Semantics(
                      label: 'Erro: ${state.message}',
                      liveRegion: true,
                      child: Text(state.message),
                    ),
                    action: SnackBarAction(
                      label: 'Tentar Novamente',
                      onPressed: () {
                        final query = _searchController.text.trim();
                        if (query.isEmpty) {
                          context.read<CharactersBloc>().add(LoadCharacters());
                        } else {
                          context.read<CharactersBloc>().add(
                            SearchCharacters(query),
                          );
                        }
                      },
                    ),
                  );

                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(snack);
                }
              },
              builder: (context, state) {
                if (state is CharactersLoading || state is CharactersInitial) {
                  return Semantics(
                    label: 'Carregando personagens',
                    liveRegion: true,
                    child: const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                      ),
                    ),
                  );
                }

                if (state is CharactersError) {
                  return Semantics(
                    label: 'Erro ao carregar personagens',
                    liveRegion: true,
                    child: Center(
                      child: Padding(
                        padding: responsivePadding,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.error_outline,
                              size: isSmallScreen ? 48.0 : 64.0,
                              color: Colors.red,
                            ),
                            SizedBox(height: spacing * 2),
                            Text(
                              state.message,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: errorFontSize,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: spacing * 2),
                            Semantics(
                              label: 'Tentar carregar personagens novamente',
                              hint: 'Toque para recarregar a lista',
                              button: true,
                              child: ElevatedButton.icon(
                                onPressed: () =>
                                    context.read<CharactersBloc>().add(
                                      LoadCharacters(),
                                    ),
                                icon: const Icon(Icons.refresh),
                                label: const Text('Tentar Novamente'),
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: isSmallScreen ? 16.0 : 24.0,
                                    vertical: isSmallScreen ? 12.0 : 16.0,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }

                if (state is CharactersEmpty) {
                  return Semantics(
                    label: 'Nenhum personagem encontrado',
                    liveRegion: true,
                    child: Center(
                      child: Padding(
                        padding: responsivePadding,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.search_off,
                              size: isSmallScreen ? 48.0 : 64.0,
                              color: Colors.white70,
                            ),
                            SizedBox(height: spacing * 2),
                            Text(
                              'Nenhum personagem encontrado',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: errorFontSize,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: spacing * 2),
                            Semantics(
                              label: 'Limpar busca e ver todos os personagens',
                              hint: 'Toque para limpar os filtros de busca',
                              button: true,
                              child: ElevatedButton.icon(
                                onPressed: _onClearSearch,
                                icon: const Icon(Icons.clear),
                                label: const Text('Limpar Busca'),
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: isSmallScreen ? 16.0 : 24.0,
                                    vertical: isSmallScreen ? 12.0 : 16.0,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }

                if (state is CharactersLoaded) {
                  final characters = state.characters;
                  return Semantics(
                    label: '${characters.length} personagens carregados',
                    liveRegion: true,
                    child: Column(
                      children: [
                        // Search TextField
                        SearchTextFormWidget(
                          controller: _searchController,
                          onSubmitted: _onSearch,
                          onClear: _onClearSearch,
                          hintText: 'Buscar personagens...',
                        ),
                        // Characters List
                        Expanded(
                          child: Semantics(
                            label: 'Lista de ${characters.length} personagens',
                            child: ListView.separated(
                              padding: responsivePadding,
                              itemCount: characters.length,
                              separatorBuilder: (_, __) =>
                                  SizedBox(height: spacing),
                              itemBuilder: (context, index) {
                                final CharacterEntity c = characters[index];
                                return CharacterCardWidget(character: c);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      ),
    );
  }
}
