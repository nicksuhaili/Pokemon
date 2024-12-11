import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:pokemon/bloc/pokemon_list_bloc.dart';
import 'package:pokemon/bloc/pokemon_list_state.dart';
import 'package:pokemon/pokemon_utils.dart';
import 'package:pokemon/routes.dart';

class PokemonListPage extends StatelessWidget {
  const PokemonListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _PokemonListView();
  }
}

class _PokemonListView extends StatefulWidget {
  const _PokemonListView();

  @override
  State<_PokemonListView> createState() => _PokemonListViewState();
}

class _PokemonListViewState extends State<_PokemonListView>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
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
            controller: _animationController,

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
              child: BlocBuilder<PokemonListBloc, PokemonListState>(
                builder: (context, state) {
                  if (state is PokemonListLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is PokemonListLoaded) {
                    final pokemonList = state.pokemonList;
                    final pokemonColors = state.pokemonColors;

                    return GridView.builder(
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 8.0,
                        mainAxisExtent: 140,
                      ),
                      itemCount: pokemonList.length,
                      itemBuilder: (context, index) {
                        final pokemon = pokemonList[index];
                        final id = index + 1;
                        final imageUrl =
                            'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png';
                        final colorName =
                            pokemonColors[pokemon['name']] ?? 'grey';
                        final backgroundColor = getMaterialColor(colorName);

                        return GestureDetector(
                          onTap: (){
                            final imageUrl =
                                'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${index + 1}.png';
                            PokemonDetailsRoute(
                                name: pokemon['name'], imageUrl: imageUrl)
                                .push(context);

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

                                    child: Material(
                                      color: Colors.transparent,
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
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else if (state is PokemonListError) {
                    return Center(
                      child: Text('Error: ${state.message}'),
                    );
                  }
                  return const Center(child: Text('Something went wrong.'));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

}
