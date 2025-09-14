import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:wubba_lubba/core/api_url.dart';
import 'package:wubba_lubba/core/routes.dart';
import 'package:wubba_lubba/app/data/repositories/characters_repository_impl.dart';
import 'package:wubba_lubba/app/domain/domain.dart';
import 'package:wubba_lubba/app/presentation/presentation.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<Dio>(
          create: (_) => Dio(BaseOptions(baseUrl: apiUrl)),
          dispose: (_, dio) => dio.close(),
        ),
        ProxyProvider<Dio, CharacterRepository>(
          update: (_, dio, previous) =>
              previous ?? CharactersRepositoryImpl(client: dio),
        ),
        ProxyProvider<CharacterRepository, GetAllCharactersUseCase>(
          update: (_, repo, previous) =>
              previous ?? GetAllCharactersUseCase(repo),
        ),
        ProxyProvider<CharacterRepository, GetCharacterUseCase>(
          update: (_, repo, previous) => previous ?? GetCharacterUseCase(repo),
        ),
        ProxyProvider<CharacterRepository, SearchCharactersUseCase>(
          update: (_, repo, previous) =>
              previous ?? SearchCharactersUseCase(repo),
        ),
        ProxyProvider<CharacterRepository, RefreshSearchUseCase>(
          update: (_, repo, previous) => previous ?? RefreshSearchUseCase(repo),
        ),
        BlocProvider<CharactersBloc>(
          create: (context) => CharactersBloc(
            getAllCharacters: context.read<GetAllCharactersUseCase>(),
            getCharacter: context.read<GetCharacterUseCase>(),
            refreshSearch: context.read<RefreshSearchUseCase>(),
            searchCharacters: context.read<SearchCharactersUseCase>(),
          )..add(LoadCharacters()),
        ),
      ],
      child: MaterialApp.router(
        title: 'Wubba Lubba',
        routerConfig: router,
      ),
    );
  }
}
