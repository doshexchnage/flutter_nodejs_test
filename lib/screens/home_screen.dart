import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracker/constants.dart';

import '../providers/auth_provider.dart';
import 'weight/add_weight_screen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Consumer<AuthProvider>(builder: (_, auth, __) {
        if (auth.isAuthenticated) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute<void>(
                  builder: (BuildContext context) => const AddWeightScreen()),
              ModalRoute.withName(addWeightRoute),
            );
          });
        }
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'A simple weight tracker',
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, loginRoute),
                child: const Text('Continue'),
              ),
            ],
          ),
        );
      }),
    );
  }
}
