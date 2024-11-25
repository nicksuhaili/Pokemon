import 'dart:convert';
import 'package:flutter/material.dart'; // to use the ui components; gridview, card
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'pokemon_details.dart';
import 'pokemon_utils.dart';

class PokemonListPage extends StatefulWidget {
  const PokemonListPage({super.key});
  @override
  _PokemonListPageState createState() => _PokemonListPageState();
}


class _PokemonListPageState extends State<PokemonListPage>
with SingleTickerProviderStateMixin {
  //TickerProvider to manage animations

  List<dynamic> pokemonList = [];
  Map<String, String?> pokemonColors = {};

  late final AnimationController _lottieController;

  @override
  void initState() {
    super.initState();
    fetchPokemonList();
    _lottieController = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _lottieController.dispose();
    super.dispose();
  }
  // Http get request to fetch the pokemon list
  Future<void> fetchPokemonList() async {
    final url = Uri.parse('https://pokeapi.co/api/v2/pokemon?offset=0&limit=30');
    final response = await http.get(url);
    //decodes JSON response to extract the list results
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        pokemonList = data['results'];
      });
      //loops to fetch name to pass to fetchPokemonColor in utils
      for (var pokemon in data['results']) {
        fetchAndStorePokemonColor(pokemon['name']);
      }
    } else {
      throw Exception('Failed to load Pokémon list');
    }
  }

  //fetch the pokemon name to pass and update the fetchPokemonColor map
  Future<void> fetchAndStorePokemonColor(String name) async {
    try {
      final colorName = await fetchPokemonColor(name);
      setState(() {
        pokemonColors[name] = colorName;
      });
    } catch (e) {
      debugPrint('Error fetching color for $name: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Hero(
          tag: 'splashLogo',
          child: Lottie.asset(
            'assets/animations/splash_logo.json',
            width: 50,
            height: 50,
            fit: BoxFit.contain,
            repeat: false,
            controller: _lottieController,
            onLoaded: (composition){
              _lottieController.duration = composition.duration;
              _lottieController.forward();
            }
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 26.0),
              child: Text(
                'Pokedex',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: pokemonList.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,      // 2 grid per row
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 8.0,
                        mainAxisExtent: 140,   //each grid's height
                      ),
                      itemCount: pokemonList.length,
                      //the card grid content
                      itemBuilder: (context, index) {
                        final pokemon = pokemonList[index];
                        final id = index + 1;
                        final imageUrl =
                            'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png';
                        final colorName =
                            pokemonColors[pokemon['name']] ?? 'grey';
                        final backgroundColor = getMaterialColor(
                            colorName);

                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PokemonDetailsPage(
                                  name: pokemon['name'],
                                  imageUrl: imageUrl,
                                ),
                              ),
                            );
                          },
                          child: Card(
                            color: backgroundColor,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    pokemon['name'][0].toUpperCase() +
                                        pokemon['name'].substring(1),
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const Spacer(),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Hero(
                                      tag: pokemon['name'],
                                      child: Image.network(
                                        imageUrl,
                                        height: 70,
                                        width: 90,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
