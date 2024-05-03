import 'package:live_football_stats/features/auth/domain/entities/user_entity.dart';

import '../repositories/auth_repositories.dart';

class GetUserUseCase {
  final AuthRepositories authRepositories;
  GetUserUseCase(this.authRepositories);
  Future<UserEntity?> call() {
    return authRepositories.getUser();
  }
}
