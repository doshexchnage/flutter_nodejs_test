import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'delete_weight_event.dart';
part 'delete_weight_state.dart';

class DeleteWeightBloc extends Bloc<DeleteWeightEvent, DeleteWeightState> {
  DeleteWeightBloc() : super(DeleteWeightInitial()) {
    on<DeleteWeightEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
