import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/user_entity.dart';

abstract class AuthRepositories {
  Future<Either<Failure, bool>?> signOut();
  Future<Either<Failure, bool>?> signInWithGoogle();
  Future<Either<Failure, bool>?> signInWithFacebook();
  Future<Either<Failure, String?>?> signInWithPhone(String phone);
  Stream<UserEntity?> getCurrentUser();
  Future<Either<Failure, bool>?> getUpdateUser(UserEntity userEntity);
  Future<Either<Failure, bool>?> isLogin();
  Future<Either<Failure, void>?> verifyOTP(
      String verificationId, String userOtp);
  Future<UserEntity?> getUser();
}
