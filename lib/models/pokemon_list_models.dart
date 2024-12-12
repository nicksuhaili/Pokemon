import 'package:json_annotation/json_annotation.dart';

part 'pokemon_list_models.g.dart';

@JsonSerializable()
class PokemonListResponse {
  final int count;
  final String? next;
  final String? previous;
  final List<PokemonItem> results;

  PokemonListResponse({
    required this.count,
    this.next,
    this.previous,
    required this.results,
  });

  factory PokemonListResponse.fromJson(Map<String, dynamic> json) =>
      _$PokemonListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PokemonListResponseToJson(this);
}

@JsonSerializable()
class PokemonItem {
  final String name;
  final String url;

  PokemonItem({
    required this.name,
    required this.url,
  });

  factory PokemonItem.fromJson(Map<String, dynamic> json) =>
      _$PokemonItemFromJson(json);

  Map<String, dynamic> toJson() => _$PokemonItemToJson(this);
}
