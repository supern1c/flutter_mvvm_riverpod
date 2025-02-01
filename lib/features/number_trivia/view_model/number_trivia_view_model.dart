import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_mvvm/features/number_trivia/model/number_trivia_model.dart';
import 'package:test_mvvm/features/number_trivia/repository/number_trivia_remote_repository.dart';

part 'number_trivia_view_model.g.dart';

@riverpod
class NumberTriviaViewModel extends _$NumberTriviaViewModel {
  late final NumberTriviaRemoteRepository _numberTriviaRemoteRepository;

  @override
  FutureOr<NumberTriviaModel?> build() {
    _numberTriviaRemoteRepository = ref.watch(numberTriviaRemoteRepositoryProvider);
    return null;
  }

  Future<void> getConcreteNumberTrivia(int number) async {
    state = const AsyncLoading();
    final result =
        await _numberTriviaRemoteRepository.getConcreteNumberTrivia(number);
    result.fold(
      (l) => state = AsyncValue.error(l, StackTrace.current),
      (r) => state = AsyncValue.data(r)
    );
  }

  Future<void> getRandomNumberTrivia() async {
    state = const AsyncLoading();
    final result = await _numberTriviaRemoteRepository.getRandomNumberTrivia();
    result.fold(
      (l) => state = AsyncValue.error(l, StackTrace.current),
      (r) => state = AsyncValue.data(r)
    );
  }
}
