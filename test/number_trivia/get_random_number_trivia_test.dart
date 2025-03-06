library get_random_number_trivia_test;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test_mvvm/core/failure/failure.dart';
import 'package:test_mvvm/features/number_trivia/model/number_trivia_model.dart';
import 'package:test_mvvm/features/number_trivia/repository/number_trivia_remote_repository.dart';
import 'package:test_mvvm/features/number_trivia/view_model/number_trivia_view_model.dart';

class MockNumberTriviaRemoteRepository extends Mock implements NumberTriviaRemoteRepository {}

class Listener<T> extends Mock {
  void call(T? previous, T next);
}

void main() {
  ProviderContainer makeProviderContainer(MockNumberTriviaRemoteRepository numberTriviaRepository) {
    final container = ProviderContainer(
        overrides: [
          numberTriviaRemoteRepositoryProvider.overrideWithValue(numberTriviaRepository)
        ]
    );
    addTearDown(container.dispose);
    return container;
  }

  setUpAll(() {
    registerFallbackValue(const AsyncLoading<NumberTriviaModel?>());
  });

  group('initialization', () {
    test('initial state is AsyncData', () {
      final repo = MockNumberTriviaRemoteRepository();
      final container = makeProviderContainer(repo);
      final listener = Listener<AsyncValue<void>>();
      container.listen(
        numberTriviaViewModelProvider,
        listener.call,
        fireImmediately: true,
      );
      // verify
      verify(
              () => listener(null, const AsyncData<NumberTriviaModel?>(null))
      );
      verifyNoMoreInteractions(listener);
      verifyNever(repo.getRandomNumberTrivia);
      verifyNever(() => repo.getConcreteNumberTrivia(1));
    });
  });

  group('get random number trivia', () {
    test('get number trivia success', () async {
      final repo = MockNumberTriviaRemoteRepository();
      when(repo.getRandomNumberTrivia).thenAnswer((_) => Future.value(Right(NumberTriviaModel(number: 1, text: 'test'))));

      final container = makeProviderContainer(repo);
      final listener = Listener<AsyncValue<void>>();

      container.listen(
          numberTriviaViewModelProvider,
          listener.call,
          fireImmediately: true
      );

      const data = AsyncData<NumberTriviaModel?>(null);
      verify(() => listener(null, data));

      final viewModel = container.read(numberTriviaViewModelProvider.notifier);
      await viewModel.getRandomNumberTrivia();

      verifyInOrder([
            () => listener(any(that: isA<AsyncData<NumberTriviaModel?>>()), any(that: isA<AsyncLoading<NumberTriviaModel?>>())),
            () => listener(any(that: isA<AsyncLoading<NumberTriviaModel?>>()), any(that: isA<AsyncData<NumberTriviaModel?>>())),
      ]);

      verifyNoMoreInteractions(listener);
      verify(repo.getRandomNumberTrivia).called(1);
    });

    test('get number trivia failed', () async {
      final repo = MockNumberTriviaRemoteRepository();
      when(repo.getRandomNumberTrivia).thenAnswer((_) => Future.value(const Left(AppFailure(message: 'error'))));

      final container = makeProviderContainer(repo);
      final listener = Listener<AsyncValue<void>>();

      container.listen(
          numberTriviaViewModelProvider,
          listener.call,
          fireImmediately: true
      );

      const data = AsyncData<NumberTriviaModel?>(null);
      Matcher matcherData = isA<AsyncData<NumberTriviaModel?>>();
      verify(() => listener(null, data));

      final viewModel = container.read(numberTriviaViewModelProvider.notifier);
      await viewModel.getRandomNumberTrivia();

      verifyInOrder([
            () => listener(any(that: matcherData), any(that: isA<AsyncLoading<NumberTriviaModel?>>())),
            () => listener(any(that: isA<AsyncLoading<NumberTriviaModel?>>()), any(that: isA<AsyncError>())),
      ]);

      verifyNoMoreInteractions(listener);
      verify(repo.getRandomNumberTrivia).called(1);
    });
  });
}