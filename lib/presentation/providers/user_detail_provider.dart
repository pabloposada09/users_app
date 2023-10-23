import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:users_app/domain/domain.dart';
import 'package:users_app/presentation/providers/user_repository_provider.dart';
import 'package:users_app/presentation/providers/users_provider.dart';
import 'package:users_app/utils/constants/constants.dart';

final userDetailProvider = StateNotifierProvider<UserDetailNotifier, UserDetailState>((ref) {
  final repository = ref.watch(userRepositoryProvider);

  final listCallback = ref.watch(usersProvider.notifier).deleteUserFromList;

  return UserDetailNotifier(usersRepository: repository, updateListCallBack: listCallback);
});

typedef UpdateListCallBack = void Function(int userId);

class UserDetailNotifier extends StateNotifier<UserDetailState> {
  final UsersRepository usersRepository;
  final UpdateListCallBack updateListCallBack;

  UserDetailNotifier({required this.usersRepository, required this.updateListCallBack}) : super(UserDetailState());

  Future<void> loadUser(int userId) async {
    try {
      final user = await usersRepository.getUserById(userId);
      state = state.copyWith(user: user);
    } catch (e) {
      state = state.copyWith(error: Constants.error);
    }
  }

  Future<bool> deleteUser(int userId) async {
    try {
      final status = await usersRepository.deleteUserById(userId);
      state = state.copyWith(user: null);
      updateListCallBack(userId);
      return status;
    } catch (e) {
      return false;
    }
  }

  void updateUser(User user) {
    state = state.copyWith(user: user);
  }
}

class UserDetailState {
  final User? user;
  final String? error;

  UserDetailState({this.user, this.error});

  UserDetailState copyWith({User? user, String? error}) => UserDetailState(
        user: user ?? this.user,
        error: error ?? this.error,
      );
}
