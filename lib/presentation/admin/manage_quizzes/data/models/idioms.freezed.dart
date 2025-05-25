// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'idioms.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Idiom {
  String get text;
  String get meaning;
  String get usage;

  /// Create a copy of Idiom
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $IdiomCopyWith<Idiom> get copyWith =>
      _$IdiomCopyWithImpl<Idiom>(this as Idiom, _$identity);

  /// Serializes this Idiom to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Idiom &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.meaning, meaning) || other.meaning == meaning) &&
            (identical(other.usage, usage) || other.usage == usage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, text, meaning, usage);

  @override
  String toString() {
    return 'Idiom(text: $text, meaning: $meaning, usage: $usage)';
  }
}

/// @nodoc
abstract mixin class $IdiomCopyWith<$Res> {
  factory $IdiomCopyWith(Idiom value, $Res Function(Idiom) _then) =
      _$IdiomCopyWithImpl;
  @useResult
  $Res call({String text, String meaning, String usage});
}

/// @nodoc
class _$IdiomCopyWithImpl<$Res> implements $IdiomCopyWith<$Res> {
  _$IdiomCopyWithImpl(this._self, this._then);

  final Idiom _self;
  final $Res Function(Idiom) _then;

  /// Create a copy of Idiom
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = null,
    Object? meaning = null,
    Object? usage = null,
  }) {
    return _then(_self.copyWith(
      text: null == text
          ? _self.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      meaning: null == meaning
          ? _self.meaning
          : meaning // ignore: cast_nullable_to_non_nullable
              as String,
      usage: null == usage
          ? _self.usage
          : usage // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _Idiom implements Idiom {
  const _Idiom(
      {required this.text, required this.meaning, required this.usage});
  factory _Idiom.fromJson(Map<String, dynamic> json) => _$IdiomFromJson(json);

  @override
  final String text;
  @override
  final String meaning;
  @override
  final String usage;

  /// Create a copy of Idiom
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$IdiomCopyWith<_Idiom> get copyWith =>
      __$IdiomCopyWithImpl<_Idiom>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$IdiomToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Idiom &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.meaning, meaning) || other.meaning == meaning) &&
            (identical(other.usage, usage) || other.usage == usage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, text, meaning, usage);

  @override
  String toString() {
    return 'Idiom(text: $text, meaning: $meaning, usage: $usage)';
  }
}

/// @nodoc
abstract mixin class _$IdiomCopyWith<$Res> implements $IdiomCopyWith<$Res> {
  factory _$IdiomCopyWith(_Idiom value, $Res Function(_Idiom) _then) =
      __$IdiomCopyWithImpl;
  @override
  @useResult
  $Res call({String text, String meaning, String usage});
}

/// @nodoc
class __$IdiomCopyWithImpl<$Res> implements _$IdiomCopyWith<$Res> {
  __$IdiomCopyWithImpl(this._self, this._then);

  final _Idiom _self;
  final $Res Function(_Idiom) _then;

  /// Create a copy of Idiom
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? text = null,
    Object? meaning = null,
    Object? usage = null,
  }) {
    return _then(_Idiom(
      text: null == text
          ? _self.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      meaning: null == meaning
          ? _self.meaning
          : meaning // ignore: cast_nullable_to_non_nullable
              as String,
      usage: null == usage
          ? _self.usage
          : usage // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
mixin _$IdiomGroup {
  String get id;
  List<Idiom> get idioms;
  String get groupName;
  DateTime get createdAt;

  /// Create a copy of IdiomGroup
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $IdiomGroupCopyWith<IdiomGroup> get copyWith =>
      _$IdiomGroupCopyWithImpl<IdiomGroup>(this as IdiomGroup, _$identity);

  /// Serializes this IdiomGroup to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is IdiomGroup &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality().equals(other.idioms, idioms) &&
            (identical(other.groupName, groupName) ||
                other.groupName == groupName) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id,
      const DeepCollectionEquality().hash(idioms), groupName, createdAt);

  @override
  String toString() {
    return 'IdiomGroup(id: $id, idioms: $idioms, groupName: $groupName, createdAt: $createdAt)';
  }
}

/// @nodoc
abstract mixin class $IdiomGroupCopyWith<$Res> {
  factory $IdiomGroupCopyWith(
          IdiomGroup value, $Res Function(IdiomGroup) _then) =
      _$IdiomGroupCopyWithImpl;
  @useResult
  $Res call(
      {String id, List<Idiom> idioms, String groupName, DateTime createdAt});
}

/// @nodoc
class _$IdiomGroupCopyWithImpl<$Res> implements $IdiomGroupCopyWith<$Res> {
  _$IdiomGroupCopyWithImpl(this._self, this._then);

  final IdiomGroup _self;
  final $Res Function(IdiomGroup) _then;

  /// Create a copy of IdiomGroup
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? idioms = null,
    Object? groupName = null,
    Object? createdAt = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      idioms: null == idioms
          ? _self.idioms
          : idioms // ignore: cast_nullable_to_non_nullable
              as List<Idiom>,
      groupName: null == groupName
          ? _self.groupName
          : groupName // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _IdiomGroup implements IdiomGroup {
  const _IdiomGroup(
      {required this.id,
      required final List<Idiom> idioms,
      required this.groupName,
      required this.createdAt})
      : _idioms = idioms;
  factory _IdiomGroup.fromJson(Map<String, dynamic> json) =>
      _$IdiomGroupFromJson(json);

  @override
  final String id;
  final List<Idiom> _idioms;
  @override
  List<Idiom> get idioms {
    if (_idioms is EqualUnmodifiableListView) return _idioms;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_idioms);
  }

  @override
  final String groupName;
  @override
  final DateTime createdAt;

  /// Create a copy of IdiomGroup
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$IdiomGroupCopyWith<_IdiomGroup> get copyWith =>
      __$IdiomGroupCopyWithImpl<_IdiomGroup>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$IdiomGroupToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _IdiomGroup &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality().equals(other._idioms, _idioms) &&
            (identical(other.groupName, groupName) ||
                other.groupName == groupName) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id,
      const DeepCollectionEquality().hash(_idioms), groupName, createdAt);

  @override
  String toString() {
    return 'IdiomGroup(id: $id, idioms: $idioms, groupName: $groupName, createdAt: $createdAt)';
  }
}

/// @nodoc
abstract mixin class _$IdiomGroupCopyWith<$Res>
    implements $IdiomGroupCopyWith<$Res> {
  factory _$IdiomGroupCopyWith(
          _IdiomGroup value, $Res Function(_IdiomGroup) _then) =
      __$IdiomGroupCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id, List<Idiom> idioms, String groupName, DateTime createdAt});
}

/// @nodoc
class __$IdiomGroupCopyWithImpl<$Res> implements _$IdiomGroupCopyWith<$Res> {
  __$IdiomGroupCopyWithImpl(this._self, this._then);

  final _IdiomGroup _self;
  final $Res Function(_IdiomGroup) _then;

  /// Create a copy of IdiomGroup
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? idioms = null,
    Object? groupName = null,
    Object? createdAt = null,
  }) {
    return _then(_IdiomGroup(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      idioms: null == idioms
          ? _self._idioms
          : idioms // ignore: cast_nullable_to_non_nullable
              as List<Idiom>,
      groupName: null == groupName
          ? _self.groupName
          : groupName // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

// dart format on
