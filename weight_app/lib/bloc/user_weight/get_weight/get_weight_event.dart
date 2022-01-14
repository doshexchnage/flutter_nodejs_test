part of 'get_weight_bloc.dart';

abstract class GetWeightEvent extends Equatable {
  const GetWeightEvent();

  @override
  List<Object> get props => [];
}

class GetUserWeightData extends GetWeightEvent {

}



class DeleteUserWeightData extends GetWeightEvent {
  const DeleteUserWeightData({required this.weightId});
  final int weightId;

  @override
  List<Object> get props => [weightId];
}
