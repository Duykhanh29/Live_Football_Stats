import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:live_football_stats/config/const/api_endpoints.dart';
import 'package:live_football_stats/config/const/app_config.dart';
import 'package:live_football_stats/core/utils/dio_client.dart';
import 'package:live_football_stats/features/main_feature/data/data_sources/remote/live_score_remote_data_source.dart';
import 'package:live_football_stats/features/main_feature/data/models/live_score_model.dart';
import 'package:mockito/mockito.dart';
import '../../../../../fixtures/fixtures_reader.dart';

class MockHttpClient extends Mock implements HttpClientAdapter {}

void main() {
  late MockHttpClient mockHttpClient;
  final Dio dio = Dio();
  late LiveScoreRemoteDataSourceImpl liveScoreRemoteDataSourceImpl;
  setUp(() {
    mockHttpClient = MockHttpClient();
    dio.httpClientAdapter = mockHttpClient;
    liveScoreRemoteDataSourceImpl = LiveScoreRemoteDataSourceImpl(dio: dio);
  });
  test("should perform a GET request to the correct URL", () async {
    // arrange
    final String url =
        "${AppConfig.baseUrl}${ApiEndPoint.livescoresUrl}${AppConfig.authUrlPath}";
    final fakeResponse = fixture("live_score/livescore.json");
    final responsePayload = json.decode(fakeResponse);
    // when(mockHttpClient.fetch(RequestOptions(baseUrl: url), any, any))
    //     .thenAnswer(
    //         (realInvocation) async => ResponseBody(responsePayload, 200));
    //act
    final result = await liveScoreRemoteDataSourceImpl.getLiveScore();
    //assert
    expect(result, equals(LiveScoreModel));
    verify(mockHttpClient.fetch(RequestOptions(baseUrl: url), any, any));
    verifyNoMoreInteractions(mockHttpClient);
  });
}
