import 'package:wubba_lubba/app/domain/domain.dart';

class GetCharacterUseCase {
  final CharacterRepository repository;

  GetCharacterUseCase(this.repository);

  Future<CharacterEntity?> getById(int id) {
    return repository.getCharacterById(id);
  }
}
