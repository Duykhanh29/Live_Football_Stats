import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';
import 'package:live_football_stats/core/constants/app_colors.dart';
import 'package:live_football_stats/core/constants/app_routes_name.dart';
import 'package:live_football_stats/core/enums/enum_values.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/live_score.dart';
import 'package:live_football_stats/features/main_feature/presentation/pages/match/match_page.dart';

class MatchCard extends StatelessWidget {
  MatchCard({super.key, required this.match});
  Match match;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.of(context).push(MaterialPageRoute(
        //   builder: (context) {
        //     return MatchPage(matchId: match.id!);
        //   },
        // ));
        context.pushNamed(AppRoutesName.matchPage,
            pathParameters: {'id': "${match.id}"});
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.indigo),
            borderRadius: BorderRadius.circular(10)),
        height: 70,
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (match.status == MatchStatus.LIVE)
                Expanded(
                  flex: 1,
                  child: Text(
                    textAlign: TextAlign.center,
                    match.minute != null ? "${match.minute}'" : "",
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ),

              if (match.status != MatchStatus.LIVE)
                const Expanded(flex: 1, child: SizedBox()),
              // const SizedBox(
              //   width: 30,
              // ),
              Expanded(
                flex: 4,
                child: Container(
                  // decoration: BoxDecoration(color: Colors.pink),
                  padding: const EdgeInsets.all(1),
                  child: Text(
                    textAlign: TextAlign.center,
                    match.teams!.home!.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              // const SizedBox(
              //   width: 10,
              // ),
              if (match.status == MatchStatus.LIVE ||
                  match.status == MatchStatus.FINISHED)
                Expanded(
                  flex: 2,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        border: Border.all(color: AppColors.greyBorder)),
                    child: Text(
                        "${match.goals!.homeFtGoals} - ${match.goals!.awayFtGoals}",
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 14)),
                  ),
                ),
              if (match.status != MatchStatus.LIVE &&
                  match.status != MatchStatus.FINISHED)
                Expanded(
                  flex: 2,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        border: Border.all(color: AppColors.greyBorder)),
                    child: Text(
                      textAlign: TextAlign.center,
                      match.time!,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                ),
              // const SizedBox(
              //   width: 10,
              // ),
              Expanded(
                flex: 4,
                child: Container(
                  //  decoration: BoxDecoration(color: Colors.pink),
                  padding: const EdgeInsets.all(1),
                  child: Text(
                    match.teams!.away!.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              // const SizedBox(
              //   width: 30,
              // ),
              const Expanded(flex: 1, child: SizedBox()),
            ],
          ),
        ),
      ),
    );
  }
}
