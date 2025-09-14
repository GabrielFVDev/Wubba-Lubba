import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wubba_lubba/app/presentation/presentation.dart';

class DetailsScreen extends StatelessWidget {
  final int characterId;

  const DetailsScreen({super.key, required this.characterId});

  // TODO alterar a tela depois
  @override
  Widget build(BuildContext context) {
    // Ensure the bloc loads the character (safe to call even if already loaded)
    context.read<CharactersBloc>().add(LoadCharacterById(characterId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Character details'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/home'),
        ),
      ),
      backgroundColor: const Color(0xFF0D1421),
      body: SafeArea(
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

            if (state is CharacterLoaded) {
              final c = state.character;
              return Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          c.image,
                          width: 200,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      c.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Status: ${c.status}',
                      style: const TextStyle(color: Colors.white70),
                    ),
                    Text(
                      'Species: ${c.species}',
                      style: const TextStyle(color: Colors.white70),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Origin: ${c.origin['name'] ?? ''}',
                      style: const TextStyle(color: Colors.white70),
                    ),
                    Text(
                      'Location: ${c.location['name'] ?? ''}',
                      style: const TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              );
            }

            if (state is CharactersEmpty) {
              return const Center(
                child: Text(
                  'No character found',
                  style: TextStyle(color: Colors.white70),
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
