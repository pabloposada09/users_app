import 'package:formz/formz.dart';
import 'package:users_app/utils/utils.dart';

// Define input validation errors
enum BirthDateError { empty }

// Extend FormzInput and provide the input type and error type.
class BirthDate extends FormzInput<String, BirthDateError> {
  String? get errorMessage {
    if (isPure || isValid) return null;

    if (displayError == BirthDateError.empty) return InputErrorMessage.requiredField;

    return null;
  }

  // Call super.pure to represent an unmodified form input.
  const BirthDate.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const BirthDate.dirty({String value = ''}) : super.dirty(value);

  // Override validator to handle validating a given input value.
  @override
  BirthDateError? validator(String value) {
    if (value.trim().isEmpty) return BirthDateError.empty;

    return null;
  }
}
