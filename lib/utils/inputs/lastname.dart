import 'package:formz/formz.dart';
import 'package:users_app/utils/utils.dart';

// Define input validation errors
enum LastnameError { empty, length }

// Extend FormzInput and provide the input type and error type.
class Lastname extends FormzInput<String, LastnameError> {
  String? get errorMessage {
    if (isPure || isValid) return null;

    if (displayError == LastnameError.empty) return InputErrorMessage.requiredField;

    if (displayError == LastnameError.length) return InputErrorMessage.lastnameLength;

    return null;
  }

  // Call super.pure to represent an unmodified form input.
  const Lastname.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const Lastname.dirty({String value = ''}) : super.dirty(value);

  // Override validator to handle validating a given input value.
  @override
  LastnameError? validator(String value) {
    if (value.trim().isEmpty) return LastnameError.empty;

    if (value.trim().length < 5) return LastnameError.length;

    return null;
  }
}
