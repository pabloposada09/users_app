import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:users_app/presentation/providers/address_provider.dart';
import 'package:users_app/presentation/widgets/widgets.dart';
import 'package:users_app/utils/utils.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Constants.addressesTitle),
      ),
      body: const _AddressBody(),
    );
  }
}

class _AddressBody extends ConsumerWidget {
  const _AddressBody();

  void handleState(FormStatus status, BuildContext context) {
    EasyLoading.dismiss();

    if (status == FormStatus.loading) {
      EasyLoading.show(status: Constants.loading);
      return;
    }

    if (status == FormStatus.successfullyPosted) {
      Dialogs.showPopUp(context, Constants.addressAddTitle, Constants.addressAddDesc, [
        FilledButton(
            onPressed: () {
              context.pop();
              context.pop();
            },
            child: const Text(Constants.accept))
      ]);

      return;
    }

    if (status == FormStatus.error) {
      Dialogs.showSnackBar(context, Constants.error);
      return;
    }
  }

  @override
  Widget build(BuildContext context, ref) {
    ref.listen(addressProvider, (previous, next) {
      handleState(next.formStatus, context);
    });

    final size = MediaQuery.of(context).size;

    final addressProviderRef = ref.watch(addressProvider);

    return Padding(
        padding: const EdgeInsets.symmetric(
          vertical: ScreenMeasures.verticalPadding,
          horizontal: ScreenMeasures.horizontalPadding,
        ),
        child: SingleChildScrollView(
            child: SizedBox(
          width: size.width,
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/icons/map.png',
                  width: size.width * 0.35,
                ),
                const SizedBox(
                  height: ScreenMeasures.spaceBetweenElements,
                ),
                CustomFormField(
                  label: Constants.addressHint,
                  hintText: Constants.addressHint,
                  onChanged: ref.read(addressProvider.notifier).onAddressChange,
                  errorText: addressProviderRef.formStatus == FormStatus.posted ? addressProviderRef.address.errorMessage : null,
                ),
                const SizedBox(
                  height: ScreenMeasures.spaceBetweenElements,
                ),
                FilledButton.icon(
                  onPressed: () => ref.read(addressProvider.notifier).onFormSubmit(),
                  icon: const Icon(Icons.add),
                  label: const Text(Constants.addAddress),
                )
              ],
            ),
          ),
        )));
  }
}
