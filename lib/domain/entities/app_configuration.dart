import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

part 'app_configuration.g.dart';

@collection
class AppConfiguration {
  Id? isarId = Isar.autoIncrement;
  final bool isDarkMode;
  final int color;

  AppConfiguration({
    this.isarId,
    required this.isDarkMode,
    required this.color,
  });

  AppConfiguration copyWith({Id? isarId, bool? isDarkMode, int? color}) => AppConfiguration(
        isarId: isarId ?? this.isarId,
        isDarkMode: isDarkMode ?? this.isDarkMode,
        color: color ?? this.color,
      );
}
