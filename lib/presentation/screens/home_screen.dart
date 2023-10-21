import 'package:flutter/material.dart';
import 'package:users_app/presentation/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  final Widget child;

  const HomeScreen({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: const CustomBottomNavigationbar(),
    );
  }
}
