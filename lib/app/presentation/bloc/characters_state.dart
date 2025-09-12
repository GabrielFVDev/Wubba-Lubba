import 'package:equatable/equatable.dart';
import 'package:wubba_lubba/app/domain/domain.dart';

abstract class CharactersState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CharactersInitial extends CharactersState {}

class CharactersEmpty extends CharactersState {}

class CharactersError extends CharactersState {
  final String message;

  CharactersError(this.message);

  @override
  List<Object?> get props => [message];
}

class CharactersLoading extends CharactersState {}

class CharacterLoaded extends CharactersState {
  final CharacterEntity character;

  CharacterLoaded(this.character);

  @override
  List<Object?> get props => [character];
}

class CharactersLoaded extends CharactersState {
  final List<CharacterEntity> characters;

  CharactersLoaded(this.characters);

  @override
  List<Object?> get props => [characters];
}
