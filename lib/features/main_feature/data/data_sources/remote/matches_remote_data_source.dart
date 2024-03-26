import 'package:dio/dio.dart';
import 'package:live_football_stats/config/const/api_endpoints.dart';
import 'package:live_football_stats/config/const/api_params.dart';
import 'package:live_football_stats/config/const/app_config.dart';
import 'package:live_football_stats/core/error/failures.dart';
import 'package:live_football_stats/features/main_feature/data/models/league_matches_model.dart';
import 'package:live_football_stats/features/main_feature/data/models/match_model.dart';
import 'package:live_football_stats/features/main_feature/data/models/preview_match.dart';
import 'package:live_football_stats/features/main_feature/data/models/upcoming_matches_of_a_league.dart';

import '../../models/head_to_head_model.dart';

abstract class MatchRemoteDataSource {
  Future<LeagueMatchesModel?> getListMacthesByLeagueID(int id);
  Future<MatchModel?> getMatchByID(int id);
  Future<UpcomingMatchesModel?> getListUpcomingMacthes();
  Future<PreviewMatchModel?> getMacthPreview(int id);
  Future<HeadToHeadModel?> getHeadToHead(int team1ID, int team2ID);
  Future<LeagueMatchesModel?> getCurrentMatchesOfLeague(
      {required int leagueID, required String date});
  Future<List<LeagueMatchesModel>?> getMatchesByDate(String date);
}

class MatchRemoteDataSourceImpl implements MatchRemoteDataSource {
  MatchRemoteDataSourceImpl({required this.dio});
  Dio dio = Dio();
  @override
  Future<LeagueMatchesModel?> getListMacthesByLeagueID(int id) async {
    try {
      final String url =
          "${AppConfig.baseUrl}${ApiEndPoint.matchesUrl}${AppConfig.authUrlPath}&${ApiParams.leagueID}=$id";
      final response = await dio.get(url);
      if (response.statusCode == 200) {
        final data = response.data as List<dynamic>;
        List<LeagueMatchesModel> list =
            data.map((e) => LeagueMatchesModel.fromJson(e)).toList();
        LeagueMatchesModel leagueMatchesModel = list[0];
        return leagueMatchesModel;
      }
    } catch (e) {
      print("What wrong: $e");
      throw ServerFailure(message: e.toString());
    }
  }

  @override
  Future<UpcomingMatchesModel?> getListUpcomingMacthes() async {
    try {
      final response = await dio.get(
          "${AppConfig.baseUrl}${ApiEndPoint.upcomingMacthesUrl}${AppConfig.authUrlPath}");
      if (response.statusCode == 200) {
        final data = response.data;
        UpcomingMatchesModel upcomingMatchesModel =
            UpcomingMatchesModel.fromJson(data);
        return upcomingMatchesModel;
      }
    } catch (e) {
      throw ServerFailure(message: e.toString());
    }
  }

  @override
  Future<PreviewMatchModel?> getMacthPreview(int id) async {
    try {
      final response = await dio.get(
          "${AppConfig.baseUrl}${ApiEndPoint.matchPreviewUrl}${AppConfig.authUrlPath}&${ApiParams.matchID}=$id");
      if (response.statusCode == 200) {
        final data = response.data;
        PreviewMatchModel matchModel = PreviewMatchModel.fromJson(data);
        return matchModel;
      }
    } catch (e) {
      throw ServerFailure(message: e.toString());
    }
  }

  @override
  Future<MatchModel?> getMatchByID(int id) async {
    try {
      final response = await dio.get(
          "${AppConfig.baseUrl}${ApiEndPoint.matchUrl}${AppConfig.authUrlPath}&${ApiParams.matchID}=$id");
      if (response.statusCode == 200) {
        final data = response.data;
        MatchModel matchModel = MatchModel.fromJson(data);
        return matchModel;
      }
    } catch (e) {
      throw ServerFailure(message: e.toString());
    }
  }

  @override
  Future<HeadToHeadModel?> getHeadToHead(int team1ID, int team2ID) async {
    try {
      final url =
          "${AppConfig.baseUrl}${ApiEndPoint.headToHeadUrl}${AppConfig.authUrlPath}&${ApiParams.team1ID}=$team1ID&${ApiParams.team2ID}=$team2ID";
      final response = await dio.get(url);
      if (response.statusCode == 200) {
        final data = response.data;
        HeadToHeadModel headToHeadModel = HeadToHeadModel.fromJson(data);
        return headToHeadModel;
      }
    } catch (e) {
      throw ServerFailure(message: e.toString());
    }
  }

  @override
  Future<LeagueMatchesModel?> getCurrentMatchesOfLeague(
      {required int leagueID, required String date}) async {
    try {
      final url =
          "${AppConfig.baseUrl}${ApiEndPoint.matchesUrl}${AppConfig.authUrlPath}&${ApiParams.leagueID}=$leagueID&${ApiParams.date}=$date";
      final response = await dio.get(url);
      if (response.statusCode == 200) {
        final data = response.data as List<dynamic>;
        List<LeagueMatchesModel> list =
            data.map((e) => LeagueMatchesModel.fromJson(e)).toList();
        LeagueMatchesModel leagueMatchesModel = list[0];
        return leagueMatchesModel;
      }
    } catch (e) {
      throw ServerFailure(message: e.toString());
    }
  }

  @override
  Future<List<LeagueMatchesModel>?> getMatchesByDate(String date) async {
    try {
      final url =
          "${AppConfig.baseUrl}${ApiEndPoint.matchesUrl}${AppConfig.authUrlPath}&${ApiParams.date}=$date";
      final response = await dio.get(url);
      if (response.statusCode == 200) {
        final data = response.data as List<dynamic>;
        List<LeagueMatchesModel> list =
            data.map((e) => LeagueMatchesModel.fromJson(e)).toList();
        return list;
      }
    } catch (e) {
      throw ServerFailure(message: e.toString());
    }
  }
}
