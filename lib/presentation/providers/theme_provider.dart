import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:users_app/config/theme/theme.dart';
import 'package:users_app/domain/domain.dart';
import 'package:users_app/presentation/providers/theme_repository_provider.dart';
import 'package:users_app/utils/constants/constants.dart';

final colorsProvider = Provider((ref) => Constants.colorList);

final themeProvider = StateNotifierProvider<ThemeNotifier, AppTheme>((ref) {
  final repository = ref.watch(themeRepositoryProvider);

  return ThemeNotifier(getTheme: repository.getTheme, saveThemeCallBack: repository.saveTheme);
});

typedef ThemeCallback = Future<AppConfiguration?> Function();
typedef SaveThemeCallBack = Future<bool> Function(AppConfiguration);

class ThemeNotifier extends StateNotifier<AppTheme> {
  final ThemeCallback getTheme;

  final SaveThemeCallBack saveThemeCallBack;

  ThemeNotifier({
    required this.getTheme,
    required this.saveThemeCallBack,
  }) : super(AppTheme()) {
    init();
  }

  void init() async {
    final theme = await getTheme();

    if (theme != null) {
      state = state.copyWith(isDaskMode: theme.isDarkMode, selectedColor: theme.color);
    }
  }

  void toggleDarkMode(bool value) {
    state = state.copyWith(isDaskMode: value);
  }

  void changeColor(int? index) {
    state = state.copyWith(selectedColor: index);
  }

  Future<bool> saveConfiguration() async {
    bool status = await saveThemeCallBack(AppConfiguration(isDarkMode: state.isDaskMode, color: state.selectedColor));

    return status;
  }
}
