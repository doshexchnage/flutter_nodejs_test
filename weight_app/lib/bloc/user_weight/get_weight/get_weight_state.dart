part of 'get_weight_bloc.dart';

abstract class GetWeightState extends Equatable {
  const GetWeightState();

  @override
  List<Object> get props => [];
}

class GetWeightInitial extends GetWeightState {}

class GetWeightLoading extends GetWeightState {}

class UserWeightData extends GetWeightState {
  const UserWeightData({required this.data});
  final List<UserWeight> data;

  @override
  List<Object> get props => [data];
}

class UserWeightResponseState extends GetWeightState {
  final String message;
  final bool success;

  const UserWeightResponseState(this.message, this.success) : super();
}
