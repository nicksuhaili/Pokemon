
import 'package:pokemon/repository/pokemon_repository.dart';

import '../api/pokemon_api_service.dart';
import '../models/pokemon_details_models.dart';
import '../models/pokemon_list_models.dart';

class PokemonRepositoryImpl implements PokemonRepository {
  final PokemonApiService apiService;

  PokemonRepositoryImpl({required this.apiService});

  @override
  Future<PokemonDetails?> getPokemonDetails(String name) async {
    try {
      return await apiService.getPokemonDetails(name);
    } catch (e) {
      throw Exception('Failed to fetch Pokemon details: $e');
    }
  }

  @override
  Future<PokemonListResponse> getPokemonList(int offset, int limit) async {
    try {
      return await apiService.getPokemonList(offset, limit);
    } catch (e) {
      throw Exception('Failed to fetch Pokemon list: $e');
    }
  }
}

