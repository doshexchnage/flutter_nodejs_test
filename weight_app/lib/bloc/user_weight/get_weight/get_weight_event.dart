part of 'get_weight_bloc.dart';

abstract class GetWeightEvent extends Equatable {
  const GetWeightEvent();

  @override
  List<Object> get props => [];
}

class GetUserWeightData extends GetWeightEvent {
  const GetUserWeightData({required this.userID});
  final int userID;

  @override
  List<Object> get props => [userID];
}



class DeleteUserWeightData extends GetWeightEvent {
  const DeleteUserWeightData({required this.userID});
  final int userID;

  @override
  List<Object> get props => [userID];
}
