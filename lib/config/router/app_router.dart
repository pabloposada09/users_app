import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:users_app/presentation/screens/screens.dart';
import 'package:users_app/presentation/views/views.dart';
import 'package:users_app/utils/utils.dart';

final appRouter = GoRouter(
  initialLocation: Navigation.registerRoute,
  routes: [
    ShellRoute(
      builder: (context, state, child) => HomeScreen(child: child),
      routes: [
        GoRoute(
          path: Navigation.registerRoute,
          builder: (context, state) => const RegisterView(),
        ),
        GoRoute(
          path: Navigation.usersRoute,
          builder: (context, state) => const UsersView(),
        ),
        GoRoute(
          path: Navigation.settingsRoute,
          builder: (context, state) => const SettingsView(),
        )
      ],
    ),
    GoRoute(
      path: Navigation.homeRoute,
      builder: (context, state) => const Scaffold(
        body: Center(
          child: Text('Page Builder intro...'),
        ),
      ),
    )
  ],
);
