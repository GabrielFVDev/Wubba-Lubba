import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _portalController;
  late AnimationController _textController;
  late AnimationController _wubbaController;
  late AnimationController _particlesController;

  late Animation<double> _portalRotation;
  late Animation<double> _portalScale;
  late Animation<double> _portalOpacity;
  late Animation<double> _textFade;
  late Animation<double> _textScale;
  late Animation<Offset> _wubbaSlide;
  late Animation<double> _wubbaOpacity;
  late Animation<double> _particlesRotation;

  @override
  void initState() {
    super.initState();

    // Portal animation
    _portalController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    // Text animation
    _textController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    // Wubba Lubba animation
    _wubbaController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    // Particles animation
    _particlesController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    )..repeat();

    _initAnimations();
    _startAnimationSequence();
  }

  void _initAnimations() {
    // Portal animations
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

    _portalScale =
        Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(
          CurvedAnimation(
            parent: _portalController,
            curve: const Interval(0.0, 0.6, curve: Curves.elasticOut),
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

    // Text animations
    _textFade =
        Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(
          CurvedAnimation(
            parent: _textController,
            curve: const Interval(0.3, 0.8, curve: Curves.easeInOut),
          ),
        );

    _textScale =
        Tween<double>(
          begin: 0.8,
          end: 1.0,
        ).animate(
          CurvedAnimation(
            parent: _textController,
            curve: const Interval(0.3, 0.8, curve: Curves.elasticOut),
          ),
        );

    // Wubba Lubba animations
    _wubbaSlide =
        Tween<Offset>(
          begin: const Offset(0, 1),
          end: Offset.zero,
        ).animate(
          CurvedAnimation(
            parent: _wubbaController,
            curve: Curves.bounceOut,
          ),
        );

    _wubbaOpacity =
        Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(
          CurvedAnimation(
            parent: _wubbaController,
            curve: Curves.easeIn,
          ),
        );

    // Particles animation
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
    // Start portal animation
    await Future.delayed(const Duration(milliseconds: 500));
    _portalController.forward();

    // Start text animation
    await Future.delayed(const Duration(milliseconds: 800));
    _textController.forward();

    // Start wubba lubba animation
    await Future.delayed(const Duration(milliseconds: 1200));
    _wubbaController.forward();

    // Navigate after all animations
    await Future.delayed(const Duration(milliseconds: 3500));
    if (mounted) {
      context.go('/home');
    }
  }

  @override
  void dispose() {
    _portalController.dispose();
    _textController.dispose();
    _wubbaController.dispose();
    _particlesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1421), // Dark space blue
      body: Stack(
        children: [
          // Animated background particles
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
                                    .withOpacity(0.5),
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

          // Main content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Portal animation
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
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: const RadialGradient(
                                colors: [
                                  Color(0xFF00D4AA), // Portal green
                                  Color(0xFF008B8B),
                                  Color(0xFF004D4D),
                                ],
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(
                                    0xFF00D4AA,
                                  ).withOpacity(0.5),
                                  blurRadius: 30,
                                  spreadRadius: 10,
                                ),
                              ],
                            ),
                            child: Stack(
                              children: [
                                // Inner rings
                                ...List.generate(3, (index) {
                                  return Center(
                                    child: Container(
                                      width: 120 - (index * 30),
                                      height: 120 - (index * 30),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: const Color(
                                            0xFF00D4AA,
                                          ).withOpacity(0.7 - (index * 0.2)),
                                          width: 2,
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 40),

                // Rick and Morty text
                AnimatedBuilder(
                  animation: _textController,
                  builder: (context, child) {
                    return Opacity(
                      opacity: _textFade.value,
                      child: Transform.scale(
                        scale: _textScale.value,
                        child: Column(
                          children: [
                            Text(
                              'RICK',
                              style: TextStyle(
                                fontSize: 48,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF00D4AA),
                                letterSpacing: 4,
                                shadows: [
                                  Shadow(
                                    color: const Color(
                                      0xFF00D4AA,
                                    ).withOpacity(0.5),
                                    blurRadius: 10,
                                    offset: const Offset(0, 0),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              '&',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w300,
                                color: const Color(0xFFFFD700), // Yellow
                                letterSpacing: 2,
                              ),
                            ),
                            Text(
                              'MORTY',
                              style: TextStyle(
                                fontSize: 48,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF4169E1), // Royal blue
                                letterSpacing: 4,
                                shadows: [
                                  Shadow(
                                    color: const Color(
                                      0xFF4169E1,
                                    ).withOpacity(0.5),
                                    blurRadius: 10,
                                    offset: const Offset(0, 0),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 20),

                // Wubba Lubba Dub Dub
                AnimatedBuilder(
                  animation: _wubbaController,
                  builder: (context, child) {
                    return SlideTransition(
                      position: _wubbaSlide,
                      child: Opacity(
                        opacity: _wubbaOpacity.value,
                        child: Text(
                          'Wubba Lubba Dub Dub!',
                          style: TextStyle(
                            fontSize: 18,
                            fontStyle: FontStyle.italic,
                            color: const Color(0xFFFFD700).withOpacity(0.8),
                            letterSpacing: 1.5,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          // Loading indicator
          Positioned(
            bottom: 80,
            left: 0,
            right: 0,
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    width: 30,
                    height: 30,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        const Color(0xFF00D4AA),
                      ),
                      strokeWidth: 3,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Loading multiverse...',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 14,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
