import 'package:formz/formz.dart';

enum NameValidationError { invalid }

class Name extends FormzInput<String, NameValidationError> {
  const Name.pure([String value = '']) : super.pure(value);
  const Name.dirty([String value = '']) : super.dirty(value);

  static final _userNameRegex =
      RegExp(r'^(?=.{8,20}$)(?![_.])(?!.*[_.]{2})[a-zA-Z0-9._]+(?<![_.])$');
  @override
  NameValidationError? validator(String value) {
    return _userNameRegex.hasMatch(value) ? NameValidationError.invalid : null;
  }
}
