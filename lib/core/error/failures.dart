import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  String? message;
  Failure({required this.message});
  @override
  List<Object> get props => [message!];
}

// General failures
class ServerFailure extends Failure {
  ServerFailure({super.message});
}

class TooManyRequestsFailure extends Failure {
  TooManyRequestsFailure({super.message});
}

class CacheFailure extends Failure {
  CacheFailure({super.message});
}

class NetworkFailure extends Failure {
  NetworkFailure({super.message});
}

class ExceptionFailure extends Failure {
  ExceptionFailure({super.message});
}

class CredentialFailure extends Failure {
  CredentialFailure({super.message});
}

class AuthenticationFailure extends Failure {
  AuthenticationFailure({super.message});
}
