import 'package:users_app/domain/datasources/app_configuration_datasource.dart';
import 'package:users_app/domain/entities/app_configuration.dart';
import 'package:users_app/domain/repositories/app_configuration_repository.dart';

class AppConfigurationRepositoryImp extends AppConfigurationRepository {
  final AppConfigurationDatasource appConfigurationDatasource;

  AppConfigurationRepositoryImp({required this.appConfigurationDatasource});

  @override
  Future<AppConfiguration?> getTheme() => appConfigurationDatasource.getTheme();

  @override
  Future<bool> saveTheme(AppConfiguration configuration) => appConfigurationDatasource.saveTheme(configuration);
}
