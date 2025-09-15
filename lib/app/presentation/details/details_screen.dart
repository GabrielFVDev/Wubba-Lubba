import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wubba_lubba/app/presentation/presentation.dart';
import 'package:wubba_lubba/app/presentation/theme/app_colors.dart';
import 'package:wubba_lubba/app/presentation/widgets/app_bar/custom_app_bar_widget.dart';
import 'package:wubba_lubba/app/presentation/widgets/chips/status_chip_widget.dart';
import 'package:wubba_lubba/app/presentation/widgets/cards/info_card_widget.dart';
import 'package:wubba_lubba/app/presentation/widgets/titles/section_title_widget.dart';
import 'package:wubba_lubba/app/presentation/widgets/cards/location_card_widget.dart';

class DetailsScreen extends StatelessWidget {
  final int characterId;

  const DetailsScreen({super.key, required this.characterId});

  @override
  Widget build(BuildContext context) {
    context.read<CharactersBloc>().add(LoadCharacterById(characterId));

    return Scaffold(
      appBar: CustomAppBarWidget(
        text: 'Detalhes',
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
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColors.greenNeon,
                ),
              );
            }

            if (state is CharactersError) {
              return Center(
                child: Text(
                  state.message,
                  style: const TextStyle(color: AppColors.textPrimary),
                ),
              );
            }

            if (state is CharacterLoaded) {
              final character = state.character;
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 400,
                          decoration: const BoxDecoration(
                            gradient: AppColors.heroGradient,
                          ),
                        ),

                        Positioned.fill(
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(30),
                              bottomRight: Radius.circular(30),
                            ),
                            child: Image.network(
                              character.image,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: Colors.grey.shade800,
                                  child: const Icon(
                                    Icons.person,
                                    size: 100,
                                    color: AppColors.textPrimary,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 16,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            character.name,
                            style: const TextStyle(
                              color: AppColors.textPrimary,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          StatusChipWidget(status: character.status),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: InfoCardWidget(
                                  title: 'Species',
                                  value: character.species,
                                  icon: Icons.pets,
                                  color: AppColors.accentSecondary,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: InfoCardWidget(
                                  title: 'Gender',
                                  value: character.gender,
                                  icon: Icons.person,
                                  color: AppColors.info,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 24),

                          SectionTitleWidget(title: 'Location & Origin'),
                          const SizedBox(height: 12),

                          LocationCardWidget(
                            title: 'Origin',
                            location: character.origin['name'] ?? 'Unknown',
                            icon: Icons.home,
                            color: AppColors.info,
                          ),

                          const SizedBox(height: 12),

                          LocationCardWidget(
                            title: 'Current Location',
                            location: character.location['name'] ?? 'Unknown',
                            icon: Icons.location_on,
                            color: AppColors.statusDead,
                          ),

                          const SizedBox(height: 24),

                          SectionTitleWidget(title: 'Episodes'),
                          const SizedBox(height: 12),

                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: AppColors.secondaryBackground,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: AppColors.purple,
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.tv,
                                  color: AppColors.purple,
                                  size: 24,
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  'Appears in multiple episodes',
                                  style: const TextStyle(
                                    color: AppColors.textPrimary,
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
                  style: TextStyle(color: AppColors.error),
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
