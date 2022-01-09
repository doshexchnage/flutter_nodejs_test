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
  Widget build(BuildContext context) {
    return BlocBuilder<AddWeightBloc, AddWeightState>(
        builder: (context, state) {
      if (state is SubmitWeightState) {
        return Center(child: CircularProgressIndicator());
      }

      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(flex: 3, child: WeightInput(focusNode: _weightFocusNode)),
          Expanded(flex: 1, child: SubmitButton(key: widget.key))
        ],
      );
    });
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
          initialValue: null,
          focusNode: focusNode,
          decoration: InputDecoration(
            labelStyle: TextStyle(color: Colors.white, fontSize: 20),
            helperStyle: TextStyle(color: Colors.white),
            icon: const Icon(Icons.money, color: Colors.white),
            helperText: '''Weight To The Nearest Decimal e.g 7.2''',
            helperMaxLines: 1,
            labelText: 'Weight',
            errorMaxLines: 1,
            errorText: state.weight.invalid
                ? '''Weigh Must Be Greater Than 0.0'''
                : null,
          ),
          onChanged: (value) {
            double weight = 0.0;
            if (double.tryParse(value) != null) {
              weight = double.parse(value);
            }
            print(weight);
            context.read<AddWeightBloc>().add(WeightChanged(weight: value));
          },
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
          // textInputAction: TextInputAction.done,
        );
      },
    );
  }
}

class SubmitButton extends StatelessWidget {
  const SubmitButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddWeightBloc, AddWeightState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: bgColor,
          ),
          onPressed: state.status.isValidated
              ? () => context.read<AddWeightBloc>().add(FormSubmitted())
              : null,
          // style: ElevatedButton.styleFrom(
          //   onSurface: Colors.blue,
          // ),
          child: const Text(
            'Add Weight',
            style: TextStyle(color: Colors.white),
          ),
        );
      },
    );
  }
}
