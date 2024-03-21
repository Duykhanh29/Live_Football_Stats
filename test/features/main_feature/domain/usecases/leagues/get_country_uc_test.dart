import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/country.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/league.dart';

import 'package:live_football_stats/features/main_feature/domain/repositories/league_repositories.dart';
import 'package:live_football_stats/features/main_feature/domain/usecases/leagues/get_country_uc.dart';
import 'package:live_football_stats/features/main_feature/domain/usecases/leagues/get_league_uc.dart';
import 'package:mockito/mockito.dart';

class MockLeagueRepositories extends Mock implements LeagueRepositories {}

void main() {
  late GetCountryUseCase leagueUseCases;
  late MockLeagueRepositories mockLeagueRepositories;
  setUp(() {
    mockLeagueRepositories = MockLeagueRepositories();
    leagueUseCases = GetCountryUseCase(mockLeagueRepositories);
  });
  int testID = 60;
  Country actualCountry = Country(id: 60, name: "Spain");
  test("should get country from the repository", () async {
    // arrange
    when(mockLeagueRepositories.getCountryByID(testID))
        .thenAnswer((realInvocation) async => Right(actualCountry));
    // act
    final result = await leagueUseCases.call(testID);

    // assert
    expect(result, Right(actualCountry));
    verify(mockLeagueRepositories.getCountryByID(testID));
    // Only the above method should be called and nothing more.
    verifyNoMoreInteractions(mockLeagueRepositories);
  });
}
