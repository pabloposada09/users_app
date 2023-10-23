import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:users_app/domain/entities/user.dart';
import 'package:users_app/presentation/providers/providers.dart';
import 'package:users_app/utils/enums/form_enum.dart';
import 'package:users_app/utils/inputs/address.dart';

final addressProvider = StateNotifierProvider.autoDispose<AddressNotifier, AddressState>((ref) {
  final userInfo = ref.watch(userDetailProvider);
  final updateUserCallback = ref.watch(userDetailProvider.notifier).updateUser;
  final updateUserListCallback = ref.watch(usersProvider.notifier).updateUserInList;
  final updateUserDatabaseCallback = ref.watch(userRepositoryProvider).updateUser;

  return AddressNotifier(
      saveUserChangesCallback: updateUserDatabaseCallback,
      updateUserProviderCallback: updateUserCallback,
      updateUsersListProviderCallback: updateUserListCallback,
      user: userInfo.user!);
});

//Repository call
typedef SaveUserChangesCallback = Future<bool> Function(User user);
//Update user provider
typedef UpdateUserProviderCallback = void Function(User userId);
//Update usersList
typedef UpdateUsersListProviderCallback = void Function(User userId);

class AddressNotifier extends StateNotifier<AddressState> {
  final SaveUserChangesCallback saveUserChangesCallback;
  final UpdateUserProviderCallback updateUserProviderCallback;
  final UpdateUsersListProviderCallback updateUsersListProviderCallback;
  User user;

  AddressNotifier(
      {required this.saveUserChangesCallback,
      required this.updateUserProviderCallback,
      required this.updateUsersListProviderCallback,
      required this.user})
      : super(AddressState());

  void onAddressChange(String value) {
    final address = Address.dirty(value: value);

    state = state.copyWith(address: address, isValid: Formz.validate([address]));
  }

  onFormSubmit() async {
    final address = Address.dirty(value: state.address.value);

    state = state.copyWith(
        address: address,
        isValid: Formz.validate(
          [address],
        ),
        formStatus: FormStatus.posted);

    if (state.isValid) {
      try {
        user = user.copyWith(addresses: [...user.addresses, address.value]);
        final response = await saveUserChangesCallback(user);

        if (response) {
          state = state.copyWith(formStatus: FormStatus.successfullyPosted);

          state = AddressState();
          updateUserProviderCallback(user);
          updateUsersListProviderCallback(user);

          return;
        }

        state = state.copyWith(formStatus: FormStatus.error);
      } catch (e) {
        state = state.copyWith(formStatus: FormStatus.error);
      }
    }
  }
}

class AddressState {
  final Address address;
  final bool isValid;
  final FormStatus formStatus;

  AddressState({
    this.address = const Address.pure(),
    this.isValid = false,
    this.formStatus = FormStatus.initial,
  });

  AddressState copyWith({
    Address? address,
    bool? isValid,
    FormStatus? formStatus,
  }) =>
      AddressState(
        address: address ?? this.address,
        isValid: isValid ?? this.isValid,
        formStatus: formStatus ?? this.formStatus,
      );
}
