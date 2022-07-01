import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../providers/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email = 'test@email.com';
  String password = 'test';
  TextEditingController textarea = TextEditingController();
  dynamic auth;

  @override
  void initState() {
    textarea.text = email;
    auth = Provider.of<AuthProvider>(context, listen: false);
    super.initState();
  }

  void handleSubmit() async {
    if (email == '' || password == '') {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please enter an email and password'),
      ));
      return;
    }
    final payload = jsonEncode({'email': email, 'password': password});
    try {
      await auth.userSignIn(payload);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
        ),
        body: Center(
            child: Form(
          child: ListView(padding: const EdgeInsets.all(20.0), children: <Widget>[
            TextField(
              controller: textarea,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(labelText: 'Email'),
              onChanged: (value) {
                setState(() {
                  email = value;
                });
              },
            ),
            TextFormField(
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password'),
              onChanged: (value) {
                setState(() {
                  password = value;
                });
              },
            ),
            const SizedBox(height: 20),
            InkWell(
                child: const Text('Sign up', textAlign: TextAlign.right),
                onTap: () => Navigator.pushNamed(context, signupRoute)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => handleSubmit(),
              child: const Text('Continue'),
            ),
          ]),
        )));
  }
}
