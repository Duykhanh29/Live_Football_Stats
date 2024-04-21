import 'package:dartz/dartz.dart';
import 'package:live_football_stats/core/error/failures.dart';
import 'package:live_football_stats/features/auth/domain/repositories/auth_repositories.dart';

class SignInWithGoogleUseCase {
  final AuthRepositories authRepositories;
  SignInWithGoogleUseCase(this.authRepositories);
  Future<Either<Failure, bool>?> call() {
    return authRepositories.signInWithGoogle();
  }
}
