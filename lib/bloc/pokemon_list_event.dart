import 'package:equatable/equatable.dart';

abstract class PokemonListEvent extends Equatable {
  const PokemonListEvent();

  @override
  List<Object> get props => [];
}

class FetchPokemonList extends PokemonListEvent {}