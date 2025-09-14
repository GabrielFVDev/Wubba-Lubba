import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wubba_lubba/app/presentation/presentation.dart';
import 'package:go_router/go_router.dart';
import 'package:wubba_lubba/app/domain/domain.dart';

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
    return Scaffold(
      backgroundColor: const Color(0xFF0D1421),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Wubba Lubba',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF0D1421),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _onRefresh,
          child: BlocBuilder<CharactersBloc, CharactersState>(
            builder: (context, state) {
              if (state is CharactersLoading || state is CharactersInitial) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is CharactersError) {
                return Center(
                  child: Text(
                    state.message,
                    style: const TextStyle(color: Colors.white),
                  ),
                );
              }

              if (state is CharactersEmpty) {
                return const Center(
                  child: Text(
                    'No characters found',
                    style: TextStyle(color: Colors.white70),
                  ),
                );
              }

              if (state is CharactersLoaded) {
                final characters = state.characters;
                return Column(
                  children: [
                    // Search TextField - only shown when characters are loaded
                    SearchTextFormWidget(
                      controller: _searchController,
                      onSubmitted: _onSearch,
                      onClear: _onClearSearch,
                      hintText: 'Search characters...',
                    ),
                    // Characters List
                    Expanded(
                      child: ListView.separated(
                        padding: const EdgeInsets.all(12),
                        itemCount: characters.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 8),
                        itemBuilder: (context, index) {
                          final CharacterEntity c = characters[index];
                          return ListTile(
                            onTap: () {
                              // Load details and navigate to details screen if exists
                              context.read<CharactersBloc>().add(
                                LoadCharacterById(c.id),
                              );
                              context.push('/details/${c.id}');
                            },
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            tileColor: Colors.white.withOpacity(0.04),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                c.image,
                                width: 56,
                                height: 56,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => Container(
                                  width: 56,
                                  height: 56,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            title: Text(
                              c.name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            subtitle: Text(
                              '${c.species} • ${c.status}',
                              style: const TextStyle(color: Colors.white70),
                            ),
                            trailing: const Icon(
                              Icons.chevron_right,
                              color: Colors.white70,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              }

              if (state is CharacterLoaded) {
                final c = state.character;
                return ListTile(
                  onTap: () {
                    // Load details and navigate to details screen if exists
                    context.read<CharactersBloc>().add(
                      LoadCharacterById(c.id),
                    );
                    context.go('/details/${c.id}');
                  },
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  tileColor: Colors.white.withOpacity(0.04),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      c.image,
                      width: 56,
                      height: 56,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        width: 56,
                        height: 56,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  title: Text(
                    c.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Text(
                    '${c.species} • ${c.status}',
                    style: const TextStyle(color: Colors.white70),
                  ),
                  trailing: const Icon(
                    Icons.chevron_right,
                    color: Colors.white70,
                  ),
                );
              }

              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
