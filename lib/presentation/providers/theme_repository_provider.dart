import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:users_app/infrastructure/datasources/local_app_configuration_datasource.dart';
import 'package:users_app/infrastructure/repositories/app_configuration_repository_imp.dart';

final themeRepositoryProvider = Provider((ref) => AppConfigurationRepositoryImp(appConfigurationDatasource: LocalAppConfigurationDatasource()));
