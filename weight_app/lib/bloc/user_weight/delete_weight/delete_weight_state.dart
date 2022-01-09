part of 'delete_weight_bloc.dart';

abstract class DeleteWeightState extends Equatable {
  const DeleteWeightState();
  
  @override
  List<Object> get props => [];
}

class DeleteWeightInitial extends DeleteWeightState {}


class UserWeightResponseState extends DeleteWeightState {
  final String message;
  final bool success;

  const UserWeightResponseState(this.message, this.success) : super();
}