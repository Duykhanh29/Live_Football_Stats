import 'package:flutter/material.dart';
import 'package:live_football_stats/core/enums/enum_values.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/country.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/league_response.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/stage_response.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/team_response.dart';
import 'package:live_football_stats/features/main_feature/presentation/widgets/table/latest_match_card.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/match.dart';

class TeamOverviewScreen extends StatelessWidget {
  TeamOverviewScreen({super.key});
  Match match = Match(
      id: 123,
      date: "date",
      time: "time",
      country: Country(id: 123, name: "name"),
      league: LeagueResponse(id: 1234, name: "name"),
      stage: StageResponse(id: 2345, name: "name", isActive: true),
      teams: Teams(
          home: TeamResponse(id: 54, name: "name"),
          away: TeamResponse(id: 54, name: "name")),
      stadium: Stadium(id: 1234, name: "name", city: "city"),
      status: MatchStatus.PRE_MATCH,
      minute: -1,
      winner: Winner.TBD,
      hasExtraTime: false,
      hasPenalties: false,
      goals: Goals(
          homeHtGoals: -1,
          awayHtGoals: -1,
          homeFtGoals: -1,
          awayFtGoals: -1,
          homeEtGoals: -1,
          awayEtGoals: -1,
          homePenGoals: -1,
          awayPenGoals: -1),
      events: [],
      odds: Odds(
          matchWinner: null,
          overUnder: null,
          handicap: null,
          lastModifiedTimestamp: null),
      lineups: Lineups(
          lineupType: LineupType.LIVE,
          lineups: LineupData(home: [], away: []),
          bench: Bench(home: [], away: []),
          sidelined: Sidelined(home: [], away: []),
          formation: Formation(home: "4-3-3", away: "4-3-4")),
      matchPreview:
          MatchPreview(hasPreview: true, wordCount: 23, excitementRating: 4));
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          LatestMatchWidget(
            match: match,
          ),
        ],
      ),
    );
  }
}
