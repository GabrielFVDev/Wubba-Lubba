import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wubba_lubba/app/domain/domain.dart';
import 'package:wubba_lubba/app/presentation/presentation.dart';

class CharactersBloc extends Bloc<CharactersEvent, CharactersState> {
  final GetAllCharactersUseCase getAllCharacters;
  final GetCharacterUseCase getCharacter;
  final RefreshSearchUseCase refreshSearch;
  final SearchCharactersUseCase searchCharacters;

  CharactersBloc({
    required this.getAllCharacters,
    required this.getCharacter,
    required this.refreshSearch,
    required this.searchCharacters,
  }) : super(CharactersInitial()) {
    on<LoadCharacters>(_onLoadCharacters);
    on<RefreshCharacters>(_onRefresh);
    on<SearchCharacters>(_onSearchCharacter);
    on<LoadCharacterById>(_onLoadCharacterById);
  }

  Future _onLoadCharacters(
    LoadCharacters event,
    Emitter<CharactersState> emit,
  ) async {
    emit(CharactersLoading());
    try {
      final listCharacters = await getAllCharacters();
      if (listCharacters.isEmpty) {
        emit(CharactersEmpty());
      } else {
        emit(CharactersLoaded(listCharacters));
      }
    } catch (e) {
      emit(CharactersError(e.toString()));
    }
  }

  Future _onRefresh(
    RefreshCharacters event,
    Emitter<CharactersState> emit,
  ) async {
    emit(CharactersLoading());
    try {
      await refreshSearch();
      final list = await getAllCharacters();
      if (list.isEmpty) {
        emit(CharactersEmpty());
      } else {
        emit(CharactersLoaded(list));
      }
    } catch (e) {
      emit(CharactersError(e.toString()));
    }
  }

  Future _onSearchCharacter(
    SearchCharacters event,
    Emitter<CharactersState> emit,
  ) async {
    emit(CharactersLoading());
    try {
      final results = await searchCharacters(event.query);
      if (results.isEmpty) {
        emit(CharactersEmpty());
      } else {
        emit(CharactersLoaded(results));
      }
    } catch (e) {
      emit(CharactersError(e.toString()));
    }
  }

  Future _onLoadCharacterById(
    LoadCharacterById event,
    Emitter<CharactersState> emit,
  ) async {
    emit(CharactersLoading());
    try {
      final character = await getCharacter(event.id);
      if (character == null) {
        emit(CharactersEmpty());
      } else {
        emit(CharacterLoaded(character));
      }
    } catch (e) {
      emit(CharactersError(e.toString()));
    }
  }
}
