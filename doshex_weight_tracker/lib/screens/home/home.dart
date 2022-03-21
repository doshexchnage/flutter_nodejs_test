import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:doshex_weight_tracker/provider/services.dart';
import 'package:doshex_weight_tracker/screens/enter_weight/enter_weight.dart';
import 'package:doshex_weight_tracker/screens/sign_in/sign_in.dart';
import 'package:doshex_weight_tracker/screens/weight_history/weight_history.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  static String routeName = "/home";
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final _authData = Provider.of<ServicesProvider>(context);

    return Scaffold(
      appBar: new AppBar(
        title: new Text('Home'),
        leading: GestureDetector(
          onTap: () async {
            await _authData.logoutAccount();

            AwesomeDialog(
              context: context,
              dialogType: DialogType.INFO,
              animType: AnimType.BOTTOMSLIDE,
              title: 'YOU ARE LOGGING OUT -  BYE!!',
              btnOkOnPress: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => SignIn(),
                  ),
                );
              },
            )..show();
          },
          child: Icon(Icons.logout),
        ),
      ),
      body: Container(
        padding: new EdgeInsets.all(20.0),
        child: new ListView(
          children: [
            Container(
              margin: new EdgeInsets.only(top: 20.0),
              color: Colors.blue,
              width: screenSize.width,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (_) => EnterWeight(),
                    ),
                  );
                },
                child: const TextButton(
                  onPressed: null,
                  child: Text(
                    'Enter Weight',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            Container(
              margin: new EdgeInsets.only(top: 20.0),
              color: Colors.blue,
              width: screenSize.width,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (_) => WeightHistory(),
                    ),
                  );
                },
                child: const TextButton(
                  onPressed: null,
                  child: Text(
                    'Weight History',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            Container(
              margin: new EdgeInsets.only(top: 20.0),
              color: Colors.blue,
              width: screenSize.width,
              child: GestureDetector(
                onTap: () async {
                  // await _authData.logoutAccount();

                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.INFO,
                    animType: AnimType.BOTTOMSLIDE,
                    title: 'YOU ARE LOGGING OUT - BYE!!',
                    btnOkOnPress: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => SignIn(),
                        ),
                      );
                    },
                  )..show();
                },
                child: const TextButton(
                  onPressed: null,
                  child: Text(
                    'Logout',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
