part of 'registration_bloc.dart';

@immutable
abstract class RegistrationEvent  extends Equatable {
  const RegistrationEvent();

  @override
  List<Object> get props => [];
}

class UserNameChanged extends RegistrationEvent {
  const UserNameChanged({required this.userName});

  final String userName;

  @override
  List<Object> get props => [userName];
}

class UserNameUnfocused extends RegistrationEvent {}


class UserAgeChanged extends RegistrationEvent {
  const UserAgeChanged({required this.age});

  final int age;

  @override
  List<Object> get props => [age ];
}

class UserAgeUnfocused extends RegistrationEvent {}

class PasswordChanged extends RegistrationEvent {
  const PasswordChanged({required this.password});

  final String password;

  @override
  List<Object> get props => [password];
}

class PasswordUnfocused extends RegistrationEvent {}

class ConfirmPasswordChanged extends RegistrationEvent  {
  const ConfirmPasswordChanged({
    required this.confirmPassword,
  });

  final String confirmPassword;

  @override
  List<Object> get props => [confirmPassword];
}

class ConfirmPasswordUnfocused extends RegistrationEvent  {}

class FormSubmitted extends RegistrationEvent  {}

class TogglePassword extends RegistrationEvent  {}

class ToggleConfirmPassword extends RegistrationEvent  {}