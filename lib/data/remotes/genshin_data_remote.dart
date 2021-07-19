import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:geshin_app/data/configurations/api/api_config.dart';
import 'package:geshin_app/data/models/genshin_data_model.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

@lazySingleton
class GenshinDataRemote {
  final http.Client _client;

  GenshinDataRemote(this._client);

  Future<ApiRootResponse> getApiRootResponse() async {
    try {
      String url = apiUrl;
      var response = await _client.get(Uri.parse(url));

      if (response.statusCode == 200) {
        return ApiRootResponse.fromJson(json.decode(response.body));
      } else {
        return const ApiRootResponse();
      }
    } catch (e) {
      return const ApiRootResponse();
    }
  }

  Future<List<dynamic>> getCharacterList() async {
    List<dynamic> _characterList = [];
    try {
      String url = '$apiUrl/characters';
      http.Response response = await _client.get(Uri.parse(url));

      if (response.statusCode == 200) {
        _characterList = json.decode(response.body);
        return _characterList;
      } else {
        log('Error Code: ${response.statusCode} caused: ${response.reasonPhrase}');
        return _characterList;
      }
    } on TimeoutException catch (e, stack) {
      log('Timeout Exeption: $e on stack $stack');
      return _characterList;
    } on SocketException catch (e, stack) {
      log('Socket Exeption: $e on stack $stack');
      return _characterList;
    } catch (e, stack) {
      log('Other Exeption: $e on stack $stack');
      return _characterList;
    }
  }

  Future<CharacterModel> getCharacterDetail({
    required String characterName,
  }) async {
    try {
      String url = '$apiUrl/characters/$characterName';
      http.Response response = await _client.get(Uri.parse(url));

      if (response.statusCode == 200) {
        return CharacterModel.fromJson(json.decode(response.body));
      } else {
        log('Error Code: ${response.statusCode} caused: ${response.reasonPhrase}');
        return const CharacterModel();
      }
    } on TimeoutException catch (e, stack) {
      log('Timeout Exeption: $e on stack $stack');
      return const CharacterModel();
    } on SocketException catch (e, stack) {
      log('Socket Exeption: $e on stack $stack');
      return const CharacterModel();
    } catch (e, stack) {
      log('Other Exeption: $e on stack $stack');
      return const CharacterModel();
    }
  }
}
