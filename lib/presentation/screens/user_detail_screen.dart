import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:users_app/domain/domain.dart';
import 'package:users_app/presentation/providers/user_detail_provider.dart';
import 'package:users_app/presentation/widgets/widgets.dart';
import 'package:users_app/utils/utils.dart';

class UserDetailScreen extends ConsumerStatefulWidget {
  final int userId;
  const UserDetailScreen({super.key, required this.userId});

  @override
  UserDetailScreenState createState() => UserDetailScreenState();
}

class UserDetailScreenState extends ConsumerState<UserDetailScreen> {
  @override
  void initState() {
    super.initState();

    ref.read(userDetailProvider.notifier).loadUser(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userDetailProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(Constants.userDetailTitle),
      ),
      body: user.user == null
          ? const CustomLoading(message: Constants.loadingUser)
          : Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: ScreenMeasures.horizontalPadding,
                vertical: ScreenMeasures.verticalPadding,
              ),
              child: Column(
                children: [
                  _UserCard(user: user.user!),
                  _UserAddresses(addresses: user.user!.addresses),
                ],
              ),
            ),
      floatingActionButton: user.user == null ? null : const _UserOptions(),
    );
  }
}

class _UserCard extends StatelessWidget {
  final User user;
  const _UserCard({
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textStyles = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: ScreenMeasures.horizontalPadding / 2,
            vertical: ScreenMeasures.verticalPadding / 2,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                maxRadius: size.width * 0.25,
                backgroundColor: colors.primary.withOpacity(0.5),
                child: Image.asset('assets/icons/user.png'),
              ),
              const SizedBox(
                height: ScreenMeasures.spaceBetweenElements,
              ),
              SizedBox(
                width: size.width * 0.6,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      user.name + user.lastname,
                      style: textStyles.titleLarge?.copyWith(
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: ScreenMeasures.spaceBetweenElements,
                    ),
                    Text(
                      user.birthDate,
                      style: textStyles.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class _UserAddresses extends StatelessWidget {
  final List<String> addresses;
  const _UserAddresses({required this.addresses});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return ExpansionTile(
      title: const Text(Constants.addresses),
      children: List.generate(addresses.length, (index) {
        final address = addresses[index];
        return ListTile(
          title: Text(address),
          leading: Icon(
            Icons.location_on,
            color: colors.primary,
          ),
        );
      }),
    );
  }
}

class _UserOptions extends StatelessWidget {
  const _UserOptions();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: 20,
          right: 0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FilledButton.icon(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.restore_from_trash_rounded,
                    color: Colors.red,
                  ),
                  label: const Text(Constants.deleteUser)),
              FilledButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.add),
                label: const Text(Constants.addAddress),
              )
            ],
          ),
        )
      ],
    );
  }
}
