import 'package:users_app/domain/domain.dart';

abstract class AppConfigurationRepository {
  Future<AppConfiguration?> getTheme();

  Future<bool> saveTheme(AppConfiguration configuration);
}
