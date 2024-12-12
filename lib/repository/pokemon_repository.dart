import 'package:pokemon/models/pokemon_details_models.dart';

import '../models/pokemon_list_models.dart';

// Handle fetching data api of PokemonDetails
abstract class PokemonRepository {
  Future<PokemonDetails?> getPokemonDetails(String name);
  Future<PokemonListResponse> getPokemonList(int offset, int limit);
}