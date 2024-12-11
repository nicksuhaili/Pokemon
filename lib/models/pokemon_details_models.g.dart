// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_details_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PokemonDetails _$PokemonDetailsFromJson(Map<String, dynamic> json) =>
    PokemonDetails(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      height: (json['height'] as num?)?.toInt(),
      weight: (json['weight'] as num?)?.toInt(),
      baseExperience: (json['base_experience'] as num?)?.toInt(),
      types: (json['types'] as List<dynamic>)
          .map((e) => TypeData.fromJson(e as Map<String, dynamic>))
          .toList(),
      stats: (json['stats'] as List<dynamic>)
          .map((e) => StatData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PokemonDetailsToJson(PokemonDetails instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'height': instance.height,
      'weight': instance.weight,
      'base_experience': instance.baseExperience,
      'types': instance.types,
      'stats': instance.stats,
    };

TypeData _$TypeDataFromJson(Map<String, dynamic> json) => TypeData(
      type: Type.fromJson(json['type'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TypeDataToJson(TypeData instance) => <String, dynamic>{
      'type': instance.type,
    };

Type _$TypeFromJson(Map<String, dynamic> json) => Type(
      name: json['name'] as String?,
    );

Map<String, dynamic> _$TypeToJson(Type instance) => <String, dynamic>{
      'name': instance.name,
    };

StatData _$StatDataFromJson(Map<String, dynamic> json) => StatData(
      baseStat: (json['base_stat'] as num?)?.toInt(),
      stat: Stat.fromJson(json['stat'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$StatDataToJson(StatData instance) => <String, dynamic>{
      'base_stat': instance.baseStat,
      'stat': instance.stat,
    };

Stat _$StatFromJson(Map<String, dynamic> json) => Stat(
      name: json['name'] as String?,
    );

Map<String, dynamic> _$StatToJson(Stat instance) => <String, dynamic>{
      'name': instance.name,
    };
