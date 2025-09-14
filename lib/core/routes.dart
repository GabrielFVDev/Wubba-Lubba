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
      builder: (BuildContext context, GoRouterState state) {
        return const HomeScreen();
      },
    ),
    GoRoute(
      path: '/details/:id',
      builder: (BuildContext context, GoRouterState state) {
        final idParam = state.pathParameters['id'];
        final id = int.tryParse(idParam ?? '');
        if (id == null) {
          return const Scaffold(
            body: Center(child: Text('Invalid character id')),
          );
        }
        return DetailsScreen(characterId: id);
      },
    ),
  ],
);
