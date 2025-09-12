import 'package:wubba_lubba/app/domain/domain.dart';

class GetCharacterUseCase {
  final CharacterRepository repository;

  GetCharacterUseCase(this.repository);

  Future<CharacterEntity?> getCharacterById(int id) {
    return repository.getCharacterById(id);
  }

  Future<CharacterEntity?> call(int id) => getCharacterById(id);
}
