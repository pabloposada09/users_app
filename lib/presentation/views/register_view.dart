import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:users_app/presentation/providers/register_provider.dart';
import 'package:users_app/presentation/widgets/widgets.dart';
import 'package:users_app/utils/utils.dart';

class RegisterView extends ConsumerWidget {
  const RegisterView({super.key});

  void handleState(FormStatus status, BuildContext context) {
    EasyLoading.dismiss();

    if (status == FormStatus.loading) {
      EasyLoading.show(status: 'Loading...');
      return;
    }

    if (status == FormStatus.successfullyPosted) {
      EasyLoading.showSuccess(
        'Usuario creado correctamente',
        duration: const Duration(seconds: 1),
        dismissOnTap: true,
      );
      context.go(Navigation.usersRoute);
      return;
    }

    if (status == FormStatus.error) {
      EasyLoading.showError('Ups, ocurrio un error');
      return;
    }
  }

  @override
  Widget build(BuildContext context, ref) {
    final registerProvider = ref.watch(registerFormProvider);

    final name = registerProvider.name;
    final lastname = registerProvider.lastname;
    final address = registerProvider.address;
    final birthDate = registerProvider.birthDate;

    ref.listen(registerFormProvider, (previous, next) {
      handleState(next.formStatus, context);
    });

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: ScreenMeasures.verticalPadding,
          horizontal: ScreenMeasures.horizontalPadding,
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomFormField(
                  label: Constants.nameHint,
                  hintText: Constants.nameHint,
                  onChanged: ref.read(registerFormProvider.notifier).nameChanged,
                  errorText: registerProvider.formStatus == FormStatus.posted ? name.errorMessage : null,
                ),
                const SizedBox(
                  height: ScreenMeasures.spaceBetweenElements,
                ),
                CustomFormField(
                  label: Constants.lastnameHint,
                  hintText: Constants.lastnameHint,
                  onChanged: ref.read(registerFormProvider.notifier).lastnameChanged,
                  errorText: registerProvider.formStatus == FormStatus.posted ? lastname.errorMessage : null,
                ),
                const SizedBox(
                  height: ScreenMeasures.spaceBetweenElements,
                ),
                CustomFormField(
                  label: Constants.addressHint,
                  hintText: Constants.addressHint,
                  onChanged: ref.read(registerFormProvider.notifier).addressChanged,
                  errorText: registerProvider.formStatus == FormStatus.posted ? address.errorMessage : null,
                ),
                const SizedBox(
                  height: ScreenMeasures.spaceBetweenElements,
                ),
                CustomDatePicker(
                  title: Constants.birthDate,
                  label: Constants.birthDate,
                  hint: Constants.birthDate,
                  onChanged: ref.read(registerFormProvider.notifier).birthDateChanged,
                  errorMessage: registerProvider.formStatus == FormStatus.posted ? birthDate.errorMessage : null,
                ),
                const SizedBox(
                  height: ScreenMeasures.spaceBetweenElements,
                ),
                FilledButton.icon(
                  onPressed: ref.read(registerFormProvider.notifier).onFormSubmit,
                  icon: const Icon(Icons.add),
                  label: const Text(Constants.createUser),
                )
              ],
            )),
          ),
        ),
      ),
    );
  }
}
