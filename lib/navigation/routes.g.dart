// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $splashScreenRoute,
      $pokemonListRoute,
      $pokemonDetailsRoute,
    ];

RouteBase get $splashScreenRoute => GoRouteData.$route(
      path: '/',
      factory: $SplashScreenRouteExtension._fromState,
    );

extension $SplashScreenRouteExtension on SplashScreenRoute {
  static SplashScreenRoute _fromState(GoRouterState state) =>
      SplashScreenRoute();

  String get location => GoRouteData.$location(
        '/',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $pokemonListRoute => GoRouteData.$route(
      path: '/pokemon-list',
      factory: $PokemonListRouteExtension._fromState,
    );

extension $PokemonListRouteExtension on PokemonListRoute {
  static PokemonListRoute _fromState(GoRouterState state) => PokemonListRoute();

  String get location => GoRouteData.$location(
        '/pokemon-list',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $pokemonDetailsRoute => GoRouteData.$route(
      path: '/pokemon-details/:name/:imageUrl',
      factory: $PokemonDetailsRouteExtension._fromState,
    );

extension $PokemonDetailsRouteExtension on PokemonDetailsRoute {
  static PokemonDetailsRoute _fromState(GoRouterState state) =>
      PokemonDetailsRoute(
        name: state.pathParameters['name']!,
        imageUrl: state.pathParameters['imageUrl']!,
      );

  String get location => GoRouteData.$location(
        '/pokemon-details/${Uri.encodeComponent(name)}/${Uri.encodeComponent(imageUrl)}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
