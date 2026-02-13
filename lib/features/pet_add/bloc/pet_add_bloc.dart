import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:petstore_app/core/dto/pet_add_dto.dart';

part 'pet_add_event.dart';
part 'pet_add_state.dart';

class PetAddBloc extends Bloc<PetAddEvent, PetAddState> {
  PetAddBloc() : super(PetAddInitial()) {
    on<PetAddEvent>((event, emit) {});
  }
}
