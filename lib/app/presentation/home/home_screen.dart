import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wubba_lubba/app/presentation/presentation.dart';
import 'package:wubba_lubba/app/domain/domain.dart';
import 'package:wubba_lubba/app/presentation/widgets/app_bar/custom_app_bar_widget.dart';
import 'package:wubba_lubba/app/presentation/widgets/cards/character_card_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CharactersBloc>().add(LoadCharacters());
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() async =>
      context.read<CharactersBloc>().add(RefreshCharacters());

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
      appBar: CustomAppBarWidget(
        text: 'Galeria Interdimensional',
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
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        state.message,
                        style: const TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () => context.read<CharactersBloc>().add(
                          LoadCharacters(),
                        ),
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                );
              }

              if (state is CharactersEmpty) {
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'No characters found',
                        style: TextStyle(color: Colors.white70),
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: _onClearSearch,
                        child: const Text('Clear search'),
                      ),
                    ],
                  ),
                );
              }

              if (state is CharactersLoaded) {
                final characters = state.characters;
                return Column(
                  children: [
                    SearchTextFormWidget(
                      controller: _searchController,
                      onSubmitted: _onSearch,
                      onClear: _onClearSearch,
                      hintText: 'Search characters...',
                    ),

                    Expanded(
                      child: ListView.separated(
                        padding: const EdgeInsets.all(12),
                        itemCount: characters.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 8),
                        itemBuilder: (context, index) {
                          final CharacterEntity c = characters[index];
                          return CharacterCardWidget(character: c);
                        },
                      ),
                    ),
                  ],
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
