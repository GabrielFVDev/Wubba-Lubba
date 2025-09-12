import 'package:equatable/equatable.dart';

abstract class CharactersEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadCharacters extends CharactersEvent {}

class RefreshCharacters extends CharactersEvent {}

class LoadCharacterById extends CharactersEvent {
  final int id;
  LoadCharacterById(this.id);
  @override
  List<Object?> get props => [id];
}

class SearchCharacters extends CharactersEvent {
  final String query;
  SearchCharacters(this.query);
  @override
  List<Object?> get props => [query];
}
