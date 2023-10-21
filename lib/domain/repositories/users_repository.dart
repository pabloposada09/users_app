import 'package:users_app/domain/entities/user.dart';

abstract class UsersRepository {
  Future<List<User>> getUsers({int limit = 10, int offset = 0});

  Future<User> getUserById(int userId);

  Future<bool> updateUser(User user);

  Future<bool> deleteUserById(int userId);

  Future<bool> createUser(User user);
}
