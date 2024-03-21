import 'package:dio/dio.dart';
import 'package:live_football_stats/config/const/api_endpoints.dart';
import 'package:live_football_stats/config/const/api_params.dart';
import 'package:live_football_stats/config/const/app_config.dart';
import 'package:live_football_stats/core/error/failures.dart';
import 'package:live_football_stats/features/main_feature/data/models/stading_model.dart';

abstract class TableRemoteDataSource {
  Future<StandingModel?> getTableByLeague(int leagueID);
}

class TableRemoteDataSourceImpl implements TableRemoteDataSource {
  TableRemoteDataSourceImpl({required this.dio});
  Dio dio = Dio();
  @override
  Future<StandingModel?> getTableByLeague(int leagueID) async {
    try {
      final response = await dio.get(
          "${AppConfig.baseUrl}${ApiEndPoint.standingUrl}${AppConfig.authUrlPath}&${ApiParams.leagueID}=$leagueID");
      if (response.statusCode == 200) {
        final data = response.data;
        StandingModel standingModel = StandingModel.fromJson(data);
        return standingModel;
      } else {
        print("Error: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      throw ServerFailure(message: e.toString());
    }
  }
}
