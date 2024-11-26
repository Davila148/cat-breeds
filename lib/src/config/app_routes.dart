import 'package:cat_breeds/src/models/cat_breed_dto.dart';
import 'package:cat_breeds/src/ui/screens/details/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../ui/screens/home/home_screen.dart';

final GoRouter appRouter = GoRouter(
  onException: (_, GoRouterState state, GoRouter router) {
      state.fullPath == '' ? router.go('/') : router.go('/');
    },
    initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) =>
          const HomeScreen(),
    ),
    GoRoute(
      path: '/details-screen',
      builder: (BuildContext context, GoRouterState state) {
        return DetailsScreen(
          catBreed: state.extra as CatBreedDTO,
        );
      },
    ),
  ],
);
