import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:live_football_stats/core/helper/comon_widget.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/live_score.dart';
import 'package:live_football_stats/features/main_feature/presentation/widgets/live_score/match_card.dart';

class LiveScoreCard extends StatelessWidget {
  LiveScoreCard({super.key, required this.liveScore});
  LiveScore liveScore;
  @override
  Widget build(BuildContext context) {
    return Column(
      // shrinkWrap: true,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // SliverToBoxAdapter(
        //   child:
        Container(
          padding: const EdgeInsets.only(bottom: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 7,
                child: Text(
                  liveScore.leagueName != null
                      ? "${liveScore.leagueName} (${liveScore.country!.name ?? ""}) "
                      : "",
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w400),
                ),
              ),
              CommonWidget.fowardToLeaguePage(context, liveScore.leagueId),
            ],
          ),
        ),
        // ),
        // if (liveScore.stage != null && liveScore.stage![0].matches != null)
        ListView.separated(
          physics: NeverScrollableScrollPhysics(),
          separatorBuilder: (context, index) => const SizedBox(
            height: 4,
          ),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return MatchCard(match: liveScore.stage![0].matches![index]);
          },
          itemCount: liveScore.stage![0].matches!.length,
        )
      ],
    );
  }
}
