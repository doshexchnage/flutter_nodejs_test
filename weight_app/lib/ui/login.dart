// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, prefer_function_declarations_over_variables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:weight_app/bloc/login/login_bloc.dart';
import 'package:weight_app/models/constants.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
            BlocProvider<LoginBloc>(
              create: (context) => LoginBloc(),
              child: BlocListener<LoginBloc, LoginState>(
                listener: (context, state) {
                  if (state is LoginResponse) {
                    _showDialog(
                        state.title, state.message, state.showCloseDialog);
                  }
                  if (state is LoginSuccess) {
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
  final _passwordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _userNameFocusNode.addListener(() {
      if (!_userNameFocusNode.hasFocus) {
        context.read<LoginBloc>().add(UserNameUnfocused());
        //FocusScope.of(context).requestFocus(_passwordFocusNode);
      }
    });
    _passwordFocusNode.addListener(() {
      if (!_passwordFocusNode.hasFocus) {
        context.read<LoginBloc>().add(PasswordUnfocused());
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
      height: 320,
      child: Column(
        children: [
          // Username Input
          // Password Input
          // Submit Button
          Expanded(
              flex: 2,
              child: Container(
                  alignment: Alignment.center,
                  child: BlocBuilder<LoginBloc, LoginState>(
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
                          helperText: state.userName.valid
                              ? null
                              : '''A complete, valid first name e.g John''',
                          helperMaxLines: 2,
                          labelText: 'First Name',
                          errorMaxLines: 2,
                          errorText: state.userName.invalid
                              ? '''username is 8-20 characters long,  NO _ or . at the begging and end, NO __ or _. or ._ or .. inside'''
                              : null,
                        ),
                        onChanged: (value) {
                          context
                              .read<LoginBloc>()
                              .add(UserNameChanged(userName: value));
                        },
                        keyboardType: TextInputType.text,
                        //textInputAction: TextInputAction.next,
                      );
                    },
                  ))),
          Expanded(
              flex: 2,
              child: Container(
                  alignment: Alignment.center,
                  child: BlocBuilder<LoginBloc, LoginState>(
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
                                ? '''Password must be at least 8 characters and contain at least one letter and number'''
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
                                context.read<LoginBloc>().add(TogglePassword());
                              },
                            )),
                        obscureText: state.togglePassword,
                        onChanged: (value) {
                          context
                              .read<LoginBloc>()
                              .add(PasswordChanged(password: value));
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
                  child: BlocBuilder<LoginBloc, LoginState>(
                    buildWhen: (previous, current) =>
                        previous.status != current.status,
                    builder: (context, state) {
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: bgColor,
                        ),
                        onPressed: state.status.isValidated
                            ? () =>
                                context.read<LoginBloc>().add(FormSubmitted())
                            : null,
                        // style: ElevatedButton.styleFrom(
                        //   onSurface: Colors.blue,
                        // ),
                        child: const Text(
                          'Login',
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
