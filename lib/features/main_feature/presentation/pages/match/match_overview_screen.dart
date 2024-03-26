import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:live_football_stats/core/enums/enum_values.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/match.dart';
import 'package:live_football_stats/features/main_feature/presentation/widgets/matches/match_winner_widget.dart';

import '../../widgets/matches/game_info_widget.dart';
import '../../widgets/matches/handicap_widget.dart';
import '../../widgets/matches/over_under_widget.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/league_response.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/match.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/stage_response.dart';

class OverviewMatchWidget extends StatelessWidget {
  OverviewMatchWidget(
      {super.key,
      required this.matchStatus,
      this.handicap,
      this.matchWinner,
      this.overUnder,
      required this.leagueResponse,
      required this.stadium,
      required this.stage});
  MatchStatus? matchStatus;
  MatchWinner? matchWinner;
  OverUnder? overUnder;
  Handicap? handicap;
  LeagueResponse? leagueResponse;
  StageResponse? stage;
  Stadium? stadium;
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                if (matchStatus != MatchStatus.FINISHED)
                  MatchWinnerWidget(
                    matchWinner: matchWinner,
                  ),
                if (matchStatus != MatchStatus.FINISHED)
                  OverUnderWidget(
                    overUnder: overUnder,
                  ),
                if (matchStatus != MatchStatus.FINISHED)
                  HandicapWidget(
                    handicap: handicap,
                  ),
                GameInfoWidget(
                  leagueResponse: leagueResponse,
                  stadium: stadium,
                  stage: stage,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
