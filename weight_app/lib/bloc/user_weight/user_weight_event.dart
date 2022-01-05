part of 'user_weight_bloc.dart';

abstract class UserWeightEvent extends Equatable {
  const UserWeightEvent();

  @override
  List<Object> get props => [];
}

class GetUserWeights extends UserWeightEvent {
  const GetUserWeights({required this.userID});
  final int userID;

  @override
  List<Object> get props => [];
}

class AddUserWeight extends UserWeightEvent {
  const AddUserWeight({required this.userID, required this.wieght});
  final int userID;
  final double wieght;

  @override
  List<Object> get props => [];
}

class DeleteUserWeight extends UserWeightEvent {
  const DeleteUserWeight({required this.wieghtID});
  final double wieghtID;

  @override
  List<Object> get props => [];
}