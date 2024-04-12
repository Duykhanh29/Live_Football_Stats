import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:live_football_stats/config/const/api_endpoints.dart';
import 'package:live_football_stats/config/const/app_config.dart';
import 'package:live_football_stats/core/utils/dio_client.dart';
import 'package:live_football_stats/features/main_feature/data/data_sources/remote/live_score_remote_data_source.dart';
import 'package:live_football_stats/features/main_feature/data/models/live_score_model.dart';
import 'package:mockito/mockito.dart';
import '../../../../../fixtures/fixtures_reader.dart';

class MockHttpClient extends Mock implements Dio {}

class MockDioClient extends Mock implements DioClient {}

void main() {
  late MockHttpClient mockHttpClient;
  late MockDioClient mockDioClient;
  late LiveScoreRemoteDataSourceImpl liveScoreRemoteDataSourceImpl;
  setUp(() {
    mockHttpClient = MockHttpClient();
    mockDioClient = MockDioClient();
    liveScoreRemoteDataSourceImpl = LiveScoreRemoteDataSourceImpl(
        dio: mockHttpClient, dioClient: mockDioClient);
  });
  test("should perform a GET request to the correct URL", () async {
    // arrange
    final String url = "${ApiEndPoint.livescoresUrl}${AppConfig.authUrlPath}";
    final fakeResponse = fixture("live_score/livescore.json");
    when(mockDioClient.get(url)).thenAnswer((realInvocation) async => Response(
        requestOptions: RequestOptions(responseType: ResponseType.json),
        data: fixture("live_score/livescore.json"),
        statusCode: 200));
    //act
    final result = await liveScoreRemoteDataSourceImpl.getLiveScore();
    //assert
    expect(result, equals(LiveScoreModel));
    verify(mockHttpClient.get(url));
    verifyNoMoreInteractions(mockHttpClient);
  });
}
