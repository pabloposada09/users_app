import 'package:users_app/domain/domain.dart';

class UsersRepositoryImp extends UsersRepository {
  UsersDatasource usersDatasource;

  UsersRepositoryImp({required this.usersDatasource});

  @override
  Future<bool> createUser(User user) => usersDatasource.createUser(user);

  @override
  Future<bool> deleteUserById(int userId) => usersDatasource.deleteUserById(userId);

  @override
  Future<User> getUserById(int userId) => usersDatasource.getUserById(userId);

  @override
  Future<List<User>> getUsers({int limit = 10, int offset = 0}) => usersDatasource.getUsers(limit: limit, offset: offset);

  @override
  Future<bool> updateUser(User user) => usersDatasource.updateUser(user);
}
