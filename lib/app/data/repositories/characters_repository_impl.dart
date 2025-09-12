import 'package:dio/dio.dart';
import 'package:wubba_lubba/app/data/models/character_model.dart';
import 'package:wubba_lubba/app/domain/domain.dart';
import 'package:wubba_lubba/core/api_url.dart';
import 'package:wubba_lubba/shared/shared.dart';

class CharactersRepositoryImpl implements CharacterRepository {
  final Dio client;
  final String baseUrl;

  CharactersRepositoryImpl({
    required this.client,
    this.baseUrl = apiUrl,
  });

  @override
  Future refreshSearch() async => getAllCharacters();

  // referencia
  // https://rickandmortyapi.com/api/character
  @override
  Future<List<CharacterEntity>> getAllCharacters() async {
    final resp = await client.get(baseUrl);
    final data = resp.data;
    if (data == null || data['results'] == null) return [];
    final list = (data['results'] as List)
        .map((e) => CharacterModel.fromJson(e as Map<String, dynamic>))
        .toList();
    return list.map((m) => m.toEntity()).toList();
  }

  // referencia
  // https://rickandmortyapi.com/api/character/2
  @override
  Future<CharacterEntity> getCharacterById(int id) async {
    final resp = await client.get('$baseUrl/$id');
    final data = resp.data as Map<String, dynamic>;
    final model = CharacterModel.fromJson(data);
    return model.toEntity();
  }

  // referencia
  // https://rickandmortyapi.com/api/character/?name=rick&status=alive
  @override
  Future<List<CharacterEntity>> searchCharacters(String query) async {
    Map<String, String> queryParams = {};

    // Se a query contém '&' ou '=', trata como query string completa
    if (query.contains('&') || query.contains('=')) {
      // Parse manual da query string: "name=rick"
      final pairs = query.split('&');
      for (final pair in pairs) {
        final keyValue = pair.split('=');
        if (keyValue.length == 2) {
          queryParams[keyValue[0].trim()] = keyValue[1].trim();
        }
      }
    } else {
      // Query simples, assume que é busca por nome
      queryParams['name'] = query;
    }

    try {
      final resp = await client.get(baseUrl, queryParameters: queryParams);
      final data = resp.data;

      if (data == null || data['results'] == null) return [];

      final list = (data['results'] as List)
          .map((e) => CharacterModel.fromJson(e as Map<String, dynamic>))
          .toList();
      return list.map((m) => m.toEntity()).toList();
    } on DioException catch (e) {
      // Se a API retornar 404 (sem resultados), retorna lista vazia
      if (e.response?.statusCode == 404) return [];
      rethrow;
    }
  }
}
