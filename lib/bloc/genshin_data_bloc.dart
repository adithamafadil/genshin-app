import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geshin_app/data/configurations/fetch_state/fetch_state.dart';
import 'package:geshin_app/data/models/genshin_data_model.dart';
import 'package:geshin_app/data/remotes/genshin_data_remote.dart';
import 'package:injectable/injectable.dart';

part 'genshin_data_event.dart';
part 'genshin_data_state.dart';
part 'genshin_data_bloc.freezed.dart';

@lazySingleton
class GenshinDataBloc extends Bloc<GenshinDataEvent, GenshinDataState> {
  final GenshinDataRemote _genshinDataRemote;
  GenshinDataBloc(this._genshinDataRemote) : super(GenshinDataState.initial()) {
    add(const GenshinDataEvent.getCharacterList());
  }

  @override
  Stream<GenshinDataState> mapEventToState(
    GenshinDataEvent event,
  ) async* {
    yield* event.map(getAllCharacterDetail: (GetAllCharacterDetail e) async* {
      yield* _handleGetAllCharacterDetail(e);
    }, getCharacterList: (GetCharacterList e) async* {
      yield* _handleGetCharacterList(e);
    }, getSelectedCharacterDetail: (GetSelectedCharacterDetail e) async* {
      yield* _handleGetSelectedCharacterDetail(e);
    });
  }

  Stream<GenshinDataState> _handleGetAllCharacterDetail(
      GetAllCharacterDetail e) async* {
    yield state.copyWith(fetchState: const FetchState.loading());
    List<CharacterModel> characterDetailList = [];

    for (String characterName in e.characterNameList) {
      var response = await _genshinDataRemote.getCharacterDetail(
        characterName: characterName,
      );

      characterDetailList.add(response.copyWith(urlName: characterName));
    }

    yield state.copyWith(
      fetchState: const FetchState.success(),
      characterDetailList: characterDetailList,
    );
  }

  Stream<GenshinDataState> _handleGetCharacterList(GetCharacterList e) async* {
    var response = await _genshinDataRemote.getCharacterList();

    if (response.isNotEmpty) {
      yield state.copyWith(
        characterList: response,
      );
      add(GenshinDataEvent.getAllCharacterDetail(characterNameList: response));
    } else {
      yield state.copyWith(
        characterList: [],
      );
    }
  }

  Stream<GenshinDataState> _handleGetSelectedCharacterDetail(
      GetSelectedCharacterDetail e) async* {
    state.copyWith(selectedCharacterDetail: e.selectedCharacterDetail);
  }
}
