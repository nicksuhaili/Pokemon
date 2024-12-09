import 'package:equatable/equatable.dart';

abstract class PokemonListState extends Equatable {
  const PokemonListState();

  @override
  List<Object> get props => [];
}

class PokemonListInitial extends PokemonListState {}

class PokemonListLoading extends PokemonListState {}

class PokemonListLoaded extends PokemonListState {
  final List<dynamic> pokemonList;
  final Map<String, String?> pokemonColors;

  const PokemonListLoaded(this.pokemonList, this.pokemonColors);

  @override
  List<Object> get props => [pokemonList, pokemonColors];
}

class PokemonListError extends PokemonListState {
  final String message;

  const PokemonListError(this.message);

  @override
  List<Object> get props => [message];
}
