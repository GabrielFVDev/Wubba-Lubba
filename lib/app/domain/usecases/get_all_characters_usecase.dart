import 'package:wubba_lubba/app/domain/entities/character_entity.dart';
import 'package:wubba_lubba/app/domain/repositories/character_repository.dart';

class GetAllCharactersUseCase {
  final CharacterRepository repository;

  GetAllCharactersUseCase(this.repository);

  Future<List<CharacterEntity>> getAllCharacters() {
    return repository.getAllCharacters();
  }

  Future<List<CharacterEntity>> call() => getAllCharacters();
}
