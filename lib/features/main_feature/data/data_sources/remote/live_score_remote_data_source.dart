import 'package:dio/dio.dart';
import 'package:live_football_stats/config/const/api_endpoints.dart';
import 'package:live_football_stats/config/const/app_config.dart';
import 'package:live_football_stats/core/error/failures.dart';
import 'package:live_football_stats/core/services/websocket_services/websocket_client_service.dart';
import 'package:live_football_stats/features/main_feature/data/models/live_score_model.dart';

import '../../../../../core/constants/string_constants.dart';
import '../../../../../core/utils/dio_client.dart';

abstract class LiveScoreRemoteDataSource {
  Future<List<Match>?> getListLiveMatchesOfAStage(int leagueID, int stageID);
  Future<List<Stage>?> getLiveStages(int leagueID);
  Future<Match?> getLiveMatch(int leagueID, int stageID, int matchID);
  Future<List<LiveScoreModel>?> getLiveScore();
}

class LiveScoreRemoteDataSourceImpl implements LiveScoreRemoteDataSource {
  LiveScoreRemoteDataSourceImpl(
      {required this.dio,
      required this.dioClient,
      required this.webSocketClientService});
  Dio dio = Dio();
  DioClient dioClient;
  WebSocketClientService webSocketClientService;
  @override
  Future<List<Match>?> getListLiveMatchesOfAStage(
      int leagueID, int stageID) async {
    try {
      final url =
          "${ApiEndPoint.livescoresUrl}/$leagueID${AppConfig.authUrlPath}";
      final response = await dioClient.get(url);
      if (response.statusCode == 200) {
        List<Stage> list;
        final data = response.data;
        final listData = data['stage'] as List<dynamic>;
        list = listData.map((e) => Stage.fromJson(e)).toList();
        Stage stageModel =
            list.firstWhere((element) => element.stageId == stageID);
        return stageModel.matches;
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
  Future<Match?> getLiveMatch(int leagueID, int stageID, int matchID) async {
    try {
      final url =
          "${ApiEndPoint.livescoresUrl}/$leagueID${AppConfig.authUrlPath}";
      final response = await dioClient.get(url);
      if (response.statusCode == 200) {
        List<Stage> list;
        final data = response.data;
        final listData = data['stage'] as List<dynamic>;
        list = listData.map((e) => Stage.fromJson(e)).toList();
        Stage stageModel =
            list.firstWhere((element) => element.stageId == stageID);
        if (stageModel.matches != null) {
          Match match = stageModel.matches!
              .firstWhere((element) => element.id == matchID);
          return match;
        } else {
          return null;
        }
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
  Future<List<Stage>?> getLiveStages(int leagueID) async {
    try {
      final url =
          "${ApiEndPoint.livescoresUrl}/$leagueID${AppConfig.authUrlPath}";
      final response = await dioClient.get(url);
      if (response.statusCode == 200) {
        List<Stage> list;
        final data = response.data;
        final listData = data['stage'] as List<dynamic>;
        list = listData.map((e) => Stage.fromJson(e)).toList();
        return list;
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

  // @override
  // Stream<List<LiveScoreModel>?> getLiveScore() {
  //   try {
  //     final url =
  //         "${AppConfig.baseUrl}${ApiEndPoint.livescoresUrl}${AppConfig.authUrlPath}";
  //     print(url);
  //     webSocketClientService.connect(url: url);
  //     return webSocketClientService.channel!.stream.map((event) {
  //       final data = event.data as List<dynamic>;
  //       List<LiveScoreModel>? list =
  //           data.map((e) => LiveScoreModel.fromJson(e)).toList();
  //       return list;
  //     }).handleError((error) {
  //       print(error);
  //       throw ServerFailure(message: error);
  //     });
  //   } catch (e) {
  //     throw ServerFailure(message: e.toString());
  //   }
  // }
  @override
  Future<List<LiveScoreModel>?> getLiveScore() async {
    try {
      final url = "${ApiEndPoint.livescoresUrl}${AppConfig.authUrlPath}";
      final response = await dioClient.get(url);
      if (response.statusCode == 200) {
        final data = response.data as List<dynamic>;
        List<LiveScoreModel>? list =
            data.map((e) => LiveScoreModel.fromJson(e)).toList();

        return list;
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
