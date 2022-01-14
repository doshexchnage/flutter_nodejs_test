import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:network_req/network_req.dart';
import 'package:weight_app/models/user_model.dart';

part 'get_weight_event.dart';
part 'get_weight_state.dart';

class GetWeightBloc extends Bloc<GetWeightEvent, GetWeightState> {
  GetWeightBloc({required this.userInfo}) : super(GetWeightInitial()) {
    on<GetUserWeightData>(_onFetchWeightData);
    on<DeleteUserWeightData>(_onDeleteUserWeightData);
  }

  final UserLogin userInfo;
  final WeightAPI repo = WeightAPI();
  final _dataController = StreamController<List<UserWeight>>.broadcast();
  Stream<List<UserWeight>> get data => _dataController.stream;

  Future<void> _onFetchWeightData(
      GetUserWeightData event, Emitter<GetWeightState> emit) async {
    try {
      emit(GetWeightInitial());
      var weightData = await repo.getWieghtRequestFunction(userInfo.userID!);
      _dataController.sink.add(weightData.reversed.toList());
    } catch (e) {
      emit(UserWeightResponseState(e.toString(), false));
    }
  }

  Future<void> _onDeleteUserWeightData(
      DeleteUserWeightData event, Emitter<GetWeightState> emit) async {
    try {
      var weightResp = await repo.deleteWieghtRequestFunction(event.weightId);
      emit(UserWeightResponseState(weightResp.msg, weightResp.success));
      // await Future.delayed(const Duration(seconds: 3));
    } catch (e) {
      emit(UserWeightResponseState(e.toString(), false));
    }
  }
}
