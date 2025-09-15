import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:just_audio/just_audio.dart';
import 'package:wubba_lubba/app/presentation/theme/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _portalController;
  late AnimationController _particlesController;

  late Animation<double> _portalScale;
  late Animation<double> _portalOpacity;
  late Animation<double> _portalRotation;
  late Animation<double> _particlesRotation;

  late AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();

    _audioPlayer = AudioPlayer();

    _portalController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _particlesController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    )..repeat();

    _initAnimations();
    _startAnimationSequence();
  }

  void _initAnimations() {
    _portalScale =
        Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(
          CurvedAnimation(
            parent: _portalController,
            curve: Curves.elasticOut,
          ),
        );

    _portalOpacity =
        Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(
          CurvedAnimation(
            parent: _portalController,
            curve: const Interval(0.0, 0.4, curve: Curves.easeIn),
          ),
        );

    _portalRotation =
        Tween<double>(
          begin: 0.0,
          end: 2.0,
        ).animate(
          CurvedAnimation(
            parent: _portalController,
            curve: Curves.easeInOut,
          ),
        );

    _particlesRotation =
        Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(
          CurvedAnimation(
            parent: _particlesController,
            curve: Curves.linear,
          ),
        );
  }

  void _startAnimationSequence() async {
    try {
      await _audioPlayer.setAsset('assets/sounds/pistol_sound.mp3');

      await Future.delayed(const Duration(milliseconds: 500));

      _portalController.forward();
      _audioPlayer.play();

      await Future.delayed(const Duration(milliseconds: 2500));
      if (mounted) {
        context.go('/home');
      }
    } catch (e) {
      debugPrint('Audio error: $e');
      await Future.delayed(const Duration(milliseconds: 500));
      _portalController.forward();
      await Future.delayed(const Duration(milliseconds: 2500));
      if (mounted) {
        context.go('/home');
      }
    }
  }

  @override
  void dispose() {
    _portalController.dispose();
    _particlesController.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1421),
      body: Stack(
        children: [
          ...List.generate(15, (index) {
            return AnimatedBuilder(
              animation: _particlesController,
              builder: (context, child) {
                final offset = Offset(
                  (index * 50.0) % MediaQuery.of(context).size.width,
                  (index * 80.0 + _particlesRotation.value * 200) %
                      MediaQuery.of(context).size.height,
                );

                return Positioned(
                  left: offset.dx,
                  top: offset.dy,
                  child: Opacity(
                    opacity: 0.3,
                    child: Container(
                      width: 3 + (index % 4),
                      height: 3 + (index % 4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: index % 3 == 0
                            ? const Color(0xFF00D4AA)
                            : index % 3 == 1
                            ? const Color(0xFFFFD700)
                            : const Color(0xFF4169E1),
                        boxShadow: [
                          BoxShadow(
                            color:
                                (index % 3 == 0
                                        ? const Color(0xFF00D4AA)
                                        : index % 3 == 1
                                        ? const Color(0xFFFFD700)
                                        : const Color(0xFF4169E1))
                                    .withValues(alpha: 0.5),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }),

          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedBuilder(
                  animation: _portalController,
                  builder: (context, child) {
                    return Opacity(
                      opacity: _portalOpacity.value,
                      child: Transform.scale(
                        scale: _portalScale.value,
                        child: Transform.rotate(
                          angle: _portalRotation.value * 3.14159,
                          child: Container(
                            width: 200,
                            height: 200,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(
                                    0xFF00D4AA,
                                  ).withAlpha(5),
                                  blurRadius: 30,
                                  spreadRadius: 10,
                                ),
                              ],
                            ),
                            child: ClipOval(
                              child: Image.asset(
                                'assets/images/portal.png',
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      gradient: const RadialGradient(
                                        colors: [
                                          Color(0xFF00D4AA),
                                          Color(0xFF008B8B),
                                          Color(0xFF004D4D),
                                        ],
                                      ),
                                    ),
                                    child: const Center(
                                      child: Icon(
                                        Icons.science,
                                        size: 80,
                                        color: AppColors.textPrimary,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
