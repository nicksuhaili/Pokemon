import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:pokemon/pokemon_details.dart';
import 'package:pokemon/pokemon_list.dart';
import 'package:pokemon/splash_screen.dart';

part 'routes.g.dart';

@TypedGoRoute<SplashScreenRoute>(
  path: '/',
)
class SplashScreenRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const SplashScreen();
}

@TypedGoRoute<PokemonListRoute>(
  path: '/pokemon-list',
)
class PokemonListRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const PokemonListPage();
}

@TypedGoRoute<PokemonDetailsRoute>(
  path: '/pokemon-details/:name/:imageUrl',
)
class PokemonDetailsRoute extends GoRouteData {
  final String name;
  final String imageUrl;

  PokemonDetailsRoute({required this.name, required this.imageUrl});

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      PokemonDetailsPage(name: name, imageUrl: imageUrl);
}
