import 'package:formz/formz.dart';

enum AmountValidationError { invalid }

class Weight extends FormzInput<String, AmountValidationError> {
  const Weight.pure([String value = '']) : super.pure(value);
  const Weight.dirty([String value = '']) : super.dirty(value);

  // static final _phoneRegex = RegExp(
  //   r'^\+[1-9]{1}[0-9]{3,14}$',
  // );

  @override
  AmountValidationError? validator(String value) {

        if (double.tryParse(value) != null) {
          double weight = double.parse(double.parse(value).toStringAsFixed(2));
          if (weight > 5.00 && weight < 10000.00){
            return null;
          }
        }

      return AmountValidationError.invalid;
  }
}

