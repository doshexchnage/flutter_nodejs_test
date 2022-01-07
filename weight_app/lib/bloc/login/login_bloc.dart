import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:formz/formz.dart';
import 'package:meta/meta.dart';
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

  void _onUserNameChanged(UserNameChanged event, Emitter<LoginState> emit) {
    final email = Name.dirty(event.userName);
    emit(state.copyWith(
      userName: email.valid ? email : Name.pure(event.userName),
      password: state.password,
      togglePassword: state.togglePassword,
      status: Formz.validate([email, state.password]),
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
      if (kDebugMode) {
        print(userName.value);
        print(password.value);
      }
      emit(LoginInitial());

      // Connecting with login repository
      // try {
      //   var apiResponse = await repo.userLogin(email.value, password.value);

      //   if (apiResponse.responseCode == 201) {
      //     if (apiResponse.userInfo != null) {
      //       emit(LoginSuccess(apiResponse.userInfo!));
      //     } else {
      //       await Future.delayed(const Duration(seconds: 2));
      //       emit(const LoginResponse("Detail", "Please Try Again", true));
      //       await Future.delayed(const Duration(seconds: 3));
      //       emit(InitialLogin());
      //     }
      //   } else {
      //     emit(LoginResponse("Detail", apiResponse.msg.toString(), true));
      //     await Future.delayed(const Duration(seconds: 3));
      //     emit(InitialLogin());
      //   }
      // } catch (e) {
      //   emit(LoginResponse("Detail", e.toString(), true));
      //   await Future.delayed(const Duration(seconds: 3));
      //   emit(InitialLogin());
      // }
    }
  }
}
