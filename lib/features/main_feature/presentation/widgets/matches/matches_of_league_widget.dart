import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:live_football_stats/core/constants/app_colors.dart';
import 'package:live_football_stats/core/helper/comon_widget.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/league_matches.dart';
import 'package:live_football_stats/features/main_feature/presentation/widgets/matches/match_card.dart';

class MatchesOfLeagueWidget extends StatelessWidget {
  MatchesOfLeagueWidget({super.key, required this.leagueMatches});
  LeagueMatches leagueMatches;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      decoration: BoxDecoration(
          color: AppColors.lighterCardColor,
          borderRadius: BorderRadius.circular(10)),
      child: CustomScrollView(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        // crossAxisAlignment: CrossAxisAlignment.start,
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 7,
                    child: Text(
                      leagueMatches.leagueName != null
                          ? "${leagueMatches.leagueName} (${leagueMatches.country!.name ?? ""}) "
                          : "",
                    ),
                  ),
                  CommonWidget.fowardToLeaguePage(
                      context, leagueMatches.leagueID),
                ],
              ),
            ),
          ),
          SliverList.separated(
            separatorBuilder: (context, index) => const SizedBox(
              height: 4,
            ),
            //shrinkWrap: true,
            //  physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return MatchCard(match: leagueMatches.stage![0].matches![index]);
            },
            itemCount: leagueMatches.stage![0].matches!.length,
          ),
          // )
        ],
      ),
    );
  }
}
