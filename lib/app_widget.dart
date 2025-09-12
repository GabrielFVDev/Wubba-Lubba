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
          create: (_) => Dio(
            BaseOptions(
              baseUrl: apiUrl,
            ),
          ),
        ),
        ProxyProvider<Dio, CharacterRepository>(
          update: (_, dio, __) => CharactersRepositoryImpl(client: dio),
        ),
        ProxyProvider<CharacterRepository, GetAllCharactersUseCase>(
          update: (_, repo, __) => GetAllCharactersUseCase(repo),
        ),
        ProxyProvider<CharacterRepository, GetCharacterUseCase>(
          update: (_, repo, __) => GetCharacterUseCase(repo),
        ),
        ProxyProvider<CharacterRepository, SearchCharactersUseCase>(
          update: (_, repo, __) => SearchCharactersUseCase(repo),
        ),
        ProxyProvider<CharacterRepository, RefreshSearchUseCase>(
          update: (_, repo, __) => RefreshSearchUseCase(repo),
        ),
      ],
      child: Builder(
        builder: (context) {
          final getAll = context.read<GetAllCharactersUseCase>();
          final getCharacter = context.read<GetCharacterUseCase>();
          final refresh = context.read<RefreshSearchUseCase>();
          final search = context.read<SearchCharactersUseCase>();

          return BlocProvider<CharactersBloc>(
            create: (_) => CharactersBloc(
              getAllCharacters: getAll,
              getCharacter: getCharacter,
              refreshSearch: refresh,
              searchCharacters: search,
            )..add(LoadCharacters()),
            child: MaterialApp.router(
              title: 'Wubba Lubba',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              ),
              routerConfig: router,
            ),
          );
        },
      ),
    );
  }
}
