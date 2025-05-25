// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'question_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$QuestionModel {
  String get question;
  List<String> get options;
  String get answer;

  /// Create a copy of QuestionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $QuestionModelCopyWith<QuestionModel> get copyWith =>
      _$QuestionModelCopyWithImpl<QuestionModel>(
          this as QuestionModel, _$identity);

  /// Serializes this QuestionModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is QuestionModel &&
            (identical(other.question, question) ||
                other.question == question) &&
            const DeepCollectionEquality().equals(other.options, options) &&
            (identical(other.answer, answer) || other.answer == answer));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, question,
      const DeepCollectionEquality().hash(options), answer);

  @override
  String toString() {
    return 'QuestionModel(question: $question, options: $options, answer: $answer)';
  }
}

/// @nodoc
abstract mixin class $QuestionModelCopyWith<$Res> {
  factory $QuestionModelCopyWith(
          QuestionModel value, $Res Function(QuestionModel) _then) =
      _$QuestionModelCopyWithImpl;
  @useResult
  $Res call({String question, List<String> options, String answer});
}

/// @nodoc
class _$QuestionModelCopyWithImpl<$Res>
    implements $QuestionModelCopyWith<$Res> {
  _$QuestionModelCopyWithImpl(this._self, this._then);

  final QuestionModel _self;
  final $Res Function(QuestionModel) _then;

  /// Create a copy of QuestionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? question = null,
    Object? options = null,
    Object? answer = null,
  }) {
    return _then(_self.copyWith(
      question: null == question
          ? _self.question
          : question // ignore: cast_nullable_to_non_nullable
              as String,
      options: null == options
          ? _self.options
          : options // ignore: cast_nullable_to_non_nullable
              as List<String>,
      answer: null == answer
          ? _self.answer
          : answer // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _QuestionModel extends QuestionModel {
  const _QuestionModel(
      {required this.question,
      required final List<String> options,
      required this.answer})
      : _options = options,
        super._();
  factory _QuestionModel.fromJson(Map<String, dynamic> json) =>
      _$QuestionModelFromJson(json);

  @override
  final String question;
  final List<String> _options;
  @override
  List<String> get options {
    if (_options is EqualUnmodifiableListView) return _options;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_options);
  }

  @override
  final String answer;

  /// Create a copy of QuestionModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$QuestionModelCopyWith<_QuestionModel> get copyWith =>
      __$QuestionModelCopyWithImpl<_QuestionModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$QuestionModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _QuestionModel &&
            (identical(other.question, question) ||
                other.question == question) &&
            const DeepCollectionEquality().equals(other._options, _options) &&
            (identical(other.answer, answer) || other.answer == answer));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, question,
      const DeepCollectionEquality().hash(_options), answer);

  @override
  String toString() {
    return 'QuestionModel(question: $question, options: $options, answer: $answer)';
  }
}

/// @nodoc
abstract mixin class _$QuestionModelCopyWith<$Res>
    implements $QuestionModelCopyWith<$Res> {
  factory _$QuestionModelCopyWith(
          _QuestionModel value, $Res Function(_QuestionModel) _then) =
      __$QuestionModelCopyWithImpl;
  @override
  @useResult
  $Res call({String question, List<String> options, String answer});
}

/// @nodoc
class __$QuestionModelCopyWithImpl<$Res>
    implements _$QuestionModelCopyWith<$Res> {
  __$QuestionModelCopyWithImpl(this._self, this._then);

  final _QuestionModel _self;
  final $Res Function(_QuestionModel) _then;

  /// Create a copy of QuestionModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? question = null,
    Object? options = null,
    Object? answer = null,
  }) {
    return _then(_QuestionModel(
      question: null == question
          ? _self.question
          : question // ignore: cast_nullable_to_non_nullable
              as String,
      options: null == options
          ? _self._options
          : options // ignore: cast_nullable_to_non_nullable
              as List<String>,
      answer: null == answer
          ? _self.answer
          : answer // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
