// ignore_for_file: prefer_const_constructors

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:formz/formz.dart';
import 'package:network_req/network_req.dart';
import 'package:weight_app/models/formz/name.dart';
import 'package:weight_app/models/formz/password.dart';
import 'package:weight_app/models/user_model.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<UserNameChanged>(_onUserNameChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<UserNameUnfocused>(_onUserNameUnfocused);
    on<PasswordUnfocused>(_onPasswordUnfocused);
    on<TogglePassword>(_onTogglePassword);
    on<FormSubmitted>(_onFormSubmiited);
  }

  final UserLoginAPI repo = UserLoginAPI();

  void _onUserNameChanged(UserNameChanged event, Emitter<LoginState> emit) {
    final userName = Name.dirty(event.userName);
    emit(state.copyWith(
      userName: userName.valid ? userName : Name.pure(event.userName),
      password: state.password,
      togglePassword: state.togglePassword,
      status: Formz.validate([userName, state.password]),
    ));
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<LoginState> emit) {
    final password = Password.dirty(event.password);
    emit(state.copyWith(
      userName: state.userName,
      password: password.valid ? password : Password.pure(event.password),
      togglePassword: state.togglePassword,
      status: Formz.validate([state.userName, password]),
    ));
  }

  void _onUserNameUnfocused(UserNameUnfocused event, Emitter<LoginState> emit) {
    final userName = Name.dirty(state.userName.value);
    emit(state.copyWith(
      userName: userName,
      password: state.password,
      togglePassword: state.togglePassword,
      status: Formz.validate([userName, state.password]),
    ));
  }

  void _onPasswordUnfocused(PasswordUnfocused event, Emitter<LoginState> emit) {
    final password = Password.dirty(state.password.value);
    emit(state.copyWith(
      userName: state.userName,
      password: password,
      togglePassword: state.togglePassword,
      status: Formz.validate([state.userName, password]),
    ));
  }

  void _onTogglePassword(TogglePassword event, Emitter<LoginState> emit) {
    emit(state.copyWith(
        userName: state.userName,
        password: state.password,
        togglePassword: !state.togglePassword,
        status: Formz.validate([state.userName, state.password])));
  }

  Future<void> _onFormSubmiited(
      FormSubmitted event, Emitter<LoginState> emit) async {
    final userName = Name.dirty(state.userName.value);
    final password = Password.dirty(state.password.value);

    emit(state.copyWith(
      userName: userName,
      password: password,
      togglePassword: state.togglePassword,
      status: Formz.validate([userName, password]),
    ));

    if (state.status.isValidated) {
      // Display progress indicator
      emit(SubmittingLogin());

      try {
        var sendReq =
            await repo.requestFunction(userName.value, password.value);
        if (sendReq.response.responseCode == 201) {
          emit(LoginSuccess(UserLogin.fromJson(sendReq.data)));
        } else if (sendReq.response.responseCode == 401) {
          emit(LoginResponse("Invalid Login", sendReq.response.msg, true));
          await Future.delayed(Duration(seconds: 5));
          emit(LoginInitial());
        }
      } catch (e) {
        emit(LoginResponse("Invalid Login", e.toString(), true));
        await Future.delayed(Duration(seconds: 5));
        emit(LoginInitial());
      }
    }
  }
}
