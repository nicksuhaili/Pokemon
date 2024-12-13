import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon/bloc/pokemon_list_event.dart';
import 'package:pokemon/bloc/pokemon_list_state.dart';

import '../pokemon_utils.dart';
import '../repository/pokemon_repository.dart';

class PokemonListBloc extends Bloc<PokemonListEvent, PokemonListState> {
  final PokemonRepository repository;

  PokemonListBloc({required this.repository}) : super(PokemonListInitial()) {
    on<FetchPokemonList>((event, emit) async {
      emit(PokemonListLoading());
      try {
        final response = await repository.getPokemonList(0, 30);
        final pokemonList = response.results
            .map((item) => {'name': item.name, 'url': item.url})
            .toList();

        final pokemonColors = <String, String?>{};
        final colorFutures = pokemonList.map((pokemon) async {
          try {
            final color = await fetchPokemonColor(pokemon['name'] ?? '');
            pokemonColors[pokemon['name'] ?? ''] = color;
          } catch (e) {
            pokemonColors[pokemon['name'] ?? ''] = 'grey';
          }
        });

        await Future.wait(colorFutures);
        emit(PokemonListLoaded(pokemonList, pokemonColors));
      } catch (e) {
        emit(PokemonListError(e.toString()));
      }
    });
  }
}
