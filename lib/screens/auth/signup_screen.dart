import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracker/constants.dart';

import '../../providers/auth_provider.dart';

class SignupScreen extends StatefulWidget {
  SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  String email = 'test@email.com';
  String password = 'test';
  String name = 'test';
  dynamic auth;

  TextEditingController textarea = TextEditingController();

  @override
  void initState() {
    auth = Provider.of<AuthProvider>(context, listen: false);
    textarea.text = email;
    super.initState();
  }

  void handleSubmit() async {
    if (email == '' || password == '' || name == '') {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Please enter an email and password'),
      ));
      return;
    }

    final payload = jsonEncode({'email': email, 'password': password, 'name': name});

    try {
      await auth.userSignup(payload);
      Navigator.of(context).pushNamedAndRemoveUntil(loginRoute, (route) => false);
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
        title: const Text('Sign up'),
      ),
      body: Center(
        child: Form(
            child: ListView(padding: const EdgeInsets.all(20.0), children: <Widget>[
          TextField(
            keyboardType: TextInputType.name,
            decoration: const InputDecoration(labelText: 'Name'),
            onChanged: (value) {
              setState(() {
                name = value;
              });
            },
          ),
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
              child: const Text('Already signed up?', textAlign: TextAlign.right),
              onTap: () => Navigator.pushNamed(context, loginRoute)),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => handleSubmit(),
            child: const Text('Continue'),
          ),
        ])),
      ),
    );
  }
}
