import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:users_app/presentation/providers/register_provider.dart';
import 'package:users_app/presentation/widgets/widgets.dart';
import 'package:users_app/utils/utils.dart';

class RegisterView extends ConsumerStatefulWidget {
  const RegisterView({super.key});

  @override
  RegisterViewState createState() => RegisterViewState();
}

class RegisterViewState extends ConsumerState<RegisterView> {
  void handleState(FormStatus status, BuildContext context) {
    EasyLoading.dismiss();

    if (status == FormStatus.loading) {
      EasyLoading.show(status: Constants.loading);
      return;
    }

    if (status == FormStatus.successfullyPosted) {
      Dialogs.showSnackBar(context, Constants.userCreatedSuccessfully);

      return;
    }

    if (status == FormStatus.error) {
      EasyLoading.showError(Constants.error);
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    final registerProvider = ref.watch(registerFormProvider);

    final name = registerProvider.name;
    final lastname = registerProvider.lastname;
    final address = registerProvider.address;
    final birthDate = registerProvider.birthDate;

    ref.listen(registerFormProvider, (previous, next) {
      handleState(next.formStatus, context);
    });

    final size = MediaQuery.of(context).size;
    final colors = Theme.of(context).colorScheme;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: ScreenMeasures.verticalPadding,
          horizontal: ScreenMeasures.horizontalPadding,
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
                key: ref.read(registerFormProvider.notifier).registerKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/icons/user-creation.png',
                      width: size.width * 0.35,
                      color: colors.primary,
                    ),
                    const SizedBox(
                      height: ScreenMeasures.spaceBetweenElements,
                    ),
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
