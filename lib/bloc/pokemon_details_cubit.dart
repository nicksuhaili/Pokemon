import 'package:flutter_bloc/flutter_bloc.dart';
import '../api/network_client.dart';
import '../api/pokemon_api_service.dart';
import '../models/pokemon_details_models.dart';

part 'pokemon_details_state.dart';

class PokemonDetailsCubit extends Cubit<PokemonDetailsState> {

  final PokemonApiService apiService;
  //use NetworkClient to make api call
  PokemonDetailsCubit(): apiService = PokemonApiService(NetworkClient.createDio()),
        super(PokemonDetailsInitial());

  Future<void> fetchPokemonDetails(String name) async {

    emit(PokemonDetailsLoading());
    try {
      //get the pokemon data
      final details = await apiService.getPokemonDetails(name);
      //if the data is null
      if (details == null) {
        emit(PokemonDetailsError("Pokémon details could not be loaded."));
        return;
      }
      //emit the PokemonDetailsLoaded with data
      emit(PokemonDetailsLoaded(details));
    } catch (e) {
      emit(PokemonDetailsError("Error fetching Pokémon details: $e"));
    }

  }
}
