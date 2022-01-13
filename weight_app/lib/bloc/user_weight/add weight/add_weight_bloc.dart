import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:formz/formz.dart';
import 'package:weight_app/models/formz/weight.dart';

part 'add_weight_event.dart';
part 'add_weight_state.dart';

class AddWeightBloc extends Bloc<AddWeightEvent, AddWeightState> {
  AddWeightBloc() : super(AddWeightInitialState()) {
    on<WeightChanged>(_onWeightChanged);
    on<WeightUnfocused>(_onWeightUnfocused);
    on<FormSubmitted>(_onFormSubmitted);
  }

  void _onWeightChanged(WeightChanged event, Emitter<AddWeightState> emit) {
    final weight = Weight.dirty(event.weight);
    if (kDebugMode) {
      print("CHANGED ${state.weight}");
    }
    emit(state.copyWith(
      weight: weight.valid ? weight : Weight.pure(event.weight),
      status: Formz.validate([weight]),
    ));
  }

  void _onWeightUnfocused(WeightUnfocused event, Emitter<AddWeightState> emit) {
    final weight = Weight.dirty(state.weight.value);
    emit(state.copyWith(
      weight: weight,
      status: Formz.validate([weight]),
    ));
  }

  Future<void> _onFormSubmitted(
      FormSubmitted event, Emitter<AddWeightState> emit) async {
    var weight = Weight.dirty(state.weight.value);

    emit(state.copyWith(
      weight: weight,
      status: Formz.validate([weight]),
    ));

    if (state.status.isValidated) {
      emit(SubmitWeightState());
      await Future.delayed(Duration(milliseconds: 500));
      if (kDebugMode) {
        print("BLoc value: ${weight.value}");
      }
      emit(AddWeightInitialState());
    }
  }
}
