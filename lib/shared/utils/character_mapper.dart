import 'package:wubba_lubba/app/data/models/character_model.dart';
import 'package:wubba_lubba/app/domain/entities/character_entity.dart';

/// Extension to convert [CharacterModel] (data) to [CharacterEntity] (domain).
extension CharacterModelMapper on CharacterModel {
  CharacterEntity toEntity() {
    return CharacterEntity(
      id: id,
      name: name,
      status: status,
      species: species,
      type: type,
      gender: gender,
      origin: origin,
      location: location,
      image: image,
      created: created,
    );
  }
}

/// Helper for mapping a list of models to entities.
List<CharacterEntity> mapModelsToEntities(List<CharacterModel> models) {
  return models.map((m) => m.toEntity()).toList();
}
