import 'package:formz/formz.dart';

enum ConfirmedPasswordValidationError {
  invalid,
  mismatch,
}

class ConfirmPassword
    extends FormzInput<String, ConfirmedPasswordValidationError> {
  final String password;

  const ConfirmPassword.pure({this.password = ''}) : super.pure('');

  const ConfirmPassword.dirty({required this.password, String value = ''})
      : super.dirty(value);

  static final _passwordRegex =
  RegExp(r'^(.{0,7}|[^0-9]*|[^A-Z]*|[^a-z]*|[a-zA-Z0-9]*)$');

  @override
  ConfirmedPasswordValidationError? validator(String value) {
    if (_passwordRegex.hasMatch(value)) {
      return ConfirmedPasswordValidationError.invalid;
    }
    return password == value ? null : ConfirmedPasswordValidationError.mismatch;
  }
}

extension Explanation on ConfirmedPasswordValidationError {
  String? get name {
    switch (this) {
      case ConfirmedPasswordValidationError.mismatch:
        return 'passwords must match';
      default:
        return null;
    }
  }
}