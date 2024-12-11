import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../models/pokemon_details_models.dart';

part 'pokemon_api_service.g.dart';

// Retrofit to define api base url and endpoint
@RestApi(baseUrl: "https://pokeapi.co/api/v2/")
abstract class PokemonApiService {

  factory PokemonApiService(Dio dio, {String baseUrl}) = _PokemonApiService;

  @GET("pokemon/{name}")
  Future<PokemonDetails?> getPokemonDetails(@Path("name") String name);


}
