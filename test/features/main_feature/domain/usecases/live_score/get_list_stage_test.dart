import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:live_football_stats/core/enums/enum_values.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/match_event.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/player.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/sidelined_player.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/team.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/team_response.dart';
import 'package:live_football_stats/features/main_feature/domain/repositories/live_score_repositories.dart';
import 'package:live_football_stats/features/main_feature/domain/usecases/live_score/get_list_stage_uc.dart';
import 'package:mockito/mockito.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/live_score.dart';

class MockLiveScoreRepositories extends Mock implements LiveScoreRepositories {}

void main() {
  late GetListStageUseCase getListStageUseCase;
  late MockLiveScoreRepositories mockLiveScoreRepositories;
  setUp(() {
    mockLiveScoreRepositories = MockLiveScoreRepositories();
    getListStageUseCase =
        GetListStageUseCase(liveScoreRepositories: mockLiveScoreRepositories);
  });
  List<Stage> actualList = [
    Stage(stageId: 12, stageName: "Laliga", matches: [
      Match(
          id: 11,
          date: "fdafd",
          time: "dfas",
          teams: Teams(
              home: TeamResponse(id: 12, name: "Man"),
              away: TeamResponse(id: 32, name: "AV")),
          stadium: Stadium(id: 32, name: "Cong", city: "Hong Kong"),
          status: MatchStatus.LIVE,
          minute: 43,
          winner: Winner.TBD,
          hasExtraTime: false,
          hasPenalties: false,
          goals: Goals(
              homeHtGoals: 0,
              awayHtGoals: 0,
              homeFtGoals: 0,
              awayFtGoals: 0,
              homeEtGoals: -1,
              awayEtGoals: -1,
              homePenGoals: -1,
              awayPenGoals: -1),
          events: [
            MatchEvent(
                eventType: EventType.YELLOW_CARD,
                eventMinute: "32",
                team: EventTeam.HOME,
                player: Player(id: 43, name: "Mark"),
                assistPlayer: null)
          ],
          odds: Odds(
              matchWinner: MatchWinner(home: 3.4, draw: 2.5, away: 4.1),
              overUnder: OverUnder(total: 3, over: 2, under: 3),
              handicap: Handicap(market: 3, home: 2, away: 2),
              lastModifiedTimestamp: 1234567),
          lineups: Lineups(
              lineupType: LineupType.LIVE,
              lineups: LineupData(home: [
                BenchAway(
                    player: Player(id: 21, name: "name"),
                    position: Position.ATTACKER),
                BenchAway(
                    player: Player(id: 22, name: "name1"),
                    position: Position.ATTACKER)
              ], away: [
                BenchAway(
                    player: Player(id: 21, name: "name"),
                    position: Position.ATTACKER),
                BenchAway(
                    player: Player(id: 22, name: "name1"),
                    position: Position.ATTACKER)
              ]),
              bench: Bench(home: [
                BenchAway(
                    player: Player(id: 21, name: "name"),
                    position: Position.ATTACKER),
                BenchAway(
                    player: Player(id: 22, name: "name1"),
                    position: Position.ATTACKER)
              ], away: [
                BenchAway(
                    player: Player(id: 21, name: "name"),
                    position: Position.ATTACKER),
                BenchAway(
                    player: Player(id: 22, name: "name1"),
                    position: Position.ATTACKER)
              ]),
              sidelined: Sidelined(home: [], away: [
                SidelinedPlayer(
                    player: Player(id: 55, name: "nameWhat"),
                    status: "status",
                    desc: "desc")
              ]),
              formation: Formation(home: "4-2-3-1", away: "4-3-3")),
          matchPreview: MatchPreview(hasPreview: false, wordCount: 123))
    ]),
    Stage(stageId: 13, stageName: "Laliga", matches: [
      Match(
          id: 11,
          date: "fdafd",
          time: "dfas",
          teams: Teams(
              home: TeamResponse(id: 12, name: "Man"),
              away: TeamResponse(id: 32, name: "AV")),
          stadium: Stadium(id: 32, name: "Cong", city: "Hong Kong"),
          status: MatchStatus.LIVE,
          minute: 43,
          winner: Winner.TBD,
          hasExtraTime: false,
          hasPenalties: false,
          goals: Goals(
              homeHtGoals: 0,
              awayHtGoals: 0,
              homeFtGoals: 0,
              awayFtGoals: 0,
              homeEtGoals: -1,
              awayEtGoals: -1,
              homePenGoals: -1,
              awayPenGoals: -1),
          events: [
            MatchEvent(
                eventType: EventType.YELLOW_CARD,
                eventMinute: "32",
                team: EventTeam.HOME,
                player: Player(id: 43, name: "Mark"),
                assistPlayer: null)
          ],
          odds: Odds(
              matchWinner: MatchWinner(home: 3.4, draw: 2.5, away: 4.1),
              overUnder: OverUnder(total: 3, over: 2, under: 3),
              handicap: Handicap(market: 3, home: 2, away: 2),
              lastModifiedTimestamp: 1234567),
          lineups: Lineups(
              lineupType: LineupType.LIVE,
              lineups: LineupData(home: [
                BenchAway(
                    player: Player(id: 21, name: "name"),
                    position: Position.ATTACKER),
                BenchAway(
                    player: Player(id: 22, name: "name1"),
                    position: Position.ATTACKER)
              ], away: [
                BenchAway(
                    player: Player(id: 21, name: "name"),
                    position: Position.ATTACKER),
                BenchAway(
                    player: Player(id: 22, name: "name1"),
                    position: Position.ATTACKER)
              ]),
              bench: Bench(home: [
                BenchAway(
                    player: Player(id: 21, name: "name"),
                    position: Position.ATTACKER),
                BenchAway(
                    player: Player(id: 22, name: "name1"),
                    position: Position.ATTACKER)
              ], away: [
                BenchAway(
                    player: Player(id: 21, name: "name"),
                    position: Position.ATTACKER),
                BenchAway(
                    player: Player(id: 22, name: "name1"),
                    position: Position.ATTACKER)
              ]),
              sidelined: Sidelined(home: [], away: [
                SidelinedPlayer(
                    player: Player(id: 55, name: "nameWhat"),
                    status: "status",
                    desc: "desc")
              ]),
              formation: Formation(home: "4-2-3-1", away: "4-3-3")),
          matchPreview: MatchPreview(hasPreview: false, wordCount: 123))
    ])
  ];
  int testId = 12;
  test("should get all stage from repository", () async {
    // arrange
    when(mockLiveScoreRepositories.getListStage(testId))
        .thenAnswer((realInvocation) async => Right(actualList));
    //act
    final result = await getListStageUseCase.call(testId);
    // assert
    expect(result, Right(actualList));
    verify(mockLiveScoreRepositories.getListStage(testId));
    verifyNoMoreInteractions(mockLiveScoreRepositories);
  });
}
