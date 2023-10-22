import 'package:flutter/material.dart';
import 'package:users_app/utils/utils.dart';

class AppTheme {
  final int selectedColor;
  final bool isDaskMode;

  AppTheme({this.selectedColor = 0, this.isDaskMode = false})
      : assert(selectedColor >= 0, 'Selected colors must be greater than 0'),
        assert(selectedColor < Constants.colorList.length, 'Selected colors must less or equal than ${Constants.colorList.length - 1}');

  ThemeData getTheme() => ThemeData(
        useMaterial3: true,
        brightness: isDaskMode ? Brightness.dark : Brightness.light,
        colorSchemeSeed: Constants.colorList[selectedColor],
        appBarTheme: const AppBarTheme(centerTitle: false),
      );

  AppTheme copyWith({int? selectedColor, bool? isDaskMode}) =>
      AppTheme(selectedColor: selectedColor ?? this.selectedColor, isDaskMode: isDaskMode ?? this.isDaskMode);
}
