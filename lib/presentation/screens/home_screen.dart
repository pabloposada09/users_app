import 'package:flutter/material.dart';
import 'package:users_app/presentation/views/search_gif_view.dart';
import 'package:users_app/presentation/views/views.dart';
import 'package:users_app/presentation/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  final int pageIndex;

  HomeScreen({super.key, required this.pageIndex});

  final viewRoutes = <Widget>[
    const RegisterView(),
    const UsersView(),
    SearchGifView(),
    const SettingsView(),
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
