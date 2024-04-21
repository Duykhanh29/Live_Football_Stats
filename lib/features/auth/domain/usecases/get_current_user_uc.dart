import 'package:live_football_stats/features/auth/domain/entities/user_entity.dart';
import 'package:live_football_stats/features/auth/domain/repositories/auth_repositories.dart';

class GetCurrentUserUseCase {
  final AuthRepositories authRepositories;
  GetCurrentUserUseCase(this.authRepositories);
  Stream<UserEntity?> call() {
    return authRepositories.getCurrentUser();
  }
}
