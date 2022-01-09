part of 'delete_weight_bloc.dart';

abstract class DeleteWeightEvent extends Equatable {
  const DeleteWeightEvent();

  @override
  List<Object> get props => [];
}


class DeleteWeight extends DeleteWeightEvent {
  const DeleteWeight({required this.userID});
  final int userID;

  @override
  List<Object> get props => [userID];
}
