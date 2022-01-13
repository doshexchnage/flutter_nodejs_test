// ignore_for_file: await_only_futures, prefer_const_constructors

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:formz/formz.dart';
import 'package:meta/meta.dart';
import 'package:network_req/network_req.dart';
import 'package:weight_app/models/formz/age.dart';
import 'package:weight_app/models/formz/confirm_password.dart';
import 'package:weight_app/models/formz/name.dart';
import 'package:weight_app/models/formz/password.dart';

part 'registration_event.dart';
part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  RegistrationBloc() : super(RegistrationInitial()) {
    on<UserNameChanged>(_onUserNameChanged);
    on<UserNameUnfocused>(_onUserNameUnfocused);
    on<UserAgeChanged>(_onAgeChanged);
    on<UserAgeUnfocused>(_onAgeUnfocused);
    on<PasswordChanged>(_onPasswordChanged);
    on<PasswordUnfocused>(_onPasswordUnfocused);
    on<ConfirmPasswordChanged>(_onConfirmPasswordChanged);
    on<ConfirmPasswordUnfocused>(_onConfirmPasswordUnfocused);
    on<TogglePassword>(_onTogglePassword);
    on<ToggleConfirmPassword>(_onToggleConfirmPassword);
    on<FormSubmitted>(_onFormSubmitted);

  }

  final UserRegistrationAPI repo = UserRegistrationAPI();

  void _onUserNameChanged(
      UserNameChanged event, Emitter<RegistrationState> emit) {
    final userName = Name.dirty(event.userName);

    emit(state.copyWith(
      userName: userName.valid ? userName : Name.pure(event.userName),
      age: state.age,
      password: state.password,
      confirmPassword: state.confirmPassword,
      togglePassword: state.togglePassword,
      toggleConfirmPassword: state.toggleConfirmPassword,
      status: Formz.validate(
          [userName, state.age, state.password, state.confirmPassword]),
    ));
  }

  void _onAgeChanged(UserAgeChanged event, Emitter<RegistrationState> emit) {
    final age = Age.dirty(event.age.toString());

    emit(state.copyWith(
      userName: state.userName,
      age: age.valid ? age : Age.pure(event.age.toString()),
      password: state.password,
      confirmPassword: state.confirmPassword,
      togglePassword: state.togglePassword,
      toggleConfirmPassword: state.toggleConfirmPassword,
      status: Formz.validate(
          [state.userName, age, state.password, state.confirmPassword]),
    ));
  }

  void _onPasswordChanged(
      PasswordChanged event, Emitter<RegistrationState> emit) {
    final password = Password.dirty(event.password);

    emit(state.copyWith(
      userName: state.userName,
      age: state.age,
      password: password.valid ? password : Password.pure(event.password),
      confirmPassword: state.confirmPassword,
      togglePassword: state.togglePassword,
      toggleConfirmPassword: state.toggleConfirmPassword,
      status: Formz.validate(
          [state.userName, state.age, password, state.confirmPassword]),
    ));
  }

  void _onConfirmPasswordChanged(
      ConfirmPasswordChanged event, Emitter<RegistrationState> emit) {
    final confirmPassword = ConfirmPassword.dirty(
        password: state.password.value, value: event.confirmPassword);

    emit(state.copyWith(
      userName: state.userName,
      age: state.age,
      password: state.password,
      confirmPassword: confirmPassword.valid
          ? confirmPassword
          : const ConfirmPassword.pure(),
      togglePassword: state.togglePassword,
      toggleConfirmPassword: state.toggleConfirmPassword,
      status: Formz.validate(
          [state.userName, state.age, state.password, confirmPassword]),
    ));
  }

  void _onUserNameUnfocused(
      UserNameUnfocused event, Emitter<RegistrationState> emit) {
    final userName = Name.dirty(state.userName.value);

    emit(state.copyWith(
      userName: userName,
      age: state.age,
      password: state.password,
      confirmPassword: state.confirmPassword,
      togglePassword: state.togglePassword,
      toggleConfirmPassword: state.toggleConfirmPassword,
      status: Formz.validate(
          [userName, state.age, state.password, state.confirmPassword]),
    ));
  }

  void _onAgeUnfocused(
      UserAgeUnfocused event, Emitter<RegistrationState> emit) {
    final age = Age.dirty(state.age.value.toString());

    emit(state.copyWith(
      userName: state.userName,
      age: age,
      password: state.password,
      confirmPassword: state.confirmPassword,
      togglePassword: state.togglePassword,
      toggleConfirmPassword: state.toggleConfirmPassword,
      status: Formz.validate(
          [state.userName, age, state.password, state.confirmPassword]),
    ));
  }

  void _onPasswordUnfocused(
      PasswordUnfocused event, Emitter<RegistrationState> emit) {
    final password = Password.dirty(state.password.value);

    emit(state.copyWith(
      userName: state.userName,
      age: state.age,
      password: password,
      confirmPassword: state.confirmPassword,
      togglePassword: state.togglePassword,
      toggleConfirmPassword: state.toggleConfirmPassword,
      status: Formz.validate(
          [state.userName, state.age, password, state.confirmPassword]),
    ));
  }

  void _onConfirmPasswordUnfocused(
      ConfirmPasswordUnfocused event, Emitter<RegistrationState> emit) {
    final confirmPassword = ConfirmPassword.dirty(
        password: state.password.value, value: state.confirmPassword.value);

    emit(state.copyWith(
      userName: state.userName,
      age: state.age,
      password: state.password,
      confirmPassword: confirmPassword,
      togglePassword: state.togglePassword,
      toggleConfirmPassword: state.toggleConfirmPassword,
      status: Formz.validate(
          [state.userName, state.age, state.password, confirmPassword]),
    ));
  }

  void _onTogglePassword(
      TogglePassword event, Emitter<RegistrationState> emit) {
    emit(state.copyWith(
        userName: state.userName,
        age: state.age,
        password: state.password,
        confirmPassword: state.confirmPassword,
        togglePassword: !state.togglePassword,
        toggleConfirmPassword: state.toggleConfirmPassword,
        status: Formz.validate([
          state.userName,
          state.age,
          state.password,
          state.confirmPassword
        ])));
  }

  void _onToggleConfirmPassword(
      ToggleConfirmPassword event, Emitter<RegistrationState> emit) {
    emit(state.copyWith(
        userName: state.userName,
        age: state.age,
        password: state.password,
        confirmPassword: state.confirmPassword,
        togglePassword: state.togglePassword,
        toggleConfirmPassword: !state.toggleConfirmPassword,
        status: Formz.validate([
          state.userName,
          state.age,
          state.password,
          state.confirmPassword
        ])));
  }

  Future<void> _onFormSubmitted(
      FormSubmitted event, Emitter<RegistrationState> emit) async {
    final userName = Name.dirty(state.userName.value);
    final age = Age.dirty(state.age.value);
    final password = Password.dirty(state.password.value);
    final confirmPassword = ConfirmPassword.dirty(
        password: state.password.value, value: state.confirmPassword.value);

    emit(state.copyWith(
      userName: state.userName,
      age: state.age,
      password: state.password,
      togglePassword: state.togglePassword,
      confirmPassword: state.confirmPassword,
      toggleConfirmPassword: state.toggleConfirmPassword,
      status: Formz.validate([userName, age, password, confirmPassword]),
    ));

    if (state.status.isValidated) {
      emit(SubmittingRegistrationState());
      var sendReq = await repo.requestFunction(
          userName.value, password.value, int.parse(age.value));

      if (sendReq.responseCode == 201) {
        emit(RegistrationStateResponse(
            'Success', sendReq.msg + " Please head to login page", true));
      } else {
        emit(RegistrationStateResponse('Failure', sendReq.msg, true));
      }
      // if (kDebugMode) {
      //   print(userName.value);
      //   print(age.value);
      //   print(password.value);
      //   print(confirmPassword.value);
      // }
    }
  }
}
