import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_mvvm/core/failure/failure.dart';
import 'package:test_mvvm/core/service/api_request_service.dart';
import 'package:test_mvvm/features/number_trivia/model/number_trivia_model.dart';

part 'number_trivia_remote_repository.g.dart';

@riverpod
NumberTriviaRemoteRepository numberTriviaRemoteRepository(Ref ref) => NumberTriviaRemoteRepository();

class NumberTriviaRemoteRepository {
  final ApiRequestService _apiRequestService = ApiRequestService();

  Future<Either<Failure, NumberTriviaModel>> getConcreteNumberTrivia(int number) async {
    try {
      final response = await _apiRequestService.get(
        'http://numbersapi.com/$number',
      );

      final result = response.data;

      if (response.statusCode != 200) {
        return Left(
          ServerFailure(
            statusCode: response.statusCode,
            message: result['message']
          )
        );
      }

      return Right(NumberTriviaModel.fromJson(response.data));
    } catch (e) {
      return Left(AppFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, NumberTriviaModel>> getRandomNumberTrivia() async {
    try {
      final response = await _apiRequestService.get(
        'http://numbersapi.com/random',
      );

      final result = response.data;

      if (response.statusCode != 200) {
        return Left(
          ServerFailure(
            statusCode: response.statusCode,
            message: result['message']
          )
        );
      }

      return Right(NumberTriviaModel.fromJson(response.data));
    } catch (e) {
      return Left(AppFailure(message: e.toString()));
    }
  }
}