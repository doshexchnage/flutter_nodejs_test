// ignore_for_file: prefer_const_constructors, prefer_function_declarations_over_variables, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:weight_app/bloc/registration/registration_bloc.dart';
import 'package:weight_app/models/constants.dart';

class RegistrationPage extends StatefulWidget {
  RegistrationPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  void _showDialog(String title, String body, bool closeDia) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          elevation: 0,
          backgroundColor: Color(0xFF212332),
          // title: new Text(title,
          //     textAlign: TextAlign.center,
          //     style: TextStyle(
          //       color: Colors.white,
          //     )),
          content: Text(body,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white)),
          actions: closeDia
              ? <Widget>[
                  // usually buttons at the bottom of the dialog
                  Container(
                    margin: EdgeInsets.all(20),
                    child: FlatButton(
                      child: Text("Close"),
                      color: primaryColor,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ]
              : null,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: secondaryColor,
        appBar: AppBar(
          backgroundColor: bgColor,
          title: Center(child: Text(widget.title)),
        ),
        body: SafeArea(
            child: ListView(
          children: [
            BlocProvider<RegistrationBloc>(
              create: (context) => RegistrationBloc(),
              child: BlocListener<RegistrationBloc, RegistrationState>(
                listener: (context, state) {
                  if (state is RegistrationStateResponse) {
                    _showDialog(
                        state.title, state.message, state.showCloseDialog);
                  }
                  if (state is RegistrationStateSuccess) {
                    // Navigator.pushReplacement(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (BuildContext context) => BlocProvider(
                    //             create: (context) =>
                    //                 NavigationBloc(userInfo: ''),
                    //             child: Home(userinfo: state.userInfo))));
                  }
                },
                child: LoginForm(),
              ),
            )
          ],
        )));
  }
}

class LoginForm extends StatefulWidget {
  LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _userNameFocusNode = FocusNode();
  final _ageFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _confirmPasswordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _userNameFocusNode.addListener(() {
      if (!_userNameFocusNode.hasFocus) {
        context.read<RegistrationBloc>().add(UserNameUnfocused());
        // FocusScope.of(context).requestFocus(_ageFocusNode);
      }
    });

    _ageFocusNode.addListener(() {
      if (!_ageFocusNode.hasFocus) {
        context.read<RegistrationBloc>().add(UserNameUnfocused());
        // FocusScope.of(context).requestFocus(_passwordFocusNode);
      }
    });

    _passwordFocusNode.addListener(() {
      if (!_passwordFocusNode.hasFocus) {
        context.read<RegistrationBloc>().add(PasswordUnfocused());
        // FocusScope.of(context).requestFocus(_confirmPasswordFocusNode);
      }
    });

