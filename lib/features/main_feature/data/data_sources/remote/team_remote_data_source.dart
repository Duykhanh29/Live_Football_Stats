import 'package:dio/dio.dart';
import 'package:live_football_stats/config/const/api_endpoints.dart';
import 'package:live_football_stats/config/const/api_params.dart';
import 'package:live_football_stats/config/const/app_config.dart';
import 'package:live_football_stats/core/constants/string_constants.dart';
import 'package:live_football_stats/core/error/failures.dart';
import 'package:live_football_stats/features/main_feature/data/models/player.dart';
import 'package:live_football_stats/features/main_feature/data/models/stadium.dart';
import 'package:live_football_stats/features/main_feature/data/models/team.dart';
import 'package:live_football_stats/features/main_feature/data/models/transfer_model.dart';

import '../../../../../core/utils/dio_client.dart';

abstract class TeamRemoteDataSource {
  Future<PlayerModel?> getPlayerByID(int id);
  Future<TeamModel?> getTeamByID(int id);
  Future<StadiumModel?> getStadiumByID(int id);
  Future<TransferModel?> getTransferByID(int id);
}

class TeamRemoteDataSourceImpl implements TeamRemoteDataSource {
  TeamRemoteDataSourceImpl({required this.dio, required this.dioClient});
  Dio dio = Dio();
  DioClient dioClient;
  @override
  Future<PlayerModel?> getPlayerByID(int id) async {
    try {
      final url =
          "${ApiEndPoint.playerUrl}${AppConfig.authUrlPath}&=${ApiParams.playerID}=$id";
      final response = await dioClient.get(url);
      if (response.statusCode == 200) {
        final data = response.data;
        PlayerModel playerModel = PlayerModel.fromJson(data);
        return playerModel;
      } else {
        if (response.statusCode == 429) {
          throw TooManyRequestsFailure(message: StringConstants.exceededError);
        } else {
          print("Error: ${response.statusCode}");
          return null;
        }
      }
    } catch (e) {
      if (e is TooManyRequestsFailure || e is ServerFailure) {
        // ignore: use_rethrow_when_possible
        throw e; // Re-throw specific failure
      }
      throw ServerFailure(message: e.toString());
    }
  }

  @override
  Future<StadiumModel?> getStadiumByID(int id) async {
    try {
      final url =
          "${ApiEndPoint.stadiumUrl}${AppConfig.authUrlPath}&=${ApiParams.teamID}=$id";
      final response = await dioClient.get(url);
      if (response.statusCode == 200) {
        final data = response.data;
        StadiumModel stadiumModel = StadiumModel.fromJson(data);
        return stadiumModel;
      } else {
        if (response.statusCode == 429) {
          throw TooManyRequestsFailure(message: StringConstants.exceededError);
        } else {
          print("Error: ${response.statusCode}");
          return null;
        }
      }
    } catch (e) {
      if (e is TooManyRequestsFailure || e is ServerFailure) {
        // ignore: use_rethrow_when_possible
        throw e; // Re-throw specific failure
      }
      throw ServerFailure(message: e.toString());
    }
  }

  @override
  Future<TeamModel?> getTeamByID(int id) async {
    try {
      final url =
          "${ApiEndPoint.teamUrl}${AppConfig.authUrlPath}&${ApiParams.teamID}=$id";
      final response = await dioClient.get(url);
      if (response.statusCode == 200) {
        final data = response.data;
        TeamModel teamModel = TeamModel.fromJson(data);
        return teamModel;
      } else {
        if (response.statusCode == 429) {
          throw TooManyRequestsFailure(message: StringConstants.exceededError);
        } else {
          print("Error: ${response.statusCode}");
          return null;
        }
      }
    } catch (e) {
      if (e is TooManyRequestsFailure || e is ServerFailure) {
        // ignore: use_rethrow_when_possible
        throw e; // Re-throw specific failure
      }
      throw ServerFailure(message: e.toString());
    }
  }

  @override
  Future<TransferModel?> getTransferByID(int id) async {
    try {
      final url =
          "${ApiEndPoint.transfersUrl}${AppConfig.authUrlPath}&${ApiParams.teamID}=$id";
      final response = await dioClient.get(url);
      if (response.statusCode == 200) {
        final data = response.data;
        TransferModel transferModel = TransferModel.fromJson(data);
        return transferModel;
      } else {
        if (response.statusCode == 429) {
          throw TooManyRequestsFailure(message: StringConstants.exceededError);
        } else {
          print("Error: ${response.statusCode}");
          return null;
        }
      }
    } catch (e) {
      if (e is TooManyRequestsFailure || e is ServerFailure) {
        // ignore: use_rethrow_when_possible
        throw e; // Re-throw specific failure
      }
      throw ServerFailure(message: e.toString());
    }
  }
}
