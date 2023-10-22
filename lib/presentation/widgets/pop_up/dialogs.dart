import 'package:flutter/material.dart';

class Dialogs {
  static void showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 2),
    );

    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void showPopUp(BuildContext context, String title, String message, [List<Widget> actions = const []]) {
    final textStyles = Theme.of(context).textTheme;

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: textStyles.titleLarge,
              ),
              Text(
                message,
                style: textStyles.bodyMedium,
              )
            ],
          ),
          actions: actions,
        );
      },
    );
  }
}
