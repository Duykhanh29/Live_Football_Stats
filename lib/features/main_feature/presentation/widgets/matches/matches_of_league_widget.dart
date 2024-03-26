import 'package:flutter/material.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/league_matches.dart';
import 'package:live_football_stats/features/main_feature/presentation/widgets/matches/match_card.dart';

class MatchesOfLeagueWidget extends StatelessWidget {
  MatchesOfLeagueWidget({super.key, required this.leagueMatches});
  LeagueMatches leagueMatches;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.cyanAccent.shade200,
          borderRadius: BorderRadius.circular(10)),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Text(leagueMatches.leagueName ?? ""),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return MatchCard(
                    match: leagueMatches.stage![0].matches![index]);
              },
              itemCount: leagueMatches.stage![0].matches!.length,
            )
          ],
        ),
      ),
    );
  }
}
