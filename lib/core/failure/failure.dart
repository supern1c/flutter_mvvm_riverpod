abstract class Failure {
  final String message;
  final int? statusCode;

  const Failure({this.message = 'Sorry, an unexpected error occurred!', this.statusCode});
}

class AppFailure extends Failure {
  const AppFailure({super.message});
}

class ServerFailure extends Failure {
  const ServerFailure({super.message, super.statusCode});
}

class CacheFailure extends Failure {
  const CacheFailure({super.message, super.statusCode});
}

class NetworkFailure extends Failure {
  const NetworkFailure({super.message, super.statusCode});
}

class DatabaseFailure extends Failure {
  const DatabaseFailure({super.message});
}