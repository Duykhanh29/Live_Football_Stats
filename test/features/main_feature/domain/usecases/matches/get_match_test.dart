import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:live_football_stats/core/enums/enum_values.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/country.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/league_response.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/player.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/stage_response.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/team_response.dart';
import 'package:live_football_stats/features/main_feature/domain/repositories/match_repositories.dart';
import 'package:live_football_stats/features/main_feature/domain/usecases/macthes/get_match_uc.dart';
import 'package:live_football_stats/features/main_feature/domain/usecases/macthes/get_matches_of_league_uc.dart';
import 'package:mockito/mockito.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/match.dart';

class MockMatchRepositories extends Mock implements MatchRepositories {}

void main() {
  late GetMatchUseCase getMatchUseCase;
  late MockMatchRepositories mockMatchRepositories;
  setUp(() {
    mockMatchRepositories = MockMatchRepositories();
    getMatchUseCase = GetMatchUseCase(matchRepositories: mockMatchRepositories);
  });
  Match match = Match(
      stage: StageResponse(id: 234, name: "fas", isActive: true),
      league: LeagueResponse(id: 23, name: "fgb"),
      country: Country(id: 1234, name: "Fdsaf"),
      id: 123,
      date: "12-12-2023",
      time: "12",
      teams: Teams(
          home: TeamResponse(id: 12, name: "dfa"),
          away: TeamResponse(id: 32, name: "dfsfa")),
      stadium: Stadium(id: 34, name: "fdasfsd", city: "yju6"),
      status: MatchStatus.FINISHED,
      minute: -1,
      winner: Winner.HOME,
      hasExtraTime: true,
      hasPenalties: false,
      goals: Goals(
          homeHtGoals: 2,
          awayHtGoals: 1,
          homeFtGoals: 1,
          awayFtGoals: 0,
          homeEtGoals: 0,
          awayEtGoals: 0,
          homePenGoals: 0,
          awayPenGoals: 0),
      events: [],
      odds: Odds(
          matchWinner: MatchWinner(home: 2, draw: 3, away: 2),
          overUnder: OverUnder(total: 4, over: 2, under: 2),
          handicap: Handicap(market: 3, home: 2, away: 1),
          lastModifiedTimestamp: 23456),
      lineups: Lineups(
          lineupType: LineupType.LIVE,
          lineups: LineupData(home: [
            BenchAway(
                player: Player(id: 123, name: "name"),
                position: Position.ATTACKER)
          ], away: const []),
          bench: Bench(home: const [], away: const []),
          sidelined: Sidelined(home: [], away: []),
          formation: Formation(home: "4-3-3", away: "4-2-3-1")),
      matchPreview: MatchPreview(
          hasPreview: false, wordCount: 1234, excitementRating: 3));
  int testId = 123;
  test("should get match from repository", () async {
    // arrange
    when(mockMatchRepositories.getMatchByID(testId))
        .thenAnswer((realInvocation) async => Right(match));
    //act
    final result = await getMatchUseCase.call(testId);
    // assert
    expect(result, Right(match));
    verify(mockMatchRepositories.getMatchByID(testId));
    verifyNoMoreInteractions(mockMatchRepositories);
  });
}
