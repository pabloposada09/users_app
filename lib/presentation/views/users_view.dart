import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:users_app/presentation/providers/providers.dart';
import 'package:users_app/presentation/widgets/users/users_list.dart';
import 'package:users_app/presentation/widgets/widgets.dart';
import 'package:users_app/utils/utils.dart';

class UsersView extends ConsumerStatefulWidget {
  const UsersView({super.key});

  @override
  UsersViewState createState() => UsersViewState();
}

class UsersViewState extends ConsumerState<UsersView> {
  bool isLastPage = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    loadNextPage();
  }

  @override
  void dispose() {
    isLastPage = false;
    isLoading = false;
    super.dispose();
  }

  void loadNextPage() async {
    if (isLastPage || isLoading) return;

    isLoading = true;
    final usersList = await ref.read(usersProvider.notifier).loadNextPage();
    isLoading = false;

    if (usersList.isEmpty) isLastPage = true;
  }

  @override
  Widget build(BuildContext context) {
    final usersProviderRef = ref.watch(usersProvider);

    if (usersProviderRef.loading) {
      return const CustomLoading(message: Constants.loadingUsers);
    }

    if (usersProviderRef.users.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //imagen bad news
            Text(Constants.noUsers)
          ],
        ),
      );
    }

    return UsersList(
      users: usersProviderRef.users,
      loadPageCallback: loadNextPage,
    );
  }
}
