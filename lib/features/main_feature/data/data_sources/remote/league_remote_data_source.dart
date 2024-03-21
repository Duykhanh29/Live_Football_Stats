import 'package:live_football_stats/config/const/api_endpoints.dart';
import 'package:live_football_stats/config/const/api_params.dart';
import 'package:live_football_stats/config/const/app_config.dart';
import 'package:live_football_stats/core/error/failures.dart';
import 'package:live_football_stats/features/main_feature/data/models/country.dart';
import 'package:live_football_stats/features/main_feature/data/models/league.dart';
import 'package:dio/dio.dart';

abstract class LeagueRemoteDataSource {
  Future<List<CountryModel>?> getlistCountry();
  Future<List<LeagueModel>?> getAllLeague();
  Future<List<LeagueModel>?> getLeaguesOfACountry(int id);
  Future<CountryModel?> getCountryByID(int id);
  Future<LeagueModel?> getLeagueByID(int id);
}

class LeagueRemoteDataSourceImpl implements LeagueRemoteDataSource {
  LeagueRemoteDataSourceImpl({required this.dio});
  Dio dio = Dio();
  @override
  Future<List<LeagueModel>?> getAllLeague() async {
    try {
      String url =
          "${AppConfig.baseUrl}${ApiEndPoint.leagueUrl}${AppConfig.authUrlPath}";
      final response = await dio.get(url);
      if (response.statusCode == 200) {
        final data = response.data;
        final leagueData = data['results'] as List<dynamic>;
        List<LeagueModel> leagues =
            leagueData.map((e) => LeagueModel.fromJson(e)).toList();
        return leagues;
      } else {
        print("Error: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      throw ServerFailure(message: e.toString());
    }
  }

  @override
  Future<CountryModel?> getCountryByID(int id) async {
    // TODO: implement getCountryByID
    try {
      final response = await dio.get(
          "${AppConfig.baseUrl}${ApiEndPoint.countryUrl}/$id${AppConfig.authUrlPath}");
      if (response.statusCode == 200) {
        final data = response.data;
        CountryModel countryModel = CountryModel.fromJson(data);
        return countryModel;
      } else {
        print("Error: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      throw ServerFailure(message: e.toString());
    }
  }

  @override
  Future<LeagueModel?> getLeagueByID(int id) async {
    try {
      final response = await dio.get(
          "${AppConfig.baseUrl}${ApiEndPoint.leagueUrl}/$id${AppConfig.authUrlPath}");
      if (response.statusCode == 200) {
        final data = response.data;
        LeagueModel leagueModel = LeagueModel.fromJson(data);
        return leagueModel;
      } else {
        print("Error: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      throw ServerFailure(message: e.toString());
    }
  }

  @override
  Future<List<LeagueModel>?> getLeaguesOfACountry(int id) async {
    try {
      final String url =
          "${AppConfig.baseUrl}${ApiEndPoint.leagueUrl}${AppConfig.authUrlPath}&${ApiParams.countryID}=$id";
      final response = await dio.get(url);
      if (response.statusCode == 200) {
        final data = response.data;
        final listData = data['results'] as List<dynamic>;
        List<LeagueModel> list =
            listData.map((e) => LeagueModel.fromJson(e)).toList();
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
  Future<List<CountryModel>?> getlistCountry() async {
    try {
      final response = await dio.get(
          "${AppConfig.baseUrl}${ApiEndPoint.countryUrl}${AppConfig.authUrlPath}");
      if (response.statusCode == 200) {
        final data = response.data;
        final countryData = data['results'] as List<dynamic>;
        List<CountryModel> list =
            countryData.map((e) => CountryModel.fromJson(e)).toList();
        return list;
      } else {
        print("Error: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      throw ServerFailure(message: e.toString());
    }
  }
}
