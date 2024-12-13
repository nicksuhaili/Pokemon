import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import '../api/network_client.dart';
import '../api/pokemon_api_service.dart';
import '../bloc/pokemon_details_cubit.dart';
import '../bloc/pokemon_list_bloc.dart';
import '../repository/pokemon_repository.dart';
import '../repository/pokemon_repository_impl.dart';

final getIt = GetIt.instance;

//stores all dependencies in one place so that easy to access anywhere
void setupServiceLocator() {
  // Register NetworkClient, api service, repository
  getIt.registerLazySingleton(() => NetworkClient.createDio());
  getIt.registerLazySingleton(() => PokemonApiService(getIt<Dio>()));
  getIt.registerLazySingleton<PokemonRepository>(
        () => PokemonRepositoryImpl(apiService: getIt<PokemonApiService>()),
  );

  getIt.registerFactory(() => PokemonListBloc(repository: getIt<PokemonRepository>()));
  getIt.registerFactory(() => PokemonDetailsCubit(repository: getIt<PokemonRepository>()));



}
