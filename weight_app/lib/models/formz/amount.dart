import 'package:formz/formz.dart';

enum AgeValidationError { invalid }

class Amount extends FormzInput<String, AgeValidationError> {
  const Amount.pure([String value = '']) : super.pure(value);
  const Amount.dirty([String value = '']) : super.dirty(value);

  // static final _phoneRegex = RegExp(
  //   r'^\+[1-9]{1}[0-9]{3,14}$',
  // );

  @override
  AgeValidationError? validator(String value) {

        if (int.tryParse(value) != null) {
          int amount = int.parse(value);
          if (amount > 6 && amount < 150){
            return null;
          }
        }

      return AgeValidationError.invalid;
  }
}

