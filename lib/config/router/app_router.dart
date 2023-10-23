import 'package:go_router/go_router.dart';
import 'package:users_app/presentation/screens/address_screen.dart';
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
        GoRoute(path: Navigation.usersRoute, builder: (context, state) => const UsersView(), routes: [
          GoRoute(
            path: Navigation.userDetailRouteDef,
            builder: (context, state) {
              final id = state.pathParameters['id'] ?? '0';
              return UserDetailScreen(userId: int.parse(id));
            },
          )
        ]),
        GoRoute(
          path: Navigation.settingsRoute,
          builder: (context, state) => const SettingsView(),
        )
      ],
    ),
    GoRoute(
      path: Navigation.addressRoute,
      builder: (context, state) => const AddressScreen(),
    ),
    GoRoute(
      path: Navigation.homeRoute,
      redirect: (_, __) => Navigation.registerRoute,
    )
  ],
);
