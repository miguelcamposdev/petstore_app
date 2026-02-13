part of 'pet_add_bloc.dart';

@immutable
sealed class PetAddState {}

final class PetAddInitial extends PetAddState {}

final class PetAddSuccess extends PetAddState {}

final class PetAddError extends PetAddState {
  final String message;

  PetAddError({required this.message});
}
