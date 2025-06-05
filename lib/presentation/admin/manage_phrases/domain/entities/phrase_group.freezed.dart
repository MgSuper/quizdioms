// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'phrase_group.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PhraseGroup {
  String get id;
  String get groupName;
  List<Phrase> get phrases;
  DateTime get createdAt;

  /// Create a copy of PhraseGroup
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PhraseGroupCopyWith<PhraseGroup> get copyWith =>
      _$PhraseGroupCopyWithImpl<PhraseGroup>(this as PhraseGroup, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PhraseGroup &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.groupName, groupName) ||
                other.groupName == groupName) &&
            const DeepCollectionEquality().equals(other.phrases, phrases) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, groupName,
      const DeepCollectionEquality().hash(phrases), createdAt);

  @override
  String toString() {
    return 'PhraseGroup(id: $id, groupName: $groupName, phrases: $phrases, createdAt: $createdAt)';
  }
}

/// @nodoc
abstract mixin class $PhraseGroupCopyWith<$Res> {
  factory $PhraseGroupCopyWith(
          PhraseGroup value, $Res Function(PhraseGroup) _then) =
      _$PhraseGroupCopyWithImpl;
  @useResult
  $Res call(
      {String id, String groupName, List<Phrase> phrases, DateTime createdAt});
}

/// @nodoc
class _$PhraseGroupCopyWithImpl<$Res> implements $PhraseGroupCopyWith<$Res> {
  _$PhraseGroupCopyWithImpl(this._self, this._then);

  final PhraseGroup _self;
  final $Res Function(PhraseGroup) _then;

  /// Create a copy of PhraseGroup
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? groupName = null,
    Object? phrases = null,
    Object? createdAt = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      groupName: null == groupName
          ? _self.groupName
          : groupName // ignore: cast_nullable_to_non_nullable
              as String,
      phrases: null == phrases
          ? _self.phrases
          : phrases // ignore: cast_nullable_to_non_nullable
              as List<Phrase>,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

class _PhraseGroup implements PhraseGroup {
  const _PhraseGroup(
      {required this.id,
      required this.groupName,
      required final List<Phrase> phrases,
      required this.createdAt})
      : _phrases = phrases;

  @override
  final String id;
  @override
  final String groupName;
  final List<Phrase> _phrases;
  @override
  List<Phrase> get phrases {
    if (_phrases is EqualUnmodifiableListView) return _phrases;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_phrases);
  }

  @override
  final DateTime createdAt;

  /// Create a copy of PhraseGroup
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PhraseGroupCopyWith<_PhraseGroup> get copyWith =>
      __$PhraseGroupCopyWithImpl<_PhraseGroup>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PhraseGroup &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.groupName, groupName) ||
                other.groupName == groupName) &&
            const DeepCollectionEquality().equals(other._phrases, _phrases) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, groupName,
      const DeepCollectionEquality().hash(_phrases), createdAt);

  @override
  String toString() {
    return 'PhraseGroup(id: $id, groupName: $groupName, phrases: $phrases, createdAt: $createdAt)';
  }
}

/// @nodoc
abstract mixin class _$PhraseGroupCopyWith<$Res>
    implements $PhraseGroupCopyWith<$Res> {
  factory _$PhraseGroupCopyWith(
          _PhraseGroup value, $Res Function(_PhraseGroup) _then) =
      __$PhraseGroupCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id, String groupName, List<Phrase> phrases, DateTime createdAt});
}

/// @nodoc
class __$PhraseGroupCopyWithImpl<$Res> implements _$PhraseGroupCopyWith<$Res> {
  __$PhraseGroupCopyWithImpl(this._self, this._then);

  final _PhraseGroup _self;
  final $Res Function(_PhraseGroup) _then;

  /// Create a copy of PhraseGroup
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? groupName = null,
    Object? phrases = null,
    Object? createdAt = null,
  }) {
    return _then(_PhraseGroup(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      groupName: null == groupName
          ? _self.groupName
          : groupName // ignore: cast_nullable_to_non_nullable
              as String,
      phrases: null == phrases
          ? _self._phrases
          : phrases // ignore: cast_nullable_to_non_nullable
              as List<Phrase>,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

// dart format on
