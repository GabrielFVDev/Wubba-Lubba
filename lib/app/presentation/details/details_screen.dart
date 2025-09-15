import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wubba_lubba/app/presentation/presentation.dart';
import 'package:wubba_lubba/app/presentation/widgets/app_bar/custom_app_bar_widget.dart';
import 'package:wubba_lubba/app/presentation/widgets/chips/status_chip_widget.dart';
import 'package:wubba_lubba/app/presentation/widgets/cards/info_card_widget.dart';
import 'package:wubba_lubba/app/presentation/widgets/titles/section_title_widget.dart';
import 'package:wubba_lubba/app/presentation/widgets/cards/location_card_widget.dart';

class DetailsScreen extends StatelessWidget {
  final int characterId;

  const DetailsScreen({super.key, required this.characterId});

  // TODO alterar a tela depois
  @override
  Widget build(BuildContext context) {
    // Ensure the bloc loads the character (safe to call even if already loaded)
    context.read<CharactersBloc>().add(LoadCharacterById(characterId));

    return Scaffold(
      appBar: CustomAppBarWidget(
        text: 'teste',
        onPressed: () {
          context.read<CharactersBloc>().add(LoadCharacters());
          context.go('/home');
        },
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
              return SingleChildScrollView(
                child: Column(
                  children: [
                    // Hero Image Section
                    Stack(
                      children: [
                        // Background gradient overlay
                        Container(
                          height: 400,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                const Color(0xFF0D1421).withOpacity(0.8),
                                const Color(0xFF0D1421),
                              ],
                            ),
                          ),
                        ),
                        // Character Image
                        Positioned.fill(
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(30),
                              bottomRight: Radius.circular(30),
                            ),
                            child: Image.network(
                              c.image,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: Colors.grey.shade800,
                                  child: const Icon(
                                    Icons.person,
                                    size: 100,
                                    color: Colors.white54,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        // Character name overlay at bottom
                        Positioned(
                          bottom: 20,
                          left: 20,
                          right: 20,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                c.name,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  shadows: [
                                    Shadow(
                                      offset: Offset(2, 2),
                                      blurRadius: 4,
                                      color: Colors.black54,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 8),
                              StatusChipWidget(status: c.status),
                            ],
                          ),
                        ),
                      ],
                    ),

                    // Content Section
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Quick Info Cards
                          Row(
                            children: [
                              Expanded(
                                child: InfoCardWidget(
                                  title: 'Species',
                                  value: c.species,
                                  icon: Icons.pets,
                                  color: Colors.green,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: InfoCardWidget(
                                  title: 'Gender',
                                  value: c.gender,
                                  icon: Icons.person,
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 24),

                          // Location Info
                          SectionTitleWidget(title: 'Location & Origin'),
                          const SizedBox(height: 12),

                          LocationCardWidget(
                            title: 'Origin',
                            location: c.origin['name'] ?? 'Unknown',
                            icon: Icons.home,
                            color: Colors.orange,
                          ),

                          const SizedBox(height: 12),

                          LocationCardWidget(
                            title: 'Current Location',
                            location: c.location['name'] ?? 'Unknown',
                            icon: Icons.location_on,
                            color: Colors.red,
                          ),

                          const SizedBox(height: 24),

                          // Episodes Section
                          SectionTitleWidget(title: 'Episodes'),
                          const SizedBox(height: 12),

                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.05),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.1),
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.tv,
                                  color: Colors.purple.shade300,
                                  size: 24,
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  'Appears in multiple episodes',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 30),
                        ],
                      ),
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
