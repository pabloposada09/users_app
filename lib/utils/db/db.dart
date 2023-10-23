import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:users_app/domain/domain.dart';

class DB {
  Future<Isar> openDB() async {
    if (Isar.instanceNames.isEmpty) {
      try {
        final dir = await getApplicationDocumentsDirectory();
        return await Isar.open(
          [AppConfigurationSchema, UserSchema],
          directory: dir.path,
          inspector: true,
        );
      } catch (e) {
        //Database already open
      }
    }

    return Future.value(Isar.getInstance());
  }
}
