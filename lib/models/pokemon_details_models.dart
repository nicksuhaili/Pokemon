import 'package:freezed_annotation/freezed_annotation.dart';

part 'pokemon_details_models.freezed.dart';
part 'pokemon_details_models.g.dart';

// Define the pokemon data responses from api
@freezed
class PokemonDetails with _$PokemonDetails {
  const factory PokemonDetails({
    required int id,
    required String name,
    int? height,
    int? weight,
    @JsonKey(name: "base_experience") int? baseExperience,
    required List<TypeData> types,
    required List<StatData> stats,
  }) = _PokemonDetails;

  // Map JSON data from api to dart objects ( from json in the generated file)
  factory PokemonDetails.fromJson(Map<String, dynamic> json) =>
      _$PokemonDetailsFromJson(json);
}

//generate code for parsing json
@freezed
class TypeData with _$TypeData {
  const factory TypeData ({
    required Type type,
  }) = _TypeData;

  factory TypeData.fromJson(Map<String, dynamic> json) =>
      _$TypeDataFromJson(json);
}

@freezed
class Type with _$Type {
  const factory Type ({
    String? name,

  }) = _Type;

  factory Type.fromJson(Map<String, dynamic> json) => _$TypeFromJson(json);
}

@freezed
class StatData with _$StatData {
  const factory StatData ({
    @JsonKey(name: "base_stat") int? baseStat,
    required Stat stat,
  }) = _StatData;

  factory StatData.fromJson(Map<String, dynamic> json) =>
      _$StatDataFromJson(json);
}

@freezed
class Stat with _$Stat {
  const factory Stat ({
    String? name,
  }) = _Stat;

  factory Stat.fromJson(Map<String, dynamic> json) => _$StatFromJson(json);
}
