import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:users_app/domain/domain.dart';
import 'package:users_app/presentation/providers/user_repository_provider.dart';

final usersProvider = StateNotifierProvider<UsersNotifier, UsersState>((ref) {
  final callback = ref.watch(userRepositoryProvider).getUsers;

  return UsersNotifier(loadUsers: callback);
});

typedef LoadUsersCallback = Future<List<User>> Function({int limit, int offset});

class UsersNotifier extends StateNotifier<UsersState> {
  final LoadUsersCallback loadUsers;

  UsersNotifier({required this.loadUsers}) : super(UsersState());

  Future<List<User>> loadNextPage() async {
    final newUsers = await loadUsers(limit: 10, offset: state.users.length);

    state = state.copyWith(users: [...state.users, ...newUsers], loading: false);

    return newUsers;
  }

  void deleteUserFromList(int userId) {
    if (_checkUserExistance(userId)) {
      state.users.removeWhere((element) => element.isarId == userId);
      state = state.copyWith(users: state.users);
    }
  }

  void updateUserInList(User user) {
    if (_checkUserExistance(user.isarId!)) {
      state.users[state.users.indexWhere((element) => element.isarId == user.isarId)] = user;
      state = state.copyWith(users: state.users);
    }
  }

  bool _checkUserExistance(int userId) {
    return state.users.any((element) => element.isarId == userId);
  }
}

class UsersState {
  final List<User> users;
  final bool loading;
  UsersState({this.users = const [], this.loading = true});

  UsersState copyWith({
    List<User>? users,
    bool? loading,
  }) =>
      UsersState(
        users: users ?? this.users,
        loading: loading ?? this.loading,
      );
}
