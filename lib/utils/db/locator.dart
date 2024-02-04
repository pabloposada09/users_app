import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:users_app/utils/db/db.dart';

final locator = GetIt.instance;

void setup() async {
  locator.registerLazySingleton(() => DB());
  await dotenv.load(fileName: ".env");
}
