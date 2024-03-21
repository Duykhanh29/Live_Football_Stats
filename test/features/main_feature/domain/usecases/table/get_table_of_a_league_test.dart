import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:live_football_stats/core/enums/enum_values.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/country.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/league_response.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/season.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/stadium.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/standing.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/team_response.dart';
import 'package:live_football_stats/features/main_feature/domain/repositories/table_repositories.dart';
import 'package:live_football_stats/features/main_feature/domain/usecases/table/get_table_of_a_league_uc.dart';
import 'package:mockito/mockito.dart';

class MockTableRepositories extends Mock implements TableRepositories {}

void main() {
  late GetTableOfALeagueUseCase getTableOfALeagueUseCase;
  late MockTableRepositories mockTableRepositories;
  setUp(() {
    mockTableRepositories = MockTableRepositories();
    getTableOfALeagueUseCase =
        GetTableOfALeagueUseCase(tableRepositories: mockTableRepositories);
  });
  int testId = 297;
  StandingEntities standingEntities = StandingEntities(
      country: Country(id: 60, name: "Spain"),
      league: LeagueResponse(id: 297, name: "La liga"),
      season: Season(isActive: true, year: "2023-2024"),
      stage: [
        Stage(
            stageId: 123,
            stageName: "Primera Division",
            hasGroups: false,
            isActive: true,
            standings: [
              Standing(
                  position: 2,
                  teamId: 2798,
                  teamName: "Girona",
                  positionAttribute:
                      "Promotion - Champions League (Group Stage: )",
                  gamesPlayed: 27,
                  points: 66,
                  wins: 20,
                  draws: 6,
                  losses: 1,
                  goalsFor: 56,
                  goalsAgainst: 18),
              Standing(
                  position: 1,
                  teamId: 4883,
                  teamName: "Real Madrid",
                  positionAttribute:
                      "Promotion - Champions League (Group Stage: )",
                  gamesPlayed: 27,
                  points: 58,
                  wins: 18,
                  draws: 5,
                  losses: 4,
                  goalsFor: 57,
                  goalsAgainst: 33)
            ])
      ]);
  Stadium stadium = Stadium(
      city: "Liverpool",
      id: 2075,
      name: "Anfield",
      teams: [TeamResponse(id: 4138, name: "Liverpool")]);
  test("should get all stage from repository", () async {
    // arrange
    when(mockTableRepositories.getTableByLeagueID(testId))
        .thenAnswer((realInvocation) async => Right(standingEntities));
    //act
    final result = await getTableOfALeagueUseCase.call(testId);
    // assert
    expect(result, Right(standingEntities));
    verify(mockTableRepositories.getTableByLeagueID(testId));
    verifyNoMoreInteractions(mockTableRepositories);
  });
}
