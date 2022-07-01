import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracker/api/user_api.dart';
import 'package:tracker/providers/auth_provider.dart';
import 'package:tracker/providers/weight_provider.dart';
import 'package:tracker/router.dart';
import 'package:tracker/screens/home_screen.dart';

import 'api/weight_api.dart';
import 'transforms/init_store.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppStore.init();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
        lazy: true,
        create: (_) => AuthProvider(storage: AppStore.instance, api: UseAuthApi())),
    ChangeNotifierProvider(
        create: (_) => WeightProvider(storage: AppStore.instance, api: UseWeightApi())),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        onGenerateRoute: AppRouter.generateRoute,
        initialRoute: '/',
        title: 'Weight Tracker',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(title: 'Welcome'));
  }
}
