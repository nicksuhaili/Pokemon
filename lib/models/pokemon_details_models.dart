import 'package:json_annotation/json_annotation.dart';

part 'pokemon_details_models.g.dart';

// Define the pokemon data responses from api
@JsonSerializable()
class PokemonDetails {
  final int id;
  final String name;
  final int? height;
  final int? weight;
  @JsonKey(name: "base_experience")
  final int? baseExperience;
  final List<TypeData> types;
  final List<StatData> stats;

  PokemonDetails({
    required this.id,
    required this.name,
    this.height,
    this.weight,
    this.baseExperience,
    required this.types,
    required this.stats
  });
  // Map JSON data from api to dart objects ( from json and to json in the generated file)
  factory PokemonDetails.fromJson(Map<String, dynamic> json) =>
      _$PokemonDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$PokemonDetailsToJson(this);

}

//generate code for parsing json
@JsonSerializable()
class TypeData {
  final Type type;
  TypeData({required this.type});

  factory TypeData.fromJson(Map<String, dynamic> json) =>
      _$TypeDataFromJson(json);
  Map<String, dynamic> toJson() => _$TypeDataToJson(this);
}
@JsonSerializable()
class Type {
  final String? name;
  Type({this.name});

  factory Type.fromJson(Map<String, dynamic> json) => _$TypeFromJson(json);
  Map<String, dynamic> toJson() => _$TypeToJson(this);
}

@JsonSerializable()
class StatData {
  @JsonKey(name: "base_stat")
  final int? baseStat;
  final Stat stat;
  StatData({this.baseStat, required this.stat});

  factory StatData.fromJson(Map<String, dynamic> json) =>
      _$StatDataFromJson(json);
  Map<String, dynamic> toJson() => _$StatDataToJson(this);
}
@JsonSerializable()
class Stat {
  final String? name;
  Stat({this.name});

  factory Stat.fromJson(Map<String, dynamic> json) => _$StatFromJson(json);
  Map<String, dynamic> toJson() => _$StatToJson(this);
}
