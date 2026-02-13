import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'pet_detail_event.dart';
part 'pet_detail_state.dart';

class PetDetailBloc extends Bloc<PetDetailEvent, PetDetailState> {
  PetDetailBloc() : super(PetDetailInitial()) {
    on<PetDetailEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
