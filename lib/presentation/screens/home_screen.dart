import 'package:flutter/material.dart';
import 'package:users_app/presentation/views/views.dart';
import 'package:users_app/presentation/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  final int pageIndex;

  const HomeScreen({super.key, required this.pageIndex});

  final viewRoutes = const <Widget>[
    RegisterView(),
    UsersView(),
    SettingsView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: viewRoutes[pageIndex],
      bottomNavigationBar: CustomBottomNavigationbar(
        currentIndex: pageIndex,
      ),
    );
  }
}
