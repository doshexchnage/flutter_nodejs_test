import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:formz/formz.dart';
import 'package:network_req/network_req.dart';
import 'package:weight_app/models/formz/weight.dart';
import 'package:weight_app/models/user_model.dart';

part 'add_weight_event.dart';
part 'add_weight_state.dart';

class AddWeightBloc extends Bloc<AddWeightEvent, AddWeightState> {
  AddWeightBloc({required this.userInfo}) : super(AddWeightInitialState()) {
    on<WeightChanged>(_onWeightChanged);
    on<WeightUnfocused>(_onWeightUnfocused);
    on<FormSubmitted>(_onFormSubmitted);
  }

  final UserLogin userInfo;
  final WeightAPI repo = WeightAPI();

  void _onWeightChanged(WeightChanged event, Emitter<AddWeightState> emit) {
    final weight = Weight.dirty(event.weight);
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
      try {
        var sendReq = await repo.addWieghtRequestFunction(userInfo.userID!,
            double.parse(double.parse(weight.value).toStringAsFixed(2)));
        emit(AddWeightResponseState(sendReq.msg, sendReq.success));
        await Future.delayed(const Duration(seconds: 8));

        emit(AddWeightInitialState());
      } catch (e) {
        emit(AddWeightResponseState(e.toString(), false));
        await Future.delayed(const Duration(seconds: 8));

        emit(AddWeightInitialState());
      }
    }
  }
}
