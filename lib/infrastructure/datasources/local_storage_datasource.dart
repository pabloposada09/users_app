import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:users_app/domain/domain.dart';

class LocalStorageDatasource extends UsersDatasource {
  late Future<Isar> db;

  LocalStorageDatasource() {
    db = openDB();
  }

  Future<Isar> openDB() async {
    if (Isar.instanceNames.isEmpty) {
      final dir = await getApplicationDocumentsDirectory();
      return await Isar.open(
        [UserSchema],
        directory: dir.path,
        inspector: true,
      );
    }

    return Future.value(Isar.getInstance());
  }

  @override
  Future<bool> deleteUserById(int userId) async {
    final isar = await db;

    final response = await isar.users.delete(userId);

    return response;
  }

  @override
  Future<User> getUserById(int userId) async {
    final isar = await db;

    final User? user = await isar.users.get(userId);

    return user!;
  }

  @override
  Future<List<User>> getUsers({int limit = 10, int offset = 0}) async {
    final isar = await db;
    final users = await isar.users.where().offset(offset).limit(limit).findAll();

    return users;
  }

  @override
  Future<bool> updateUser(User user) async {
    final isar = await db;
    await isar.users.put(user);

    return true;
  }

  @override
  Future<bool> createUser(User user) async {
    final isar = await db;

    isar.writeTxnSync(() => isar.users.putSync(user));
    return true;
  }
}
