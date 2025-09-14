import 'package:wubba_lubba/app/data/models/character_model.dart';

abstract class CharacterRemoteDataSource {
  Future<List<CharacterModel>> getAllCharacters();
  Future<CharacterModel> getCharacter(int id);
  Future<List<CharacterModel>> searchCharacters(String query);
}
