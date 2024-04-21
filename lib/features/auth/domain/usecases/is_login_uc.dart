import 'package:dartz/dartz.dart';
import 'package:live_football_stats/core/error/failures.dart';
import 'package:live_football_stats/features/auth/domain/repositories/auth_repositories.dart';

class IsLoginUseCase {
  final AuthRepositories authRepositories;
  IsLoginUseCase(this.authRepositories);
  Future<Either<Failure, bool>?> call() {
    return authRepositories.isLogin();
  }
}
