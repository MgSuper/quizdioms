import 'package:freezed_annotation/freezed_annotation.dart';

part 'phrase.freezed.dart';

@freezed
abstract class Phrase with _$Phrase {
  const factory Phrase({
    required String phrase,
    required String meaning,
    required String example1,
    required String example2,
  }) = _Phrase;
}
