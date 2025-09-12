import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wubba_lubba/app/domain/domain.dart';
import 'package:wubba_lubba/app/presentation/presentation.dart';

class CharactersBloc extends Bloc<CharactersEvent, CharactersState> {
  final GetAllCharactersUseCase getAllUseCase;
  final GetCharacterUseCase getCharacterUseCase;
  final RefreshSearchUseCase refreshSearchUseCase;
  final SearchCharactersUseCase searchCharactersUseCase;

  CharactersBloc({
    required this.getAllUseCase,
    required this.getCharacterUseCase,
    required this.refreshSearchUseCase,
    required this.searchCharactersUseCase,
  }) : super(CharactersInitial()) {
    on<LoadCharacters>(_onLoadCharacters);
    on<RefreshCharacters>(_onRefresh);
    on<SearchCharacters>(_onSearch);
    on<LoadCharacterById>(_onLoadCharacterById);
  }

  Future _onLoadCharacters(
    LoadCharacters event,
    Emitter<CharactersState> emit,
  ) async {
    emit(CharactersLoading());
    try {
      final listCharacters = await getAllUseCase();
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
      await refreshSearchUseCase();
      final list = await getAllUseCase();
      if (list.isEmpty) {
        emit(CharactersEmpty());
      } else {
        emit(CharactersLoaded(list));
      }
    } catch (e) {
      emit(CharactersError(e.toString()));
    }
  }

  Future _onSearch(
    SearchCharacters event,
    Emitter<CharactersState> emit,
  ) async {
    emit(CharactersLoading());
    try {
      final results = await searchCharactersUseCase(event.query);
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
      final character = await getCharacterUseCase(event.id);
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
