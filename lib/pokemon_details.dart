import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'pokemon_utils.dart';

class PokemonDetailsPage extends StatefulWidget {
  final String name;
  final String imageUrl;

  const PokemonDetailsPage({
    super.key,
    required this.name,
    required this.imageUrl,
  });

  @override
  _PokemonDetailsPageState createState() => _PokemonDetailsPageState();
}

class _PokemonDetailsPageState extends State<PokemonDetailsPage> {
  Map<String, dynamic>? _pokemonDetails;
  String? _pokemonColorName;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchPokemonDetails();
    _fetchPokemonColorName();
  }

  // HTTP GET request to fetch Pokémon details
  Future<void> _fetchPokemonDetails() async {
    final url = Uri.parse('https://pokeapi.co/api/v2/pokemon/${widget.name}');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      setState(() {
        _pokemonDetails = jsonDecode(response.body);
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      throw Exception('Failed to load Pokémon details');
    }
  }

  // Fetch Pokémon color name
  Future<void> _fetchPokemonColorName() async {
    try {
      final colorName = await fetchPokemonColor(widget.name);
      setState(() {
        _pokemonColorName = colorName;
      });
    } catch (e) {
      debugPrint('Error fetching color: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = getMaterialColor(_pokemonColorName);

    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        backgroundColor: backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            if (GoRouter.of(context).canPop()) {
              GoRouter.of(context).pop();
            } else {
              GoRouter.of(context).go('/pokemon-list');
            }
          },
        ),
      ),
      body: Container(
        color: backgroundColor,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  Text(
                    widget.name[0].toUpperCase() + widget.name.substring(1),
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Hero(
                    tag: widget.name,
                    child: Image.network(
                      widget.imageUrl,
                      height: 200,
                      width: 200,
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      spreadRadius: 3,
                      blurRadius: 4,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(20.0),
                height: MediaQuery.of(context).size.height * 0.58,
                width: MediaQuery.of(context).size.width,
                child: _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : SingleChildScrollView(
                        child: _pokemonDetails != null
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox(height: 16),
                                  Text(
                                    "ID: ${_pokemonDetails?['id'] ?? ''}",
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  Text(
                                    "Height: ${_pokemonDetails?['height'] ?? ''}",
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  Text(
                                    "Weight: ${_pokemonDetails?['weight'] ?? ''}",
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  Text(
                                    "Base Experience: ${_pokemonDetails?['base_experience'] ?? ''}",
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  Text(
                                    "Types: ${(_pokemonDetails?['types'] as List<dynamic>?)?.map((type) => type['type']['name']).join(', ') ?? 'Unknown'}",
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  const SizedBox(height: 20),
                                  const Text(
                                    "Base Stats:",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  ...(_pokemonDetails?['stats']
                                              as List<dynamic>?)
                                          ?.map<Widget>((stat) {
                                        final statName =
                                            stat['stat']['name'] ?? '';
                                        final statValue =
                                            stat['base_stat'] ?? 0;
                                        const maxStatValue = 150;

                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 4.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "$statName: $statValue",
                                                style: const TextStyle(
                                                    fontSize: 16),
                                              ),
                                              const SizedBox(height: 8),
                                              Stack(
                                                children: [
                                                  Container(
                                                    height: 4,
                                                    width: double.infinity,
                                                    decoration: BoxDecoration(
                                                      color:
                                                          Colors.grey.shade300,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 4,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.8 *
                                                            (statValue /
                                                                maxStatValue),
                                                    decoration: BoxDecoration(
                                                      color: Colors.red[400],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        );
                                      }).toList() ??
                                      [],
                                ],
                              )
                            : const Text(
                                'No details available.',
                                style: TextStyle(fontSize: 16),
                              ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
