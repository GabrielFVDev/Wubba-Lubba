import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wubba_lubba/app/presentation/presentation.dart';
import 'package:wubba_lubba/app/presentation/widgets/app_bar/custom_app_bar_widget.dart';

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
                              _buildStatusChip(c.status),
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
                                child: _buildInfoCard(
                                  'Species',
                                  c.species,
                                  Icons.pets,
                                  Colors.green,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: _buildInfoCard(
                                  'Gender',
                                  c.gender,
                                  Icons.person,
                                  Colors.blue,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 24),

                          // Location Info
                          _buildSectionTitle('Location & Origin'),
                          const SizedBox(height: 12),

                          _buildLocationCard(
                            'Origin',
                            c.origin['name'] ?? 'Unknown',
                            Icons.home,
                            Colors.orange,
                          ),

                          const SizedBox(height: 12),

                          _buildLocationCard(
                            'Current Location',
                            c.location['name'] ?? 'Unknown',
                            Icons.location_on,
                            Colors.red,
                          ),

                          const SizedBox(height: 24),

                          // Episodes Section
                          _buildSectionTitle('Episodes'),
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

  Widget _buildStatusChip(String status) {
    Color chipColor;
    IconData icon;

    switch (status.toLowerCase()) {
      case 'alive':
        chipColor = Colors.green;
        icon = Icons.favorite;
        break;
      case 'dead':
        chipColor = Colors.red;
        icon = Icons.heart_broken;
        break;
      default:
        chipColor = Colors.orange;
        icon = Icons.help_outline;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: chipColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: chipColor, width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: chipColor, size: 16),
          const SizedBox(width: 6),
          Text(
            status,
            style: TextStyle(
              color: chipColor,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: color.withOpacity(0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 20),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildLocationCard(
    String title,
    String location,
    IconData icon,
    Color color,
  ) {
    return Container(
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
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  location,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
