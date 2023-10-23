import 'package:go_router/go_router.dart';
import 'package:users_app/presentation/screens/address_screen.dart';
import 'package:users_app/presentation/screens/screens.dart';
import 'package:users_app/utils/utils.dart';

final appRouter = GoRouter(
  initialLocation: Navigation.defaultRoute,
  routes: [
    GoRoute(
        path: Navigation.homeRouteDef,
        builder: (context, state) {
          final page = state.pathParameters['page'] ?? '0';
          return HomeScreen(pageIndex: int.parse(page));
        },
        routes: [
          GoRoute(
            path: Navigation.userDetailRouteDef,
            builder: (context, state) {
              final id = state.pathParameters['id'] ?? '0';
              return UserDetailScreen(userId: int.parse(id));
            },
          )
        ]),
    GoRoute(
      path: Navigation.addressRoute,
      builder: (context, state) => const AddressScreen(),
    ),
    GoRoute(
      path: Navigation.defaultRoute,
      redirect: (_, __) => '${Navigation.homeRoute}0',
    )
  ],
);
