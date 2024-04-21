import 'package:dartz/dartz.dart';
import 'package:live_football_stats/core/error/failures.dart';
import 'package:live_football_stats/features/auth/domain/repositories/auth_repositories.dart';

class SignInWithPhoneUseCase {
  final AuthRepositories authRepositories;
  SignInWithPhoneUseCase(this.authRepositories);
  Future<Either<Failure, bool>?> call(String phone) {
    return authRepositories.signInWithPhone(phone);
  }
}
