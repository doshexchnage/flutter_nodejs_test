// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:network_req/network_req.dart';
import 'package:weight_app/bloc/user_weight/get_weight/get_weight_bloc.dart';
import 'package:weight_app/models/constants.dart';
import 'package:timeago/timeago.dart' as timeago;

class ViewWeights extends StatefulWidget {
  ViewWeights({Key? key}) : super(key: key);

  @override
  _ViewWeightsState createState() => _ViewWeightsState();
}

class _ViewWeightsState extends State<ViewWeights> {
  late Timer timer;
  final ScrollController _controllerOne = ScrollController();

  setUpTimedFetch() {
    timer = Timer.periodic(Duration(seconds: 5), (Timer t) {
      if (mounted) {
        context.read<GetWeightBloc>().add(GetUserWeightData(userID: 6));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetWeightBloc, GetWeightState>(
      bloc: context.read<GetWeightBloc>(),
      builder: (context, state) {
        if (state is GetWeightInitial) {
          context.read<GetWeightBloc>().add(GetUserWeightData(userID: 6));
        }
        if (state is GetWeightLoading) {
          return Center(child: CircularProgressIndicator());
        }

        return StreamBuilder<List<UserWeight>>(
            stream: context.read<GetWeightBloc>().data,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return WeightCard(data: snapshot.data![index]);
                    });
              } else {
                return Center(child: CircularProgressIndicator());
              }
            });
      },
    );
  }
}

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
                    fontSize: 20,
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
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold),
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
                color: Colors.white,
                splashColor: Colors.purple,
                onPressed: () {},
              ),
            )),
      ]),
    );
  }
}
