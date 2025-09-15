import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wubba_lubba/app/presentation/presentation.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const SplashScreen();
      },
    ),
    GoRoute(
      path: '/home',
      pageBuilder: (BuildContext context, GoRouterState state) {
        return CustomTransitionPage<void>(
          key: state.pageKey,
          child: const HomeScreen(),
          transitionDuration: const Duration(milliseconds: 250),
          reverseTransitionDuration: const Duration(milliseconds: 200),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position:
                  Tween<Offset>(
                    begin: const Offset(-1.0, 0.0),
                    end: Offset.zero,
                  ).animate(
                    CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeInOut,
                    ),
                  ),
              child: child,
            );
          },
        );
      },
    ),
    GoRoute(
      path: '/details/:id',
      pageBuilder: (BuildContext context, GoRouterState state) {
        final id = int.parse(state.pathParameters['id']!);

        return CustomTransitionPage<void>(
          key: state.pageKey,
          child: DetailsScreen(characterId: id),
          transitionDuration: const Duration(milliseconds: 300),
          reverseTransitionDuration: const Duration(milliseconds: 250),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            final tween = Tween(begin: begin, end: end);
            final curvedAnimation = CurvedAnimation(
              parent: animation,
              curve: Curves.easeInOut,
            );

            return SlideTransition(
              position: tween.animate(curvedAnimation),
              child: FadeTransition(
                opacity: animation,
                child: child,
              ),
            );
          },
        );
      },
    ),
  ],
);
