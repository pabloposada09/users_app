import 'package:isar/isar.dart';
import 'package:users_app/domain/domain.dart';
import 'package:users_app/utils/utils.dart';

class UsersLocalStorageDatasource extends UsersDatasource {
  late Future<Isar> db;

  UsersLocalStorageDatasource() {
    db = locator.get<DB>().openDB();
  }

  @override
  Future<bool> deleteUserById(int userId) async {
    final isar = await db;

    isar.writeTxnSync(() => isar.users.deleteSync(userId));

    return true;
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
    isar.writeTxnSync(() => isar.users.putSync(user));

    return true;
  }

  @override
  Future<bool> createUser(User user) async {
    final isar = await db;

    isar.writeTxnSync(() => isar.users.putSync(user));
    return true;
  }
}
