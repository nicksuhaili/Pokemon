part of 'pokemon_details_cubit.dart';

abstract class PokemonDetailsState {}
// Initialize state: Loading, Loaded, Error

class PokemonDetailsInitial extends PokemonDetailsState {}

class PokemonDetailsLoading extends PokemonDetailsState {}

class PokemonDetailsLoaded extends PokemonDetailsState {
  final PokemonDetails details;
  PokemonDetailsLoaded(this.details);
}

class PokemonDetailsError extends PokemonDetailsState {
  final String message;
  PokemonDetailsError(this.message);
}
