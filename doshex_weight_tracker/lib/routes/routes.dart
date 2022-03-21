import 'package:doshex_weight_tracker/screens/enter_weight/enter_weight.dart';
import 'package:doshex_weight_tracker/screens/home/home.dart';
import 'package:doshex_weight_tracker/screens/sign_in/sign_in.dart';
import 'package:doshex_weight_tracker/screens/sign_up/sign_up.dart';
import 'package:doshex_weight_tracker/screens/splash/splash.dart';
import 'package:doshex_weight_tracker/screens/weight_history/weight_history.dart';
import 'package:flutter/widgets.dart';

final Map<String, WidgetBuilder> routes = {
  Splash.routeName: (context) => Splash(),
  SignUp.routeName: (context) => SignUp(),
  SignIn.routeName: (context) => SignIn(),
  Home.routeName: (context) => Home(),
  EnterWeight.routeName: (context) => EnterWeight(),
  WeightHistory.routeName: (context) => WeightHistory(),
};
