import 'package:freezed_annotation/freezed_annotation.dart';
import 'phrase.dart';

part 'phrase_group.freezed.dart';

@freezed
abstract class PhraseGroup with _$PhraseGroup {
  const factory PhraseGroup({
    required String id,
    required String groupName,
    required List<Phrase> phrases,
    required DateTime createdAt,
  }) = _PhraseGroup;
}
