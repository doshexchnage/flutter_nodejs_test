// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:weight_app/bloc/user_weight/add%20weight/add_weight_bloc.dart';
import 'package:weight_app/models/constants.dart';

class AddWeightForm extends StatefulWidget {
  AddWeightForm({Key? key}) : super(key: key);

  @override
  _AddWeightFormState createState() => _AddWeightFormState();
}

class _AddWeightFormState extends State<AddWeightForm> {
  final _weightFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _weightFocusNode.addListener(() {
      if (!_weightFocusNode.hasFocus) {
        context.read<AddWeightBloc>().add(WeightUnfocused());
      }
    });
  }

  @override
  void dispose() {
    _weightFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddWeightBloc, AddWeightState>(
        builder: (context, state) {
      if (state is SubmitWeightState) {
        return Center(child: CircularProgressIndicator());
      }

      if (state is AddWeightResponseState) {
        return Center(
            child: Text(
          state.message,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: state.success ? Colors.white : Colors.red),
        ));
      }

      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              flex: 3,
              child: BlocBuilder<AddWeightBloc, AddWeightState>(
                builder: (context, state) {
                  return TextFormField(
                    initialValue: state.weight.value,
                    focusNode: _weightFocusNode,
                    decoration: InputDecoration(
                      labelStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                      helperStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                      icon: const Icon(
                        Icons.monitor_weight,
                        color: Colors.white,
                        size: 40,
                      ),
                      helperText:
                          '''Weight To The Nearest Decimal e.g 7.2 (USE . for Decimals)''',
                      helperMaxLines: 2,
                      labelText: 'Weight',
                      errorMaxLines: 2,
                      errorStyle: TextStyle(
                          color: Colors.red,
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                      errorText: state.weight.invalid
                          ? '''Weigh Must Be Greater Than 0.0'''
                          : null,
                    ),
                    onChanged: (value) {
                      context
                          .read<AddWeightBloc>()
                          .add(WeightChanged(weight: value));
                    },
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    // inputFormatters: <TextInputFormatter>[
                    //   FilteringTextInputFormatter.digitsOnly
                    // ],
                    textInputAction: TextInputAction.done,
                  );
                },
              )),
          Expanded(
              flex: 1,
              child: BlocBuilder<AddWeightBloc, AddWeightState>(
                buildWhen: (previous, current) =>
                    previous.status != current.status,
                builder: (context, state) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: bgColor,
                    ),
                    onPressed: state.status.isValidated
                        ? () =>
                            context.read<AddWeightBloc>().add(FormSubmitted())
                        : null,
                    // style: ElevatedButton.styleFrom(
                    //   onSurface: Colors.blue,
                    // ),
                    child: const Text(
                      'Add Weight',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  );
                },
              ))
        ],
      );
    });
  }
}
