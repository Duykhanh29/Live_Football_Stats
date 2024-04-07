import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ionicons/ionicons.dart';
import 'package:live_football_stats/core/constants/app_colors.dart';
import 'package:live_football_stats/core/helper/comon_widget.dart';
import 'package:live_football_stats/core/helper/divider_helper.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/upcoming_match.dart';
import 'package:live_football_stats/features/main_feature/presentation/pages/league/league_main_view.dart';
import 'package:live_football_stats/features/main_feature/presentation/pages/league/league_page.dart';
import 'package:live_football_stats/features/main_feature/presentation/widgets/live_score/upcoming_match_preview_card.dart';

class UpcomingMatchesOfLeagueWidget extends StatelessWidget {
  UpcomingMatchesOfLeagueWidget(
      {super.key, required this.upcomingMatchesOfLeague});
  UpcomingMatchesOfLeague upcomingMatchesOfLeague;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.greyBorder),
          borderRadius: BorderRadius.circular(3)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(left: 10, bottom: 5, top: 5),
            child: Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Text(
                    upcomingMatchesOfLeague.leagueName != null
                        ? "${upcomingMatchesOfLeague.leagueName} (${upcomingMatchesOfLeague.country != null ? upcomingMatchesOfLeague.country!.name ?? "" : ""})"
                        : "",
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.clip,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                ),
                CommonWidget.fowardToLeaguePage(
                    context, upcomingMatchesOfLeague.leagueID),
              ],
            ),
          ),
          upcomingMatchesOfLeague.matchPreviews != null &&
                  upcomingMatchesOfLeague.matchPreviews!.isNotEmpty
              ? ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return UpcomingMatchPreviewCard(
                        matchPreview:
                            upcomingMatchesOfLeague.matchPreviews![index]);
                  },
                  itemCount: upcomingMatchesOfLeague.matchPreviews!.length,
                  separatorBuilder: (context, index) =>
                      DividerHelper.sizedboxDivider(),
                )
              : const Center(
                  child: SizedBox(
                  child: Text("No data"),
                ))
        ],
      ),
    );
  }
}
