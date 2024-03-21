import 'package:flutter_test/flutter_test.dart';
import 'package:live_football_stats/core/platform/network_info.dart';
import 'package:live_football_stats/features/main_feature/data/data_sources/remote/league_remote_data_source.dart';
import 'package:live_football_stats/features/main_feature/data/repositories/league_repo.dart';
import 'package:mockito/mockito.dart';

class MockLeagueRemoteDataSource extends Mock
    implements LeagueRemoteDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late LeagueRepoImpl leagueRepoImpl;
  late MockNetworkInfo mockNetworkInfo;
  late MockLeagueRemoteDataSource mockLeagueRemoteDataSource;
  setUp(() {
    mockNetworkInfo = MockNetworkInfo();
    mockLeagueRemoteDataSource = MockLeagueRemoteDataSource();
    leagueRepoImpl = LeagueRepoImpl(
        leagueRemoteDataSource: mockLeagueRemoteDataSource,
        networkInfo: mockNetworkInfo);
  });
  void runTestsOnline(Function body) {
    group("Device is online", () {
      setUp(() {
        when(mockNetworkInfo.isConnected)
            .thenAnswer((realInvocation) async => true);
      });
      body();
    });
  }

  void runTestsOffline(Function body) {
    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected)
            .thenAnswer((realInvocation) async => false);
      });

      body();
    });
  }

  runTestsOnline(() {
    group(
        "should return remote data when the call to remote data source is successful",
        () async {
      // tests
    });
  });
  runTestsOffline(() {
    group(
        "should return last locally cached data when the cached data is present",
        () async {
      // tests
    });
  });
}
