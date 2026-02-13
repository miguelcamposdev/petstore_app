part of 'pet_add_bloc.dart';

sealed class PetAddEvent {
  PetAddDto petAddDto;

  PetAddEvent({required this.petAddDto});
}
