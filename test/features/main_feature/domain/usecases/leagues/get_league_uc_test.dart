import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/country.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/league.dart';

import 'package:live_football_stats/features/main_feature/domain/repositories/league_repositories.dart';
import 'package:live_football_stats/features/main_feature/domain/usecases/leagues/get_league_uc.dart';
import 'package:mockito/mockito.dart';

class MockLeagueRepositories extends Mock implements LeagueRepositories {}

void main() {
  late GetLeagueUseCase leagueUseCases;
  late MockLeagueRepositories mockLeagueRepositories;
  setUp(() {
    mockLeagueRepositories = MockLeagueRepositories();
    leagueUseCases = GetLeagueUseCase(mockLeagueRepositories);
  });
  int testLeagueId = 297;
  League actualLeague = League(
      country: Country(id: 60, name: "spain"),
      id: 297,
      name: "La Liga",
      isCup: false);
  test("should get league from the repository", () async {
    // arrange
    when(mockLeagueRepositories.getLeagueByID(testLeagueId))
        .thenAnswer((realInvocation) async => Right(actualLeague));
    // act
    final result = await leagueUseCases.call(testLeagueId);

    // assert
    expect(result, Right(actualLeague));
    verify(mockLeagueRepositories.getLeagueByID(testLeagueId));
    // Only the above method should be called and nothing more.
    verifyNoMoreInteractions(mockLeagueRepositories);
  });
}
