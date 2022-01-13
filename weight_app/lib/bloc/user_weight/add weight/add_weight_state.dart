// ignore_for_file: prefer_const_constructors_in_immutables

part of 'add_weight_bloc.dart';

class AddWeightState extends Equatable {
  const AddWeightState(
      {this.weight = const Weight.pure(), this.status = FormzStatus.pure});

  final Weight weight;
  final FormzStatus status;

  AddWeightState copyWith(
      {required Weight weight, required FormzStatus status}) {
    return AddWeightState(weight: weight, status: status);
  }

  @override
  List<Object> get props => [weight, status];
}

class AddWeightInitialState extends AddWeightState {}

class SubmitWeightState extends AddWeightState {}

class AddWeightResponseState extends AddWeightState {
  final String message;
  final bool success;

  AddWeightResponseState(this.message, this.success) : super();
}
