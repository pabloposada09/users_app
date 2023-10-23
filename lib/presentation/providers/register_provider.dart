import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:users_app/domain/domain.dart';
import 'package:users_app/presentation/providers/user_repository_provider.dart';
import 'package:users_app/utils/utils.dart';

final registerFormProvider = StateNotifierProvider.autoDispose<RegisterNotifier, RegisterFormState>((ref) {
  final userCreationCallback = ref.watch(userRepositoryProvider).createUser;

  return RegisterNotifier(createUser: userCreationCallback);
});

typedef UserCreationCallback = Future<bool> Function(User user);

class RegisterNotifier extends StateNotifier<RegisterFormState> {
  final GlobalKey<FormState> registerKey = GlobalKey<FormState>();
  final UserCreationCallback createUser;

  RegisterNotifier({required this.createUser}) : super(RegisterFormState());

  void nameChanged(String value) {
    final name = Name.dirty(value: value);

    state = state.copyWith(name: name, isValid: Formz.validate([name, state.lastname, state.address, state.birthDate]));
  }

  void lastnameChanged(String value) {
    final lastname = Lastname.dirty(value: value);

    state = state.copyWith(lastname: lastname, isValid: Formz.validate([lastname, state.name, state.address, state.birthDate]));
  }

  void addressChanged(String value) {
    final address = Address.dirty(value: value);

    state = state.copyWith(address: address, isValid: Formz.validate([address, state.name, state.lastname, state.birthDate]));
  }

  void birthDateChanged(String value) {
    final birthDate = BirthDate.dirty(value: value);

    state = state.copyWith(birthDate: birthDate, isValid: Formz.validate([birthDate, state.name, state.lastname, state.address]));
  }

  void onFormSubmit() async {
    _verifyAllFields();

    state = state.copyWith(formStatus: FormStatus.posted);

    if (state.isValid) {
      state = state.copyWith(formStatus: FormStatus.loading);
      try {
        final response = await createUser(User(
          name: state.name.value,
          lastname: state.lastname.value,
          birthDate: state.birthDate.value,
          addresses: [state.address.value],
        ));

        if (response) {
          state = state.copyWith(formStatus: FormStatus.successfullyPosted);

          state = RegisterFormState();

          registerKey.currentState?.reset();

          return;
        }

        state = state.copyWith(formStatus: FormStatus.error);
      } catch (e) {
        state = state.copyWith(formStatus: FormStatus.error);
      }
    }
  }

  void _verifyAllFields() {
    final name = Name.dirty(value: state.name.value);
    final lastname = Lastname.dirty(value: state.lastname.value);
    final address = Address.dirty(value: state.address.value);
    final birthDate = BirthDate.dirty(value: state.birthDate.value);

    state = state.copyWith(
      name: name,
      lastname: lastname,
      address: address,
      birthDate: birthDate,
      isValid: Formz.validate([
        name,
        lastname,
        address,
        birthDate,
      ]),
    );
  }
}

class RegisterFormState {
  final Name name;
  final Lastname lastname;
  final Address address;
  final BirthDate birthDate;
  final bool isValid;
  final FormStatus formStatus;

  RegisterFormState(
      {this.name = const Name.pure(),
      this.lastname = const Lastname.pure(),
      this.address = const Address.pure(),
      this.birthDate = const BirthDate.pure(),
      this.isValid = false,
      this.formStatus = FormStatus.initial});

  RegisterFormState copyWith(
          {Name? name,
          Lastname? lastname,
          Address? address,
          BirthDate? birthDate,
          bool? isPosting,
          bool? isValid,
          bool? isFormPosted,
          FormStatus? formStatus}) =>
      RegisterFormState(
          name: name ?? this.name,
          lastname: lastname ?? this.lastname,
          address: address ?? this.address,
          birthDate: birthDate ?? this.birthDate,
          isValid: isValid ?? this.isValid,
          formStatus: formStatus ?? this.formStatus);
}
