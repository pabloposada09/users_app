import 'package:flutter/material.dart';
import 'package:users_app/utils/utils.dart';

class CustomLoading extends StatelessWidget {
  final String message;
  const CustomLoading({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(
            height: ScreenMeasures.spaceBetweenElements,
          ),
          Text(message),
        ],
      ),
    );
  }
}
