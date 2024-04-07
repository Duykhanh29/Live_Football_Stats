import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:live_football_stats/core/constants/app_colors.dart';
import 'package:live_football_stats/core/constants/app_routes_name.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/league.dart';
import 'package:live_football_stats/features/main_feature/presentation/pages/league/league_page.dart';

class TopLeagueCard extends StatelessWidget {
  TopLeagueCard({super.key, required this.league});
  League league;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.of(context).push(MaterialPageRoute(
        //   builder: (context) {
        //     return LeaguePage(
        //       leagueId: league.id,
        //     );
        //   },
        // ));
        context.pushNamed(AppRoutesName.leaguePage, extra: league.id);
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.indigoAccent),
            borderRadius: BorderRadius.circular(20),
            color: AppColors.cardColor),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        height: MediaQuery.of(context).size.height * 0.25,
        width: MediaQuery.of(context).size.width * 0.3,
        child: Stack(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 1, vertical: 2),
                  child: Text(
                    league.name,
                    textAlign: TextAlign.center,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontWeight: FontWeight.w700, fontSize: 18),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 1, vertical: 2),
                  child: Text(
                    league.country.name!,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontWeight: FontWeight.w700, fontSize: 14),
                  ),
                ),
              ],
            ),
            Align(
                alignment: Alignment.topRight,
                child: InkWell(
                  onTap: () {},
                  child: Icon(Icons.star),
                ))
          ],
        ),
      ),
    );
  }
}
