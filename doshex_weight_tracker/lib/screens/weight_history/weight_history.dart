import 'package:doshex_weight_tracker/models/weight.dart';
import 'package:doshex_weight_tracker/provider/services.dart';
import 'package:doshex_weight_tracker/screens/enter_weight/enter_weight.dart';
import 'package:doshex_weight_tracker/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WeightHistory extends StatefulWidget {
  static String routeName = "/weight_history";

  const WeightHistory({Key? key}) : super(key: key);

  @override
  State<WeightHistory> createState() => _WeightHistoryState();
}

class _WeightHistoryState extends State<WeightHistory> {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final _authData = Provider.of<ServicesProvider>(context);

    return Scaffold(
      appBar: new AppBar(
        title: new Text('Weight History'),
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => Home(),
              ),
            );
          },
          child: Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: Center(
        child: FutureBuilder<Weight>(
          future: _authData.getWeightHistory(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView(
                children: [
                  Container(
                    padding: new EdgeInsets.all(20.0),
                    child: Center(
                      child: Row(
                        children: [
                          Text(
                            'Current Weight: ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                            textAlign: TextAlign.center,
                          ),
                          Text(snapshot.data!.current_weight),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: new EdgeInsets.all(20.0),
                    child: Center(
                      child: Row(children: [
                        Text(
                          'Created At: ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                        Text(snapshot.data!.created_at),
                      ]),
                    ),
                  )
                ],
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
