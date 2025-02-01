import 'package:freezed_annotation/freezed_annotation.dart';

part 'number_trivia_model.freezed.dart';
part 'number_trivia_model.g.dart';

@freezed
class NumberTriviaModel with _$NumberTriviaModel {
  factory NumberTriviaModel({
    @Default(0) int number,
    @Default('') String text,
    @Default('') String type,
    @Default(false) bool found,
  }) = _NumberTriviaModel;

  factory NumberTriviaModel.fromJson(Map<String, dynamic> json) =>
      _$NumberTriviaModelFromJson(json);
}