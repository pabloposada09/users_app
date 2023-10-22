import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:users_app/domain/domain.dart';
import 'package:users_app/presentation/providers/user_repository_provider.dart';
import 'package:users_app/utils/constants/constants.dart';

final userDetailProvider = StateNotifierProvider<UserDetailNotifier, UserDetailState>((ref) {
  final repository = ref.watch(userRepositoryProvider);

  return UserDetailNotifier(getUserCallback: repository.getUserById);
});

typedef GetUserCallback = Future<User> Function(int userId);

class UserDetailNotifier extends StateNotifier<UserDetailState> {
  final GetUserCallback getUserCallback;

  UserDetailNotifier({required this.getUserCallback}) : super(UserDetailState());

  Future<void> loadUser(int userId) async {
    try {
      final user = await getUserCallback(userId);
      state = state.copyWith(user: user);
    } catch (e) {
      state = state.copyWith(error: Constants.error);
    }
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
