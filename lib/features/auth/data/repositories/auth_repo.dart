import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:live_football_stats/core/error/failures.dart';
import 'package:live_football_stats/features/auth/domain/entities/user_entity.dart';
import 'package:live_football_stats/features/auth/domain/repositories/auth_repositories.dart';

import '../data_source/remote/auth_remote_data_source.dart';

class AuthRepoImpl extends AuthRepositories {
  final AuthRemoteDataSource authRemoteDataSource;
  AuthRepoImpl({required this.authRemoteDataSource});
  @override
  Stream<UserEntity?> getCurrentUser() async* {
    StreamController<UserEntity?> streamController =
        StreamController<UserEntity>();
    final data = authRemoteDataSource.currentUser;
    StreamSubscription streamSubscription = data.listen((event) {
      UserEntity? userEntity = event?.toEntity();
      streamController.sink.add(userEntity);
    });
    streamController.onCancel = () {
      streamSubscription.cancel();
      streamController.close();
    };
    yield* streamController.stream;
  }

  @override
  Future<Either<Failure, bool>?> getUpdateUser(UserEntity userEntity) async {
    try {
      final result = await authRemoteDataSource.updateCurrentUser(userEntity);
      if (result) {
        return const Right(true);
      } else {
        return Left(ServerFailure(message: ""));
      }
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>?> signInWithFacebook() async {
    try {
      final result = await authRemoteDataSource.signInwithFacebook();
      if (result) {
        return const Right(true);
      } else {
        return Left(ServerFailure(message: ""));
      }
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>?> signInWithGoogle() async {
    try {
      final result = await authRemoteDataSource.signInWithGoogle();

      if (result) {
        return const Right(true);
      } else {
        return Left(ServerFailure(message: ""));
      }
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>?> signInWithPhone(String phone) async {
    try {
      final result = await authRemoteDataSource.singInWithPhone(phone);

      if (result) {
        return const Right(true);
      } else {
        return Left(ServerFailure(message: ""));
      }
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>?> signOut() async {
    try {
      final result = await authRemoteDataSource.signOut();
      if (result) {
        return const Right(true);
      } else {
        return Left(ServerFailure(message: ""));
      }
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>?> isLogin() async {
    try {
      final result = await authRemoteDataSource.isLogin;
      return Right(result!);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
