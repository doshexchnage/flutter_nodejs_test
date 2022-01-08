import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:weight_app/models/formz/weight.dart';

part 'add_weight_event.dart';
part 'add_weight_state.dart';

class AddWeightBloc extends Bloc<AddWeightEvent, AddWeightState> {
  AddWeightBloc() : super(AddWeightInitialState()) {
    on<AddWeightEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
