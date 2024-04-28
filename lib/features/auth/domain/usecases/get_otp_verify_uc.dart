import 'package:dartz/dartz.dart';
import 'package:live_football_stats/core/error/failures.dart';
import 'package:live_football_stats/features/auth/domain/repositories/auth_repositories.dart';

class GetOTPVerifyUseCase {
  final AuthRepositories authRepositories;
  GetOTPVerifyUseCase(this.authRepositories);
  Future<Either<Failure, void>?> call(String verificationId, String userOtp) {
    return authRepositories.verifyOTP(verificationId, userOtp);
  }
}
