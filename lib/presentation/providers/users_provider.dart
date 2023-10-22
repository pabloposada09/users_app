import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:users_app/domain/domain.dart';
import 'package:users_app/presentation/providers/user_repository_provider.dart';

final usersProvider = StateNotifierProvider.autoDispose<UsersNotifier, UsersState>((ref) {
  final callback = ref.watch(userRepositoryProvider).getUsers;

  return UsersNotifier(loadUsers: callback);
});

typedef LoadUsersCallback = Future<List<User>> Function({int limit, int offset});

class UsersNotifier extends StateNotifier<UsersState> {
  int currentPage = 0;
  final LoadUsersCallback loadUsers;

  UsersNotifier({required this.loadUsers}) : super(UsersState());

  Future<List<User>> loadNextPage() async {
    final newUsers = await loadUsers(limit: 10, offset: currentPage * 10);
    currentPage++;

    state = state.copyWith(users: [...state.users, ...newUsers], loading: false);

    return newUsers;
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
