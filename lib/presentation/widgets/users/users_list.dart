import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:users_app/domain/entities/user.dart';
import 'package:users_app/utils/constants/constants.dart';
import 'package:users_app/utils/constants/navigation.dart';

class UsersList extends StatefulWidget {
  final List<User> users;
  final void Function()? loadPageCallback;
  const UsersList({
    super.key,
    required this.users,
    this.loadPageCallback,
  });

  @override
  State<UsersList> createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  ScrollController controller = ScrollController();
  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      if (controller.position.pixels + 250 >= controller.position.maxScrollExtent) {
        if (widget.loadPageCallback == null) return;

        widget.loadPageCallback!();
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: controller,
      itemCount: widget.users.length,
      itemBuilder: (context, index) {
        final user = widget.users[index];
        return ListTile(
          onTap: () {
            context.go('${Navigation.usersRoute}${Navigation.userDetailRoute}${user.isarId}');
          },
          title: Text(user.name),
          subtitle: Text(user.lastname),
          trailing: const Icon(Icons.arrow_forward_ios_rounded),
        );
      },
    );
  }
}
