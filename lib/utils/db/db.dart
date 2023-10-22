import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:users_app/domain/domain.dart';

class DB {
  Future<Isar> openDB() async {
    if (Isar.instanceNames.isEmpty) {
      final dir = await getApplicationDocumentsDirectory();
      return await Isar.open(
        [AppConfigurationSchema, UserSchema],
        directory: dir.path,
        inspector: true,
      );
    }

    return Future.value(Isar.getInstance());
  }
}
