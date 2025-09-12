import 'package:wubba_lubba/app/domain/domain.dart';

class SearchCharactersUseCase {
  final CharacterRepository repository;

  SearchCharactersUseCase(this.repository);

  Future<List<CharacterEntity>> searchCharacters(String query) {
    return repository.searchCharacters(query);
  }
}
