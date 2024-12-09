import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

part 'pokemon_details_state.dart';

// Manage state changes, fetching data api

class PokemonDetailsCubit extends Cubit<PokemonDetailsState> {
  PokemonDetailsCubit() : super(PokemonDetailsInitial());

  Future<void> fetchPokemonDetails(String name) async {
    emit(PokemonDetailsLoading());
    try {
      final url = Uri.parse('https://pokeapi.co/api/v2/pokemon/$name');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        emit(PokemonDetailsLoaded(data));
      } else {
        emit(PokemonDetailsError('Failed to load Pokémon details.'));
      }
    } catch (e) {
      emit(PokemonDetailsError(e.toString()));
    }
  }
}
