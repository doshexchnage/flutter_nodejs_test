// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:network_req/network_req.dart';
import 'package:weight_app/models/constants.dart';
import 'package:timeago/timeago.dart' as timeago;

class WeightCard extends StatelessWidget {
  const WeightCard({Key? key, required this.data}) : super(key: key);
  final UserWeight data;

  @override
  Widget build(BuildContext context) {
    DateTime date;
    data.date != null ? date = data.date! : date = DateTime.now();

    return Container(
      height: 120,
      margin: EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
      padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
      color: secondaryColor,
      child: Row(children: [
        Expanded(
            flex: 1,
            child: Container(
              height: double.infinity,
              width: double.infinity,
              alignment: Alignment.center,
              color: compTwo,
              child: Text(
                'ID: ${data.id}',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: primaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            )),
        Expanded(
            flex: 3,
            child: Container(
                height: double.infinity,
                width: double.infinity,
                alignment: Alignment.center,
                color: compOne,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                          flex: 1,
                          child: Center(
                            child: Text(
                              'Value: ${data.value.toString()}',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                              textAlign: TextAlign.center,
                            ),
                          )),
                      Expanded(
                          flex: 1,
                          child: Center(
                            child: Text(
                              timeago.format(date),
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                              textAlign: TextAlign.center,
                            ),
                          ))
                    ]))),
        Expanded(
            flex: 1,
            child: Container(
              height: double.infinity,
              width: double.infinity,
              alignment: Alignment.center,
              color: compTwo,
              child: IconButton(
                icon: Icon(
                  Icons.delete,
                ),
                iconSize: 50,
                color: Colors.green,
                splashColor: Colors.purple,
                onPressed: () {},
              ),
            )),
      ]),
    );
  }
}
