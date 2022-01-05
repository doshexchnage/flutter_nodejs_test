part of 'registration_bloc.dart';

class RegistrationState extends Equatable {
  const RegistrationState({
    this.userName = const Name.pure(),
    this.age = const Age.pure(),
    this.password = const Password.pure(),
    this.togglePassword = true,
    this.confirmPassword = const ConfirmPassword.pure(),
    this.toggleConfirmPassword = true,
    this.status = FormzStatus.pure,
  });

  final Name userName;
  final Age age;
  final Password password;
  final bool togglePassword;
  final ConfirmPassword confirmPassword;
  final bool toggleConfirmPassword;
  final FormzStatus status;

    RegistrationState copyWith({
    required Name userName,
    required Age age,
    required Password password,
    required bool togglePassword,
    required ConfirmPassword confirmPassword,
    required bool toggleConfirmPassword,
    required FormzStatus status,
  }) {
    return RegistrationState(
      userName: userName,
      age: age,
      password: password,
      togglePassword: togglePassword,
      confirmPassword: confirmPassword,
      toggleConfirmPassword: toggleConfirmPassword,
      status: status,
    );
  }

  @override
  List<Object> get props => [
        userName,
        age,
        password,
        togglePassword,
        confirmPassword,
        toggleConfirmPassword,
        status
      ];
}

class RegistrationInitial extends RegistrationState {}


class SubmittingRegistrationState extends RegistrationState {}

class RegistrationStateResponse extends RegistrationState {
  final String title;
  final String message;
  final bool showCloseDialog;

  const RegistrationStateResponse(this.title, this.message, this.showCloseDialog)
      : super();
}

class RegistrationStateSuccess extends RegistrationState {}

class ToggledPassword extends RegistrationState {}

class ToggledConfirmPassword extends RegistrationState {}
