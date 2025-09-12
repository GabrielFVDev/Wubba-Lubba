import 'package:wubba_lubba/app/domain/entities/character_entity.dart';

abstract class CharacterRepository {
  Future<List<CharacterEntity>> getAllCharacters();
  Future<CharacterEntity> getCharacterById(int id);
}