    _confirmPasswordFocusNode.addListener(() {
      if (!_confirmPasswordFocusNode.hasFocus) {
        context.read<RegistrationBloc>().add(PasswordUnfocused());
      }
    });
  }

  @override
  void dispose() {
    _userNameFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      margin: EdgeInsets.symmetric(vertical: 75),
      height: 550,
      child: Column(
        children: [
          // Username
          // Age
          // Password
          // Confirm Password
          // Submit Button
          Expanded(
              flex: 2,
              child: Container(
                  alignment: Alignment.center,
                  child: BlocBuilder<RegistrationBloc, RegistrationState>(
                    builder: (context, state) {
                      return TextFormField(
                        initialValue: state.userName.value,
                        focusNode: _userNameFocusNode,
                        cursorColor: Colors.white,
                        style: TextStyle(color: Colors.white, fontSize: 24),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(12),
                          isDense: true,
                          labelStyle:
                              TextStyle(color: Colors.white, fontSize: 20),
                          helperStyle: TextStyle(color: Colors.white),
                          icon: const Icon(Icons.account_circle,
                              size: 30, color: Colors.white),
                          helperText:
                              '''A complete, valid first name e.g John''',
                          helperMaxLines: 2,
                          labelText: 'First Name',
                          errorMaxLines: 2,
                          errorText: state.userName.invalid
                              ? '''Username must be 3 or more charactors without spaces'''
                              : null,
                        ),
                        onChanged: (value) {
                          context
                              .read<RegistrationBloc>()
                              .add(UserNameChanged(userName: value));
                        },
                        keyboardType: TextInputType.name,
                        // textInputAction: TextInputAction.next,
                      );
                    },
                  ))),
          Expanded(
              flex: 2,
              child: Container(
                  alignment: Alignment.center,
                  child: BlocBuilder<RegistrationBloc, RegistrationState>(
                    builder: (context, state) {
                      return TextFormField(
                        initialValue: state.age.value,
                        focusNode: _ageFocusNode,
                        cursorColor: Colors.white,
                        style: TextStyle(color: Colors.white, fontSize: 24),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(12),
                          isDense: true,
                          labelStyle:
                              TextStyle(color: Colors.white, fontSize: 20),
                          helperStyle: TextStyle(color: Colors.white),
                          icon: const Icon(Icons.account_circle,
                              size: 30, color: Colors.white),
                          helperText: '''Age as a whole Number e.g 16''',
                          helperMaxLines: 2,
                          labelText: 'Age',
                          errorMaxLines: 2,
                          errorText: state.age.invalid
                              ? '''Must be 12 years and older'''
                              : null,
                        ),
                        onChanged: (value) {
                          context
                              .read<RegistrationBloc>()
                              .add(UserAgeChanged(age: int.parse(value)));
                        },
                        keyboardType: TextInputType.number,
                        // textInputAction: TextInputAction.next,
                      );
                    },
                  ))),
          Expanded(
              flex: 2,
              child: Container(
                  alignment: Alignment.center,
                  child: BlocBuilder<RegistrationBloc, RegistrationState>(
                    builder: (context, state) {
                      return TextFormField(
                        cursorColor: Colors.white,
                        initialValue: state.password.value,
                        focusNode: _passwordFocusNode,
                        style: TextStyle(color: Colors.white, fontSize: 24),
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(12),
                            isDense: true,
                            labelStyle:
                                TextStyle(color: Colors.white, fontSize: 20),
                            helperStyle: TextStyle(color: Colors.white),
                            icon: const Icon(
                              Icons.lock,
                              color: Colors.white,
                              size: 30,
                            ),
                            helperText: state.password.valid
                                ? null
                                : '''Password must contain at least eight characters, at least one number and both lower and uppercase letters and special characters''',
                            helperMaxLines: 3,
                            labelText: 'Password',
                            errorMaxLines: 2,
                            errorText: state.password.invalid
                                ? ''' Password must be at least 8 characters and contain at least one letter and number '''
                                : null,
                            suffixIcon: IconButton(
                              icon: Icon(
                                // Based on passwordVisible state choose the icon
                                state.togglePassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                context
                                    .read<RegistrationBloc>()
                                    .add(TogglePassword());
                              },
                            )),
                        obscureText: state.togglePassword,
                        onChanged: (value) {
                          context
                              .read<RegistrationBloc>()
                              .add(PasswordChanged(password: value));
                        },
                        keyboardType: TextInputType.text,
                        // textInputAction: TextInputAction.next,
                      );
                    },
                  ))),

          Expanded(
              flex: 2,
              child: Container(
                  alignment: Alignment.center,
                  child: BlocBuilder<RegistrationBloc, RegistrationState>(
                    builder: (context, state) {
                      return TextFormField(
                        cursorColor: Colors.white,
                        initialValue: state.confirmPassword.value,
                        focusNode: _confirmPasswordFocusNode,
                        style: TextStyle(color: Colors.white, fontSize: 24),
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(12),
                            isDense: true,
                            labelStyle:
                                TextStyle(color: Colors.white, fontSize: 20),
                            helperStyle: TextStyle(color: Colors.white),
                            icon: const Icon(
                              Icons.lock,
                              color: Colors.white,
                              size: 30,
                            ),
                            helperText: state.confirmPassword.valid
                                ? null
                                : '''Please Confirm Password''',
                            helperMaxLines: 3,
                            labelText: 'Confirm Password',
                            errorMaxLines: 2,
                            errorText: state.confirmPassword.invalid
                                ? '''Passwords Do not match'''
                                : null,
                            suffixIcon: IconButton(
                              icon: Icon(
                                // Based on passwordVisible state choose the icon
                                state.toggleConfirmPassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                context
                                    .read<RegistrationBloc>()
                                    .add(ToggleConfirmPassword());
                              },
                            )),
                        obscureText: state.toggleConfirmPassword,
                        onChanged: (value) {
                          context.read<RegistrationBloc>().add(
                              ConfirmPasswordChanged(confirmPassword: value));
                        },
                        textInputAction: TextInputAction.done,
                      );
                    },
                  ))),

          Expanded(
              flex: 1,
              child: Container(
                  width: 150,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: BlocBuilder<RegistrationBloc, RegistrationState>(
                    buildWhen: (previous, current) =>
                        previous.status != current.status,
                    builder: (context, state) {
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: bgColor,
                        ),
                        onPressed: state.status.isValidated
                            ? () => context
                                .read<RegistrationBloc>()
                                .add(FormSubmitted())
                            : null,
                        // style: ElevatedButton.styleFrom(
                        //   onSurface: Colors.blue,
                        // ),
                        child: const Text(
                          'Register',
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    },
                  )))
        ],
      ),
    );
  }

  MaterialStateProperty<Color> getColor(Color one, Color two) {
    final getColor = (Set<MaterialState> states) {
      if (states.contains(MaterialState.focused)) {
        return one;
      } else {
        return two;
      }
    };
    return MaterialStateProperty.resolveWith(getColor);
  }
}
