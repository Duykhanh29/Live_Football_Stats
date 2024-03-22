import 'package:flutter/cupertino.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/head_to_head.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/team_response.dart';

import '../../widgets/matches/head_to_head_overall_widget.dart';

class HeadToHeadScreen extends StatelessWidget {
  HeadToHeadScreen({super.key});
  HeadToHead headToHead = HeadToHead(
      team1: TeamResponse(id: 123, name: "name"),
      team2: TeamResponse(id: 1234, name: "name1"),
      stats: Stats(
          overall: Overall(
              overallGamesPlayed: 12,
              overallTeam1Wins: 5,
              overallTeam2Wins: 3,
              overallDraws: 4,
              overallTeam1Scored: 24,
              overallTeam2Scored: 20),
          team1AtHome: Team1AtHome(
              team1GamesPlayedAtHome: 6,
              team1WinsAtHome: 3,
              team1LossesAtHome: 1,
              team1DrawsAtHome: 2,
              team1ScoredAtHome: 14,
              team1ConcededAtHome: 10),
          team2AtHome: Team2AtHome(
              team2GamesPlayedAtHome: 6,
              team2WinsAtHome: 2,
              team2LossesAtHome: 2,
              team2DrawsAtHome: 2,
              team2ScoredAtHome: 10,
              team2ConcededAtHome: 10)));
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            HeadToHeadWidget(
                draw: headToHead.stats!.overall!.overallDraws!,
                name: "Overall",
                team1Wins: headToHead.stats!.overall!.overallTeam1Wins!,
                team2Wins: headToHead.stats!.overall!.overallTeam2Wins!,
                team1Scored: headToHead.stats!.overall!.overallTeam1Scored!,
                team2Scored: headToHead.stats!.overall!.overallTeam2Scored!,
                totalGames: headToHead.stats!.overall!.overallGamesPlayed!,
                team1: headToHead.team1!,
                team2: headToHead.team2!),
            HeadToHeadWidget(
                draw: headToHead.stats!.team1AtHome!.team1DrawsAtHome!,
                name: "${headToHead.team1!.name} at home",
                team1Wins: headToHead.stats!.team1AtHome!.team1WinsAtHome!,
                team2Wins: headToHead.stats!.team1AtHome!.team1LossesAtHome!,
                team1Scored: headToHead.stats!.team1AtHome!.team1ScoredAtHome!,
                team2Scored:
                    headToHead.stats!.team1AtHome!.team1ConcededAtHome!,
                totalGames:
                    headToHead.stats!.team1AtHome!.team1GamesPlayedAtHome!,
                team1: headToHead.team1!,
                team2: headToHead.team2!),
            HeadToHeadWidget(
                draw: headToHead.stats!.team1AtHome!.team1DrawsAtHome!,
                name: "${headToHead.team2!.name} at home",
                team1Wins: headToHead.stats!.team2AtHome!.team2WinsAtHome!,
                team2Wins: headToHead.stats!.team2AtHome!.team2LossesAtHome!,
                team1Scored: headToHead.stats!.team2AtHome!.team2ScoredAtHome!,
                team2Scored:
                    headToHead.stats!.team2AtHome!.team2ConcededAtHome!,
                totalGames:
                    headToHead.stats!.team2AtHome!.team2GamesPlayedAtHome!,
                team1: headToHead.team1!,
                team2: headToHead.team2!),
          ],
        ),
      ),
    );
  }
}
