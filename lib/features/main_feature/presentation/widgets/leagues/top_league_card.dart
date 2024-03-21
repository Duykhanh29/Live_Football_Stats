import 'package:flutter/material.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/league.dart';
import 'package:live_football_stats/features/main_feature/presentation/pages/league/league_page.dart';

class TopLeagueCard extends StatelessWidget {
  TopLeagueCard({super.key, required this.league});
  League league;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) {
            return LeaguePage(
              leagueId: league.id,
            );
          },
        ));
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.indigoAccent),
            borderRadius: BorderRadius.circular(20),
            color: Colors.tealAccent),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        height: MediaQuery.of(context).size.height * 0.25,
        width: MediaQuery.of(context).size.width * 0.3,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.35,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
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
                  width: MediaQuery.of(context).size.width * 0.35,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
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
