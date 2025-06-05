// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'phrase.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Phrase {
  String get phrase;
  String get meaning;
  String get example1;
  String get example2;

  /// Create a copy of Phrase
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PhraseCopyWith<Phrase> get copyWith =>
      _$PhraseCopyWithImpl<Phrase>(this as Phrase, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Phrase &&
            (identical(other.phrase, phrase) || other.phrase == phrase) &&
            (identical(other.meaning, meaning) || other.meaning == meaning) &&
            (identical(other.example1, example1) ||
                other.example1 == example1) &&
            (identical(other.example2, example2) ||
                other.example2 == example2));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, phrase, meaning, example1, example2);

  @override
  String toString() {
    return 'Phrase(phrase: $phrase, meaning: $meaning, example1: $example1, example2: $example2)';
  }
}

/// @nodoc
abstract mixin class $PhraseCopyWith<$Res> {
  factory $PhraseCopyWith(Phrase value, $Res Function(Phrase) _then) =
      _$PhraseCopyWithImpl;
  @useResult
  $Res call({String phrase, String meaning, String example1, String example2});
}

/// @nodoc
class _$PhraseCopyWithImpl<$Res> implements $PhraseCopyWith<$Res> {
  _$PhraseCopyWithImpl(this._self, this._then);

  final Phrase _self;
  final $Res Function(Phrase) _then;

  /// Create a copy of Phrase
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phrase = null,
    Object? meaning = null,
    Object? example1 = null,
    Object? example2 = null,
  }) {
    return _then(_self.copyWith(
      phrase: null == phrase
          ? _self.phrase
          : phrase // ignore: cast_nullable_to_non_nullable
              as String,
      meaning: null == meaning
          ? _self.meaning
          : meaning // ignore: cast_nullable_to_non_nullable
              as String,
      example1: null == example1
          ? _self.example1
          : example1 // ignore: cast_nullable_to_non_nullable
              as String,
      example2: null == example2
          ? _self.example2
          : example2 // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _Phrase implements Phrase {
  const _Phrase(
      {required this.phrase,
      required this.meaning,
      required this.example1,
      required this.example2});

  @override
  final String phrase;
  @override
  final String meaning;
  @override
  final String example1;
  @override
  final String example2;

  /// Create a copy of Phrase
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PhraseCopyWith<_Phrase> get copyWith =>
      __$PhraseCopyWithImpl<_Phrase>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Phrase &&
            (identical(other.phrase, phrase) || other.phrase == phrase) &&
            (identical(other.meaning, meaning) || other.meaning == meaning) &&
            (identical(other.example1, example1) ||
                other.example1 == example1) &&
            (identical(other.example2, example2) ||
                other.example2 == example2));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, phrase, meaning, example1, example2);

  @override
  String toString() {
    return 'Phrase(phrase: $phrase, meaning: $meaning, example1: $example1, example2: $example2)';
  }
}

/// @nodoc
abstract mixin class _$PhraseCopyWith<$Res> implements $PhraseCopyWith<$Res> {
  factory _$PhraseCopyWith(_Phrase value, $Res Function(_Phrase) _then) =
      __$PhraseCopyWithImpl;
  @override
  @useResult
  $Res call({String phrase, String meaning, String example1, String example2});
}

/// @nodoc
class __$PhraseCopyWithImpl<$Res> implements _$PhraseCopyWith<$Res> {
  __$PhraseCopyWithImpl(this._self, this._then);

  final _Phrase _self;
  final $Res Function(_Phrase) _then;

  /// Create a copy of Phrase
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? phrase = null,
    Object? meaning = null,
    Object? example1 = null,
    Object? example2 = null,
  }) {
    return _then(_Phrase(
      phrase: null == phrase
          ? _self.phrase
          : phrase // ignore: cast_nullable_to_non_nullable
              as String,
      meaning: null == meaning
          ? _self.meaning
          : meaning // ignore: cast_nullable_to_non_nullable
              as String,
      example1: null == example1
          ? _self.example1
          : example1 // ignore: cast_nullable_to_non_nullable
              as String,
      example2: null == example2
          ? _self.example2
          : example2 // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
