import 'package:get_it/get_it.dart';
import 'package:users_app/utils/db/db.dart';

final locator = GetIt.instance;

void setup() {
  locator.registerLazySingleton(() => DB());
}
