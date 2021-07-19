import 'package:freezed_annotation/freezed_annotation.dart';

part 'genshin_data_model.freezed.dart';
part 'genshin_data_model.g.dart';

@freezed
class ApiRootResponse with _$ApiRootResponse {
  const factory ApiRootResponse({
    List<String>? types,
  }) = _ApiRootResponse;

  factory ApiRootResponse.fromJson(Map<String, dynamic> json) =>
      _$ApiRootResponseFromJson(json);
}

@freezed
class CharacterModel with _$CharacterModel {
  const factory CharacterModel({
    String? name,
    String? urlName,
    String? vision,
    String? weapon,
    String? nation,
    String? affiliation,
    int? rarity,
    String? constellation,
    String? birthday,
    String? description,
    List<SkillTalentsModel>? skillTalents,
    List<PassiveTalentsAndConstellationsModel>? passiveTalents,
    List<PassiveTalentsAndConstellationsModel>? constellations,
  }) = _CharacterModel;

  factory CharacterModel.fromJson(Map<String, dynamic> json) =>
      _$CharacterModelFromJson(json);
}

@freezed
class SkillTalentsModel with _$SkillTalentsModel {
  const factory SkillTalentsModel({
    String? name,
    String? unlock,
    String? description,
    String? type,
    List<UpgradeSkillsModel>? upgrades,
  }) = _SkillTalentsModel;

  factory SkillTalentsModel.fromJson(Map<String, dynamic> json) =>
      _$SkillTalentsModelFromJson(json);
}

@freezed
class UpgradeSkillsModel with _$UpgradeSkillsModel {
  const factory UpgradeSkillsModel({
    String? name,
    String? value,
  }) = _UpgradeSkillsModel;

  factory UpgradeSkillsModel.fromJson(Map<String, dynamic> json) =>
      _$UpgradeSkillsModelFromJson(json);
}

@freezed
class PassiveTalentsAndConstellationsModel
    with _$PassiveTalentsAndConstellationsModel {
  const factory PassiveTalentsAndConstellationsModel({
    String? name,
    String? unlock,
    String? description,
    int? level,
  }) = _PassiveTalentsAndConstellationsModel;

  factory PassiveTalentsAndConstellationsModel.fromJson(
          Map<String, dynamic> json) =>
      _$PassiveTalentsAndConstellationsModelFromJson(json);
}
