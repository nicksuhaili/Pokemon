import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'pokemon_list_event.dart';
import 'pokemon_list_state.dart';
import 'package:pokemon/pokemon_utils.dart';

class PokemonListBloc extends Bloc<PokemonListEvent, PokemonListState> {
  PokemonListBloc() : super(PokemonListInitial()) {
    on<FetchPokemonList>(_onFetchPokemonList);
  }

  Future<void> _onFetchPokemonList(FetchPokemonList event,
      Emitter<PokemonListState> emit) async {
    emit(PokemonListLoading());
    try {
      final url =
      Uri.parse('https://pokeapi.co/api/v2/pokemon?offset=0&limit=30');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        List<dynamic> pokemonList = data['results'];

        final List<Future<String?>> colorFutures = pokemonList
            .map((pokemon) => fetchPokemonColor(pokemon['name']))
            .toList();

        final List<String?> pokemonColorsList = await Future.wait(colorFutures);

        // Map pokemon colors to their names
        Map<String, String?> pokemonColors = {};
        for (int i = 0; i < pokemonList.length; i++) {
          pokemonColors[pokemonList[i]['name']] = pokemonColorsList[i];
        }

        emit(PokemonListLoaded(pokemonList, pokemonColors));
      } else {
        emit(const PokemonListError('Failed to load Pokémon list.'));
      }
    } catch (e) {
      emit(PokemonListError('An error occurred: $e'));
    }
  }
}
