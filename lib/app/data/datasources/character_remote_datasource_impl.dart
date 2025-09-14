import 'package:dio/dio.dart';
import 'package:wubba_lubba/app/data/data.dart';
import 'package:wubba_lubba/app/domain/domain.dart';

/// Implementação da fonte de dados remota usando Dio
class CharacterRemoteDataSourceImpl implements CharacterRemoteDataSource {
  final Dio client;

  CharacterRemoteDataSourceImpl({required this.client});

  @override
  Future<List<CharacterModel>> getAllCharacters() async {
    try {
      final response = await client.get('/character');

      if (response.statusCode == 200) {
        final List<dynamic> charactersJson = response.data['results'];
        return charactersJson
            .map((json) => CharacterModel.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to load characters');
      }
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  @override
  Future<CharacterModel> getCharacter(int id) async {
    try {
      final response = await client.get('/character/$id');

      if (response.statusCode == 200) {
        return CharacterModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load character');
      }
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  @override
  Future<List<CharacterModel>> searchCharacters(String query) async {
    Map<String, String> queryParams = {};

    // Se a query contém '&' ou '=', trata como query string completa
    if (query.contains('&') || query.contains('=')) {
      // Parse manual da query string: "name=rick&status=alive"
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
      final response = await client.get(
        '/character',
        queryParameters: queryParams,
      );

      if (response.statusCode == 200) {
        final List<dynamic> charactersJson = response.data['results'] ?? [];
        return charactersJson
            .map((json) => CharacterModel.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to search characters');
      }
    } on DioException catch (e) {
      // Se a API retornar 404 (sem resultados), retorna lista vazia
      if (e.response?.statusCode == 404) return [];
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}
