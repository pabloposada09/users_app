import 'package:formz/formz.dart';
import 'package:users_app/utils/utils.dart';

// Define input validation errors
enum NameError { empty, length }

// Extend FormzInput and provide the input type and error type.
class Name extends FormzInput<String, NameError> {
  String? get errorMessage {
    if (isPure || isValid) return null;

    if (displayError == NameError.empty) return InputErrorMessage.requiredField;

    if (displayError == NameError.length) return InputErrorMessage.nameLength;

    return null;
  }

  // Call super.pure to represent an unmodified form input.
  const Name.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const Name.dirty({String value = ''}) : super.dirty(value);

  // Override validator to handle validating a given input value.
  @override
  NameError? validator(String value) {
    if (value.trim().isEmpty) return NameError.empty;

    if (value.trim().length < 5) return NameError.length;

    return null;
  }
}
