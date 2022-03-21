import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:doshex_weight_tracker/components/custom_notification_container.dart';
import 'package:doshex_weight_tracker/models/weight.dart';
import 'package:doshex_weight_tracker/provider/services.dart';
import 'package:doshex_weight_tracker/screens/home/home.dart';
import 'package:doshex_weight_tracker/screens/sign_in/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EnterWeight extends StatefulWidget {
  static String routeName = "/enter_weight";

  const EnterWeight({Key? key}) : super(key: key);

  @override
  State<EnterWeight> createState() => _EnterWeightState();
}

class _EnterWeightState extends State<EnterWeight> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  String? current_weight;

  TextEditingController currentWeightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final _authData = Provider.of<ServicesProvider>(context);

    return Scaffold(
      appBar: new AppBar(
        title: new Text('Enter Weight'),
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
      body: Container(
        padding: new EdgeInsets.all(20.0),
        child: Form(
          key: this._formKey,
          child: ListView(
            children: [
              new TextFormField(
                controller: currentWeightController,
                keyboardType: TextInputType.emailAddress,
                decoration: new InputDecoration(
                    hintText: '50kg',
                    labelText: 'Enter Current Weight'),
              ),
              Container(
                margin: new EdgeInsets.only(top: 20.0),
                color: Colors.blue,
                width: screenSize.width,
                child: GestureDetector(
                  onTap: () async {

                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                    }

                    Weight currentWeight = await _authData
                        .saveWeight(currentWeightController.text);

                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.INFO,
                      animType: AnimType.BOTTOMSLIDE,
                      title: 'Your Current Weight Entry Has Been Saved',
                      btnOkOnPress: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => Home(),
                          ),
                        );
                      },
                    )..show();
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
            ],
          ),
        ),
      ),
    );
  }
}
