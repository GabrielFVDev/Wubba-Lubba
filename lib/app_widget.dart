import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:wubba_lubba/core/api_url.dart';
import 'package:wubba_lubba/core/routes.dart';
import 'package:wubba_lubba/app/data/data.dart';
import 'package:wubba_lubba/app/domain/domain.dart';
import 'package:wubba_lubba/app/presentation/presentation.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final dio = Dio(BaseOptions(baseUrl: apiUrl));
    final remoteDataSource = CharacterRemoteDataSourceImpl(client: dio);
    final repository = CharactersRepositoryImpl(
      remoteDataSource: remoteDataSource,
    );
    final getAllCharactersUseCase = GetAllCharactersUseCase(repository);
    final getCharacterUseCase = GetCharacterUseCase(repository);
    final searchCharactersUseCase = SearchCharactersUseCase(repository);
    final refreshSearchUseCase = RefreshSearchUseCase(repository);

    return BlocProvider<CharactersBloc>(
      create: (_) => CharactersBloc(
        getAllCharacters: getAllCharactersUseCase,
        getCharacter: getCharacterUseCase,
        refreshSearch: refreshSearchUseCase,
        searchCharacters: searchCharactersUseCase,
      )..add(LoadCharacters()),
      child: MaterialApp.router(
        title: 'Wubba Lubba',
        routerConfig: router,
      ),
    );
  }
}
