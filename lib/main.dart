import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pokemon/bloc/pokemon_list_bloc.dart';
import 'package:pokemon/routes.dart';

import 'bloc/pokemon_list_event.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PokemonListBloc>(
          create: (_) => PokemonListBloc()..add(FetchPokemonList()),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: GoRouter(
          initialLocation: '/',
          routes: $appRoutes,
        ),
      ),
    );
  }
}
