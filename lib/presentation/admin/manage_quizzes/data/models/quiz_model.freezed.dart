// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quiz_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$QuizModel {
  String get id;
  String get title;
  List<QuestionModel> get questions;

  /// Create a copy of QuizModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $QuizModelCopyWith<QuizModel> get copyWith =>
      _$QuizModelCopyWithImpl<QuizModel>(this as QuizModel, _$identity);

  /// Serializes this QuizModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is QuizModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            const DeepCollectionEquality().equals(other.questions, questions));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, title, const DeepCollectionEquality().hash(questions));

  @override
  String toString() {
    return 'QuizModel(id: $id, title: $title, questions: $questions)';
  }
}

/// @nodoc
abstract mixin class $QuizModelCopyWith<$Res> {
  factory $QuizModelCopyWith(QuizModel value, $Res Function(QuizModel) _then) =
      _$QuizModelCopyWithImpl;
  @useResult
  $Res call({String id, String title, List<QuestionModel> questions});
}

/// @nodoc
class _$QuizModelCopyWithImpl<$Res> implements $QuizModelCopyWith<$Res> {
  _$QuizModelCopyWithImpl(this._self, this._then);

  final QuizModel _self;
  final $Res Function(QuizModel) _then;

  /// Create a copy of QuizModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? questions = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      questions: null == questions
          ? _self.questions
          : questions // ignore: cast_nullable_to_non_nullable
              as List<QuestionModel>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _QuizModel extends QuizModel {
  const _QuizModel(
      {required this.id,
      required this.title,
      required final List<QuestionModel> questions})
      : _questions = questions,
        super._();
  factory _QuizModel.fromJson(Map<String, dynamic> json) =>
      _$QuizModelFromJson(json);

  @override
  final String id;
  @override
  final String title;
  final List<QuestionModel> _questions;
  @override
  List<QuestionModel> get questions {
    if (_questions is EqualUnmodifiableListView) return _questions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_questions);
  }

  /// Create a copy of QuizModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$QuizModelCopyWith<_QuizModel> get copyWith =>
      __$QuizModelCopyWithImpl<_QuizModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$QuizModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _QuizModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            const DeepCollectionEquality()
                .equals(other._questions, _questions));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, title, const DeepCollectionEquality().hash(_questions));

  @override
  String toString() {
    return 'QuizModel(id: $id, title: $title, questions: $questions)';
  }
}

/// @nodoc
abstract mixin class _$QuizModelCopyWith<$Res>
    implements $QuizModelCopyWith<$Res> {
  factory _$QuizModelCopyWith(
          _QuizModel value, $Res Function(_QuizModel) _then) =
      __$QuizModelCopyWithImpl;
  @override
  @useResult
  $Res call({String id, String title, List<QuestionModel> questions});
}

/// @nodoc
class __$QuizModelCopyWithImpl<$Res> implements _$QuizModelCopyWith<$Res> {
  __$QuizModelCopyWithImpl(this._self, this._then);

  final _QuizModel _self;
  final $Res Function(_QuizModel) _then;

  /// Create a copy of QuizModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? questions = null,
  }) {
    return _then(_QuizModel(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      questions: null == questions
          ? _self._questions
          : questions // ignore: cast_nullable_to_non_nullable
              as List<QuestionModel>,
    ));
  }
}

// dart format on
