import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:live_football_stats/core/constants/app_colors.dart';
import 'package:live_football_stats/core/constants/app_routes_name.dart';
import 'package:live_football_stats/core/constants/app_text_style.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/favourite/favourite_league_entity.dart';

class AFavouriteLeagueCard extends StatelessWidget {
  AFavouriteLeagueCard({super.key, required this.league});
  LeagueDataEntity league;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        int leagueID = int.parse(league.leagueID!);
        context.pushNamed(AppRoutesName.leaguePage, extra: leagueID);
      },
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(3),
        height: MediaQuery.of(context).size.height * 0.15,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.appBorder, width: 2),
            color: AppColors.secondaryColor),
        child: Text(
          league.leagueName ?? "",
          style: AppTextStyles.commonTextStyle(),
          textAlign: TextAlign.center,
          overflow: TextOverflow.clip,
        ),
      ),
    );
  }
}
