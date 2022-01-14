part of 'login_bloc.dart';


abstract class LoginEvent extends Equatable {
  const LoginEvent();
  @override
  List<Object> get props => [];
}


class UserNameChanged extends LoginEvent {
  const UserNameChanged({required this.userName});

  final String userName;

  @override
  List<Object> get props => [userName];
}

class UserNameUnfocused extends LoginEvent {}

class PasswordChanged extends LoginEvent {
  const PasswordChanged({required this.password});

  final String password;

  @override
  List<Object> get props => [password];
}

class PasswordUnfocused extends LoginEvent {}

class FormSubmitted extends LoginEvent {}


class TogglePassword extends LoginEvent {}