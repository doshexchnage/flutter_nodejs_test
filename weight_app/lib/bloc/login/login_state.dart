part of 'login_bloc.dart';

class LoginState extends Equatable {
  const LoginState({
    this.userName = const Name.pure(),
    this.password = const Password.pure(),
    this.togglePassword = true,
    this.status = FormzStatus.pure,
  });

  final Name userName;
  final Password password;
  final FormzStatus status;
  final bool togglePassword;

  LoginState copyWith({
    Name? userName,
    Password? password,
    bool? togglePassword,
    FormzStatus? status,
  }) {
    return LoginState(
      userName: userName ?? this.userName,
      password: password ?? this.password,
      togglePassword: togglePassword ?? this.togglePassword,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [userName, password, togglePassword, status];
}

class LoginInitial extends LoginState {}

class SubmittingLogin extends LoginState {}

class LoginResponse extends LoginState {
  final String title;
  final String message;
  final bool showCloseDialog;

  const LoginResponse(this.title, this.message, this.showCloseDialog) : super();
}

class LoginSuccess extends LoginState {
  final UserLogin userInfo;
  const LoginSuccess(this.userInfo) : super();
}

class ToggledPassword extends LoginState {}