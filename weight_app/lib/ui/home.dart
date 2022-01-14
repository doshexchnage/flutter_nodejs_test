// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weight_app/bloc/user_weight/add%20weight/add_weight_bloc.dart';
import 'package:weight_app/bloc/user_weight/get_weight/get_weight_bloc.dart';
import 'package:weight_app/models/constants.dart';
import 'package:weight_app/models/user_model.dart';
import 'package:weight_app/ui/login.dart';
import 'package:weight_app/ui/widgets/weight_card.dart';
import 'package:weight_app/ui/widgets/weight_form.dart';

List<Map<String, dynamic>> data = [
  {"id": 1, "userID": 5, "date": "2022-01-04T22:00:00.000Z", "value": 55},
  {"id": 5, "userID": 5, "date": "2022-01-04T22:00:00.000Z", "value": 255},
  {"id": 6, "userID": 5, "date": "2022-01-04T22:00:00.000Z", "value": 253},
  {"id": 7, "userID": 5, "date": "2022-01-04T22:00:00.000Z", "value": 87},
  {"id": 8, "userID": 5, "date": "2022-01-04T22:00:00.000Z", "value": 205}
];

class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.title, required this.userInfo})
      : super(key: key);
  final String title;
  final UserLogin userInfo;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bgColor,
        drawer: Container(
          width: MediaQuery.of(context).size.width * 0.75,
          color: secondaryColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 25),
                  width: double.infinity,
                  alignment: Alignment.center,
                  color: compTwo,
                  child: Row(
                    children: [
                      Expanded(
                          flex: 3,
                          child: Text(
                            'ClOSE',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold),
                          )),
                      Expanded(
                          child: IconButton(
                        icon: Icon(
                          Icons.close_fullscreen,
                        ),
                        iconSize: 50,
                        color: Colors.white,
                        splashColor: Colors.purple,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ))
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        "Username: \n   ${widget.userInfo.userName!}",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Center(
                      child: Text(
                        "User ID: ${widget.userInfo.userID!}",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Center(
                      child: Text(
                        "Age: ${widget.userInfo.age!}",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  color: compTwo,
                  child: Row(
                    children: [
                      Expanded(
                          flex: 3,
                          child: Text(
                            'LOGOUT',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold),
                          )),
                      Expanded(
                          child: IconButton(
                        icon: Icon(
                          Icons.logout_rounded,
                        ),
                        iconSize: 50,
                        color: Colors.white,
                        splashColor: Colors.purple,
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      LoginPage(title: 'User Login')));
                        },
                      ))
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: secondaryColor,
          title: Text(widget.title),
        ),
        body: ListView(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
              padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
              width: double.infinity,
              height: 200,
              child: BlocProvider(
                  create: (context) => AddWeightBloc(userInfo: widget.userInfo),
                  child: AddWeightForm()),
              color: secondaryColor,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height - 310,
              child: BlocProvider(
                create: (context) => GetWeightBloc(userInfo: widget.userInfo),
                child: BlocListener<GetWeightBloc, GetWeightState>(
                  listener: (context, state) {
                    if (state is UserWeightResponseState) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                          state.message,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                              color: state.success ? Colors.white : Colors.red),
                        ),
                        duration: Duration(milliseconds: 600),
                      ));
                    }
                  },
                  child: ViewWeights(),
                ),
              ),
            ),
          ],
        ));
  }
}
