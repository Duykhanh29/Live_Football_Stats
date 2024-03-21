import 'package:dio/dio.dart';
import 'package:live_football_stats/config/const/api_endpoints.dart';
import 'package:live_football_stats/config/const/app_config.dart';
import 'package:live_football_stats/core/error/failures.dart';
import 'package:live_football_stats/features/main_feature/data/models/live_score_model.dart';

abstract class LiveScoreRemoteDataSource {
  Future<List<Match>?> getListLiveMatchesOfAStage(int leagueID, int stageID);
  Future<List<Stage>?> getLiveStages(int leagueID);
  Future<Match?> getLiveMatch(int leagueID, int stageID, int matchID);
  Future<LiveScoreModel?> getLiveScore();
}

class LiveScoreRemoteDataSourceImpl implements LiveScoreRemoteDataSource {
  LiveScoreRemoteDataSourceImpl({required this.dio});
  Dio dio = Dio();
  @override
  Future<List<Match>?> getListLiveMatchesOfAStage(
      int leagueID, int stageID) async {
    try {
      final response = await dio.get(
          "${AppConfig.baseUrl}${ApiEndPoint.livescoresUrl}/$leagueID${AppConfig.authUrlPath}");
      if (response.statusCode == 200) {
        List<Stage> list;
        final data = response.data;
        final listData = data['stage'] as List<dynamic>;
        list = listData.map((e) => Stage.fromJson(e)).toList();
        Stage stageModel =
            list.firstWhere((element) => element.stageId == stageID);
        return stageModel.matches;
      } else {
        print("Error: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      throw ServerFailure(message: e.toString());
    }
  }

  @override
  Future<Match?> getLiveMatch(int leagueID, int stageID, int matchID) async {
    try {
      final response = await dio.get(
          "${AppConfig.baseUrl}${ApiEndPoint.livescoresUrl}/$leagueID${AppConfig.authUrlPath}");
      if (response.statusCode == 200) {
        List<Stage> list;
        final data = response.data;
        final listData = data['stage'] as List<dynamic>;
        list = listData.map((e) => Stage.fromJson(e)).toList();
        Stage stageModel =
            list.firstWhere((element) => element.stageId == stageID);
        Match match =
            stageModel.matches.firstWhere((element) => element.id == matchID);
        return match;
      } else {
        print("Error: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      throw ServerFailure(message: e.toString());
    }
  }

  @override
  Future<List<Stage>?> getLiveStages(int leagueID) async {
    try {
      final response = await dio.get(
          "${AppConfig.baseUrl}${ApiEndPoint.livescoresUrl}/$leagueID${AppConfig.authUrlPath}");
      if (response.statusCode == 200) {
        List<Stage> list;
        final data = response.data;
        final listData = data['stage'] as List<dynamic>;
        list = listData.map((e) => Stage.fromJson(e)).toList();
        return list;
      } else {
        print("Error: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      throw ServerFailure(message: e.toString());
    }
  }

  @override
  Future<LiveScoreModel?> getLiveScore() async {
    try {
      final response = await dio.get(
          "${AppConfig.baseUrl}${ApiEndPoint.livescoresUrl}${AppConfig.authUrlPath}");
      if (response.statusCode == 200) {
        final data = response.data;
        LiveScoreModel liveScoreModel = LiveScoreModel.fromJson(data);
        return liveScoreModel;
      } else {
        print("Error: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      throw ServerFailure(message: e.toString());
    }
  }
}
