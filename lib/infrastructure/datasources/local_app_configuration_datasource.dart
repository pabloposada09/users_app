import 'package:isar/isar.dart';
import 'package:users_app/domain/datasources/app_configuration_datasource.dart';
import 'package:users_app/domain/entities/app_configuration.dart';
import 'package:users_app/utils/utils.dart';

class LocalAppConfigurationDatasource extends AppConfigurationDatasource {
  late Future<Isar> db;

  LocalAppConfigurationDatasource() {
    db = locator.get<DB>().openDB();
  }

  @override
  Future<AppConfiguration?> getTheme() async {
    final isar = await db;

    final appConfiguration = await isar.appConfigurations.filter().isarIdIsNotNull().findFirst();

    return appConfiguration;
  }

  @override
  Future<bool> saveTheme(AppConfiguration configuration) async {
    try {
      final isar = await db;

      AppConfiguration? appConfiguration = await isar.appConfigurations.filter().isarIdIsNotNull().findFirst();

      if (appConfiguration != null) {
        appConfiguration = appConfiguration.copyWith(isDarkMode: configuration.isDarkMode, color: configuration.color);
        isar.writeTxnSync(() => isar.appConfigurations.putSync(appConfiguration!));

        return true;
      }

      isar.writeTxnSync(() => isar.appConfigurations.putSync(configuration));

      return true;
    } catch (e) {
      return false;
    }
  }
}
