import 'package:formz/formz.dart';

enum AgeValidationError { invalid }

class Age extends FormzInput<String, AgeValidationError> {
  const Age.pure([String value = '']) : super.pure(value);
  const Age.dirty([String value = '']) : super.dirty(value);

  // static final _phoneRegex = RegExp(
  //   r'^\+[1-9]{1}[0-9]{3,14}$',
  // );

  @override
  AgeValidationError? validator(String value) {
    if (int.tryParse(value) != null) {
      int age = int.parse(value);
      if (age >= 12) {
        return null;
      } else {
        return AgeValidationError.invalid;
      }
    } else {
      return AgeValidationError.invalid;
    }
  }
}
