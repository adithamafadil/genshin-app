part of 'genshin_data_bloc.dart';

@freezed
class GenshinDataState with _$GenshinDataState {
  const factory GenshinDataState({
    // Fetch State
    required FetchState fetchState,

    //Data
    required List<dynamic> characterList,
    required List<CharacterModel> characterDetailList,
    required CharacterModel selectedCharacterDetail,
  }) = _GenshinDataState;
  factory GenshinDataState.initial() => const GenshinDataState(
        fetchState: FetchState.loading(),
        selectedCharacterDetail: CharacterModel(),
        characterDetailList: [],
        characterList: <String>[],
      );
}
