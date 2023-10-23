import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:users_app/utils/utils.dart';

class CustomBottomNavigationbar extends StatelessWidget {
  final int currentIndex;
  const CustomBottomNavigationbar({super.key, required this.currentIndex});

  void _handleItemTap(BuildContext context, int index) {
    context.go('/home/$index');
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 0,
      onTap: (int index) => _handleItemTap(context, index),
      currentIndex: currentIndex,
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
