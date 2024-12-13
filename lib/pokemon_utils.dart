import 'dart:convert'; //decodes json responses into dart objects
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// HTTP Get request to fetch color from the species API.
Future<String> fetchPokemonColor(String pokemonName) async {
  try {
    final url = Uri.parse('https://pokeapi.co/api/v2/pokemon-species/$pokemonName');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['color']['name'] ?? 'grey';
    } else {
      return 'grey';
    }
  } catch (e) {
    return 'grey';
  }
}

Color getMaterialColor(String? colorName) {
  switch (colorName) {
    case 'red':
      return Colors.red[300]!;
    case 'blue':
      return Colors.blue[200]!;
    case 'green':
      return Colors.green[500]!;
    case 'yellow':
      return Colors.yellow[300]!;
    case 'purple':
      return Colors.purple[300]!;
    case 'pink':
      return Colors.pink;
    case 'brown':
      return Colors.brown[300]!;
    case 'gray':
      return Colors.grey;
    case 'black':
      return Colors.black;
    case 'white':
      return Colors.white;
    default:
      return Colors.white;
  }
}
