// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weight_app/bloc/user_weight/add%20weight/add_weight_bloc.dart';
import 'package:weight_app/bloc/user_weight/get_weight/get_weight_bloc.dart';
import 'package:weight_app/models/constants.dart';
import 'package:weight_app/models/user_model.dart';
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
        appBar: AppBar(
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
                child: ViewWeights(),
              ),
            ),
          ],
        ));
  }
}
