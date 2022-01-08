// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weight_app/bloc/user_weight/add%20weight/add_weight_bloc.dart';
import 'package:weight_app/models/constants.dart';
import 'package:weight_app/ui/widgets/weight_form.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.title}) : super(key: key);
  final String title;

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
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                  flex: 1,
                  child: Container(
                    margin:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
                    padding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
                    width: double.infinity,
                    height: double.infinity,
                    child: BlocProvider(
                        create: (context) => AddWeightBloc(),
                        child: AddWeightForm()),
                    color: secondaryColor,
                  )),
              Expanded(
                  flex: 2,
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    child: Center(
                      child: Text('Hello World',
                          style: TextStyle(color: primaryColor)),
                    ),
                    color: bgColor,
                  ))
            ],
          ),
        ));
  }
}
