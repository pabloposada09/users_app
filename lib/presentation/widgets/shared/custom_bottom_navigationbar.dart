import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:users_app/utils/utils.dart';

class CustomBottomNavigationbar extends StatelessWidget {
  const CustomBottomNavigationbar({super.key});

  void _handleItemTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go(Navigation.registerRoute);
        break;
      case 1:
        context.go(Navigation.usersRoute);
        break;
      case 2:
        context.go(Navigation.settingsRoute);
        break;
      default:
        context.go(Navigation.registerRoute);
    }
  }

  int _getCurrentIndex(BuildContext context) {
    final String location = GoRouterState.of(context).matchedLocation;
    switch (location) {
      case Navigation.registerRoute:
        return 0;
      case Navigation.usersRoute:
        return 1;
      case Navigation.settingsRoute:
        return 2;

      default:
        return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 0,
      onTap: (int index) => _handleItemTap(context, index),
      currentIndex: _getCurrentIndex(context),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.format_align_center),
          label: Navigation.registerLabel,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.supervised_user_circle_sharp),
          label: Navigation.usersLabel,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: Navigation.settingsLabel,
        ),
      ],
    );
  }
}
