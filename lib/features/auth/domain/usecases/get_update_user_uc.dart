import 'package:dartz/dartz.dart';
import 'package:live_football_stats/core/error/failures.dart';
import 'package:live_football_stats/features/auth/domain/entities/user_entity.dart';
import 'package:live_football_stats/features/auth/domain/repositories/auth_repositories.dart';

class GetUpdateUserUseCase {
  final AuthRepositories authRepositories;
  GetUpdateUserUseCase(this.authRepositories);
  Future<Either<Failure, bool>?> call(UserEntity userEntity) {
    return authRepositories.getUpdateUser(userEntity);
  }
}
