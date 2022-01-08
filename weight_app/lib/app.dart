// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:weight_app/ui/home.dart';
import 'package:weight_app/ui/registration.dart';

import 'ui/login.dart';

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: RegistrationPage(title: 'User Registration'),
      // home: LoginPage(title: 'User Login'),
      home: HomePage(title: 'Weight App'),
    );
  }
}
