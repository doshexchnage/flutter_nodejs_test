import 'package:formz/formz.dart';

enum WeightValidationError { invalid }

class Weight extends FormzInput<String, WeightValidationError> {
  const Weight.pure([String value = '']) : super.pure(value);
  const Weight.dirty([String value = '']) : super.dirty(value);

  // static final _phoneRegex = RegExp(
  //   r'^\+[1-9]{1}[0-9]{3,14}$',
  // );

  @override
  WeightValidationError? validator(String value) {
    if (double.tryParse(value) != null) {
      double amount = double.parse(double.parse(value).toStringAsFixed(2));
      if (amount > 5.00 && amount < 1000.00) {
        return null;
      }
    }

    return WeightValidationError.invalid;
  }
}
