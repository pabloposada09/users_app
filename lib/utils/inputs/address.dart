import 'package:formz/formz.dart';
import 'package:users_app/utils/utils.dart';

// Define input validation errors
enum AddressError { empty, length }

// Extend FormzInput and provide the input type and error type.
class Address extends FormzInput<String, AddressError> {
  String? get errorMessage {
    if (isPure || isValid) return null;

    if (displayError == AddressError.empty) return InputErrorMessage.requiredField;

    if (displayError == AddressError.length) return InputErrorMessage.addressLength;

    return null;
  }

  // Call super.pure to represent an unmodified form input.
  const Address.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const Address.dirty({String value = ''}) : super.dirty(value);

  // Override validator to handle validating a given input value.
  @override
  AddressError? validator(String value) {
    if (value.trim().isEmpty) return AddressError.empty;

    if (value.trim().length < 7) return AddressError.length;

    return null;
  }
}
