part of 'genshin_data_bloc.dart';

@freezed
class GenshinDataEvent with _$GenshinDataEvent {
  const factory GenshinDataEvent.getCharacterList() = GetCharacterList;
  const factory GenshinDataEvent.getAllCharacterDetail({
    required List<dynamic> characterNameList,
  }) = GetAllCharacterDetail;
  const factory GenshinDataEvent.getSelectedCharacterDetail({
    required CharacterModel selectedCharacterDetail,
  }) = GetSelectedCharacterDetail;
}
