import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pokemon/di/service_locator.dart';
import '../bloc/pokemon_details_cubit.dart';
import '../models/pokemon_details_models.dart';
import '../pokemon_utils.dart';

class PokemonDetailsPage extends StatefulWidget {
  final String name;
  final String imageUrl;

  const PokemonDetailsPage({
    super.key,
    required this.name,
    required this.imageUrl,
  });

  @override
  State<PokemonDetailsPage> createState() => _PokemonDetailsPageState();
}

class _PokemonDetailsPageState extends State<PokemonDetailsPage> {
  Color backgroundColor = Colors.white;
  PokemonDetails? pokemonDetails;
  bool isLoadingDetails = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchBackgroundColor();
  }

  Future<void> _fetchBackgroundColor() async {
    try {
      final colorName = await fetchPokemonColor(widget.name);
      setState(() {
        backgroundColor = getMaterialColor(colorName);
      });
    } catch (e) {
      debugPrint('Error fetching Pokémon color: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PokemonDetailsCubit(repository: getIt())..fetchPokemonDetails(widget.name),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(''),
          backgroundColor: backgroundColor,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              GoRouter.of(context).pop();
            },
          ),
        ),
        // handle state changes
        body: BlocListener<PokemonDetailsCubit, PokemonDetailsState>(
          listener: (context, state) {
            if (state is PokemonDetailsLoading) {
              setState(() {
                isLoadingDetails = true;
                errorMessage = null;
              });
            } else if (state is PokemonDetailsLoaded) {
              setState(() {
                isLoadingDetails = false; // display details if not loading
                pokemonDetails = state.details;
                errorMessage = null;
              });
            } else if (state is PokemonDetailsError) {
              setState(() {
                isLoadingDetails = false;
                errorMessage = state.message;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          child: Stack(
            children: [
              _buildStaticContent(),
              if (isLoadingDetails)
                const Center(child: CircularProgressIndicator())
              else if (errorMessage != null)
                Center(
                  child: Text(
                    'Error: $errorMessage',
                    style: const TextStyle(color: Colors.red),
                  ),
                )
              else
                _buildDetailsContent(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStaticContent() {
    return Container(
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
                Material(
                  color: Colors.transparent,
                  child: Hero(
                    tag: widget.name,
                    child: Image.network(
                      widget.imageUrl,
                      height: 200,
                      width: 200,
                      // display indicator if image is loading
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const Center(child: CircularProgressIndicator());
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(
                          Icons.broken_image,
                          size: 200,
                          color: Colors.grey,
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailsContent() {
    if (pokemonDetails == null) {
      return const Center(child: Text('No details available.'));
    }

    final details = pokemonDetails!;
    return Align(
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 16),
              Text(
                "ID: ${details.id ?? ''}",
                style: const TextStyle(fontSize: 16),
              ),
              Text(
                "Height: ${details.height ?? ''}",
                style: const TextStyle(fontSize: 16),
              ),
              Text(
                "Weight: ${details.weight ?? ''}",
                style: const TextStyle(fontSize: 16),
              ),
              Text(
                "Base Experience: ${details.baseExperience ?? ''}",
                style: const TextStyle(fontSize: 16),
              ),
              Text(
                "Types: ${details.types.map((type) =>
                type.type.name ?? 'Unknown').join(', ') ?? 'Unknown'}",
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
              ...(details.stats.map<Widget>((stat) {
                final statName = stat.stat.name ?? '';
                final statValue = stat.baseStat ?? 0;
                const maxStatValue = 150;

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "$statName: $statValue",
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      Stack(
                        children: [
                          Container(
                            height: 8,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          Container(
                            height: 8,
                            width: MediaQuery.of(context).size.width *
                                0.8 *
                                (statValue / maxStatValue),
                            decoration: BoxDecoration(
                              color: Colors.red[400],
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }).toList()),
            ],
          ),
        ),
      ),
    );
  }
}
