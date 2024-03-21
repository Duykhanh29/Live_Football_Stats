import 'package:dartz/dartz.dart';
import 'package:live_football_stats/core/error/failures.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/player.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/team.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/transfer.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/stadium.dart';

abstract class TeamRepositories {
  Future<Either<Failure, Team>?> getTeamByID(int id);
  Future<Either<Failure, Player>?> getPlayerByID(int id);
  Future<Either<Failure, Stadium>?> getStadiumByID(int id);
  Future<Either<Failure, Transfer>?> getTransferByTeamID(int id);
}
