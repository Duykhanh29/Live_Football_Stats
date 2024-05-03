import 'package:dio/dio.dart';
import 'package:live_football_stats/config/const/api_endpoints.dart';
import 'package:live_football_stats/config/const/api_params.dart';
import 'package:live_football_stats/config/const/app_config.dart';
import 'package:live_football_stats/core/error/failures.dart';
import 'package:live_football_stats/features/main_feature/data/models/stading_model.dart';

import '../../../../../core/constants/string_constants.dart';
import '../../../../../core/utils/dio_client.dart';

abstract class TableRemoteDataSource {
  Future<StandingModel?> getTableByLeague(int leagueID);
}

class TableRemoteDataSourceImpl implements TableRemoteDataSource {
  TableRemoteDataSourceImpl({required this.dio, required this.dioClient});
  Dio dio = Dio();
  DioClient dioClient;
  @override
  Future<StandingModel?> getTableByLeague(int leagueID) async {
    try {
      final String url =
          "${ApiEndPoint.standingUrl}${AppConfig.authUrlPath}&${ApiParams.leagueID}=$leagueID";
      final response = await dioClient.get(url);
      if (response.statusCode == 200) {
        final data = response.data;
        StandingModel standingModel = StandingModel.fromJson(data);
        return standingModel;
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
