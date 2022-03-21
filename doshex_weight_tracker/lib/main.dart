import 'package:doshex_weight_tracker/provider/services.dart';
import 'package:doshex_weight_tracker/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/splash/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ServicesProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Doshex Weight Tracker',
        home: const Splash(),
        initialRoute: Splash.routeName,
        routes: routes,
      ),
    );
  }
}
