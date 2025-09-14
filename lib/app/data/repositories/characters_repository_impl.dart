import 'package:wubba_lubba/app/domain/datasources/character_remote_datasource.dart';
import 'package:wubba_lubba/app/domain/domain.dart';
import 'package:wubba_lubba/shared/shared.dart';

class CharactersRepositoryImpl implements CharacterRepository {
  final CharacterRemoteDataSource remoteDataSource;

  CharactersRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future refreshSearch() async => getAllCharacters();

  @override
  Future<List<CharacterEntity>> getAllCharacters() async {
    final models = await remoteDataSource.getAllCharacters();
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<CharacterEntity> getCharacterById(int id) async {
    final model = await remoteDataSource.getCharacter(id);
    return model.toEntity();
  }

  @override
  Future<List<CharacterEntity>> searchCharacters(String query) async {
    final models = await remoteDataSource.searchCharacters(query);
    return models.map((model) => model.toEntity()).toList();
  }
}
