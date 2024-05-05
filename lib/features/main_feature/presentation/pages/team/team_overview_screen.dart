import 'package:flutter/material.dart';
import 'package:live_football_stats/core/enums/enum_values.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/country.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/league_response.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/stage_response.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/team.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/team_response.dart';
import 'package:live_football_stats/features/main_feature/presentation/widgets/table/latest_match_card.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/match.dart';

import '../../widgets/teams/team_info_widget.dart';

class TeamOverviewScreen extends StatelessWidget {
  TeamOverviewScreen({super.key, required this.team});
  Team team;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // LatestMatchWidget(
          //   match: match,
          // ),
          TeamInfoWidget(
            team: team,
          )
        ],
      ),
    );
  }
}
