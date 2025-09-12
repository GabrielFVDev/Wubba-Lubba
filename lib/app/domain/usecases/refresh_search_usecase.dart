import 'package:wubba_lubba/app/domain/domain.dart';

class RefreshSearchUseCase {
  final CharacterRepository repository;

  RefreshSearchUseCase(this.repository);

  Future refresh() {
    return repository.refreshSearch();
  }
}
