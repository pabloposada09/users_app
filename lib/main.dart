import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:users_app/config/router/app_router.dart';
import 'package:users_app/presentation/providers/theme_provider.dart';
import 'package:users_app/utils/db/locator.dart';

void main() {
  setup();
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final theme = ref.watch(themeProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: theme.getTheme(),
      routerConfig: appRouter,
      builder: EasyLoading.init(),
    );
  }
}
