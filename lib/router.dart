import 'package:flutter/material.dart';
import 'package:tracker/screens/weight/add_weight_screen.dart';
import 'package:tracker/screens/auth/login_screen.dart';
import 'package:tracker/screens/auth/signup_screen.dart';
import 'package:tracker/screens/weight/weight_history_screen.dart.dart'; 

import 'constants.dart'; 

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) { 
    switch (settings.name) {
      case loginRoute:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case signupRoute:
        return MaterialPageRoute(builder: (_) => SignupScreen());
      case addWeightRoute:
        return MaterialPageRoute(builder: (_) => AddWeightScreen());
      case weightHistoryRoute:
        return MaterialPageRoute(builder: (_) => WeightHistoryScreen());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
