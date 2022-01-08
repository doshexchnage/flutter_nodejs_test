// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weight_app/bloc/user_weight/add%20weight/add_weight_bloc.dart';


class AddWeightForm extends StatefulWidget {
  AddWeightForm({Key? key}) : super(key: key);

  @override
  _AddWeightFormState createState() => _AddWeightFormState();
}

class _AddWeightFormState extends State<AddWeightForm> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class WeightInput extends StatelessWidget {
  const WeightInput({Key? key, required this.focusNode}) : super(key: key);

  final FocusNode focusNode;


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddWeightBloc, AddWeightState>(
      builder: (context, state) {
        return TextFormField(

          initialValue: state.weight.value,
          focusNode: focusNode,
          decoration: InputDecoration(
            labelStyle: TextStyle(color: Colors.white),
            helperStyle: TextStyle(color: Colors.white),
            icon: const Icon(Icons.money, color: Colors.white),
            helperText:
            '''Weight To The Nearest Decimal e.g 7.2''',
            helperMaxLines: 2,
            labelText: 'Amount',
            errorMaxLines: 2,
            errorText: state.weight.invalid
                ? '''Weigh Must Be Greater Than 0.0'''
                : null,
          ),
          onChanged: (value) {
            context.read<AddWeightBloc>().add(WeightChanged(weight: value));
          },
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          textInputAction: TextInputAction.send,
        );
      },
    );
  }
}