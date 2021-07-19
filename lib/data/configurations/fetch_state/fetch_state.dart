import 'package:freezed_annotation/freezed_annotation.dart';

part 'fetch_state.freezed.dart';

@freezed
class FetchState with _$FetchState {
  const factory FetchState.loading() = _Loading;
  const factory FetchState.success() = _Success;
  const factory FetchState.error() = _Error;
  const factory FetchState.connectionError() = _ConnectionError;
}
