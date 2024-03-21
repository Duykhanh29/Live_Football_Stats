import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/country.dart';

import 'package:live_football_stats/features/main_feature/domain/entities/upcoming_match.dart';
import 'package:live_football_stats/features/main_feature/domain/repositories/match_repositories.dart';
import 'package:live_football_stats/features/main_feature/domain/usecases/macthes/get_upcoming_matches_uc.dart';
import 'package:mockito/mockito.dart';

class MockMatchRepositories extends Mock implements MatchRepositories {}

void main() {
  late GetUpcomingMatchesUseCase getMatchUseCase;
  late MockMatchRepositories mockMatchRepositories;
  setUp(() {
    mockMatchRepositories = MockMatchRepositories();
    getMatchUseCase =
        GetUpcomingMatchesUseCase(matchRepositories: mockMatchRepositories);
  });

  UpcomingMatches upcomingMatches =
      UpcomingMatches(count: 12, updatedAt: "1234", results: [
    UpcomingMatchesOfLeague(
        country: Country(id: 123, name: "name"),
        isCup: true,
        leagueID: 234,
        leagueName: "fda",
        matchPreviews: [
          MatchPreview(
              date: "fdag",
              exitementRating: 123,
              id: 23,
              teams: Teams(),
              time: "234r")
        ])
  ]);
  test("should get upcoming matches from repository", () async {
    // arrange
    when(mockMatchRepositories.getUpcomingMacthes())
        .thenAnswer((realInvocation) async => Right(upcomingMatches));
    //act
    final result = await getMatchUseCase.call();
    // assert
    expect(result, Right(upcomingMatches));
    verify(mockMatchRepositories.getUpcomingMacthes());
    verifyNoMoreInteractions(mockMatchRepositories);
  });
}
