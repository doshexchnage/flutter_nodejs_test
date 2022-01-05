import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'user_weight_event.dart';
part 'user_weight_state.dart';

class UserWeightBloc extends Bloc<UserWeightEvent, UserWeightState> {
  UserWeightBloc() : super(UserWeightInitial()) {
    on<UserWeightEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
