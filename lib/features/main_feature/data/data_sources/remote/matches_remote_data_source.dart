import 'package:dio/dio.dart';
import 'package:live_football_stats/config/const/api_endpoints.dart';
import 'package:live_football_stats/config/const/api_params.dart';
import 'package:live_football_stats/config/const/app_config.dart';
import 'package:live_football_stats/core/error/failures.dart';
import 'package:live_football_stats/features/main_feature/data/models/league_matches_model.dart';
import 'package:live_football_stats/features/main_feature/data/models/match_model.dart';
import 'package:live_football_stats/features/main_feature/data/models/preview_match.dart';
import 'package:live_football_stats/features/main_feature/data/models/upcoming_matches_of_a_league.dart';

import '../../../../../core/constants/string_constants.dart';
import '../../../../../core/utils/dio_client.dart';
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
  MatchRemoteDataSourceImpl({required this.dio, required this.dioClient});
  Dio dio = Dio();
  DioClient dioClient;
  @override
  Future<LeagueMatchesModel?> getListMacthesByLeagueID(int id) async {
    try {
      final String url =
          "${ApiEndPoint.matchesUrl}${AppConfig.authUrlPath}&${ApiParams.leagueID}=$id";
      final response = await dioClient.get(url);
      if (response.statusCode == 200) {
        final data = response.data as List<dynamic>;
        List<LeagueMatchesModel> list =
            data.map((e) => LeagueMatchesModel.fromJson(e)).toList();
        LeagueMatchesModel leagueMatchesModel = list[0];
        return leagueMatchesModel;
      } else {
        if (response.statusCode == 429) {
          throw TooManyRequestsFailure(message: StringConstants.exceededError);
        } else {
          print("Error: ${response.statusCode}");
          return null;
        }
      }
    } catch (e) {
      print("What wrong: $e");
      if (e is TooManyRequestsFailure || e is ServerFailure) {
        // ignore: use_rethrow_when_possible
        throw e; // Re-throw specific failure
      }
      throw ServerFailure(message: e.toString());
    }
  }

  @override
  Future<UpcomingMatchesModel?> getListUpcomingMacthes() async {
    try {
      final url = "${ApiEndPoint.upcomingMacthesUrl}${AppConfig.authUrlPath}";
      final response = await dioClient.get(url);
      if (response.statusCode == 200) {
        final data = response.data;
        UpcomingMatchesModel upcomingMatchesModel =
            UpcomingMatchesModel.fromJson(data);
        return upcomingMatchesModel;
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
  Future<PreviewMatchModel?> getMacthPreview(int id) async {
    try {
      final url =
          "${ApiEndPoint.matchPreviewUrl}${AppConfig.authUrlPath}&${ApiParams.matchID}=$id";
      final response = await dioClient.get(url);
      if (response.statusCode == 200) {
        final data = response.data;
        PreviewMatchModel matchModel = PreviewMatchModel.fromJson(data);
        return matchModel;
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
  Future<MatchModel?> getMatchByID(int id) async {
    try {
      final url =
          "${ApiEndPoint.matchUrl}${AppConfig.authUrlPath}&${ApiParams.matchID}=$id";
      final response = await dioClient.get(url);
      if (response.statusCode == 200) {
        final data = response.data;
        MatchModel matchModel = MatchModel.fromJson(data);
        return matchModel;
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
  Future<HeadToHeadModel?> getHeadToHead(int team1ID, int team2ID) async {
    try {
      final url =
          "${ApiEndPoint.headToHeadUrl}${AppConfig.authUrlPath}&${ApiParams.team1ID}=$team1ID&${ApiParams.team2ID}=$team2ID";
      final response = await dioClient.get(url);
      if (response.statusCode == 200) {
        final data = response.data;
        HeadToHeadModel headToHeadModel = HeadToHeadModel.fromJson(data);
        return headToHeadModel;
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
  Future<LeagueMatchesModel?> getCurrentMatchesOfLeague(
      {required int leagueID, required String date}) async {
    try {
      final url =
          "${ApiEndPoint.matchesUrl}${AppConfig.authUrlPath}&${ApiParams.leagueID}=$leagueID&${ApiParams.date}=$date";
      final response = await dioClient.get(url);
      if (response.statusCode == 200) {
        final data = response.data as List<dynamic>;
        List<LeagueMatchesModel> list =
            data.map((e) => LeagueMatchesModel.fromJson(e)).toList();
        LeagueMatchesModel leagueMatchesModel = list[0];
        return leagueMatchesModel;
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
  Future<List<LeagueMatchesModel>?> getMatchesByDate(String date) async {
    try {
      final url =
          "${ApiEndPoint.matchesUrl}${AppConfig.authUrlPath}&${ApiParams.date}=$date";
      final response = await dioClient.get(url);
      if (response.statusCode == 200) {
        final data = response.data as List<dynamic>;
        List<LeagueMatchesModel> list =
            data.map((e) => LeagueMatchesModel.fromJson(e)).toList();
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
