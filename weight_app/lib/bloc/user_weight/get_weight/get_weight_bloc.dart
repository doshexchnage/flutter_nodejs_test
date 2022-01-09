import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:network_req/network_req.dart';
import 'package:weight_app/models/formz/weight.dart';

part 'get_weight_event.dart';
part 'get_weight_state.dart';

class GetWeightBloc extends Bloc<GetWeightEvent, GetWeightState> {
  GetWeightBloc() : super(GetWeightInitial()) {
    on<GetWeightEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
