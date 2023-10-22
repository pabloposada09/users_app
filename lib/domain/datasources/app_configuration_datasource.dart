import 'package:users_app/domain/domain.dart';

abstract class AppConfigurationDatasource {
  Future<AppConfiguration?> getTheme();

  Future<bool> saveTheme(AppConfiguration configuration);
}
