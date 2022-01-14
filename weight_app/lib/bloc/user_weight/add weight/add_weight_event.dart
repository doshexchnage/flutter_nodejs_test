part of 'add_weight_bloc.dart';

abstract class AddWeightEvent extends Equatable {
  const AddWeightEvent();

  @override
  List<Object> get props => [];
}

class WeightChanged extends AddWeightEvent {
  const WeightChanged({required this.weight});

  final String weight;

  @override
  List<Object> get props => [weight];
}

class WeightUnfocused extends AddWeightEvent {}

class FormSubmitted extends AddWeightEvent {}
