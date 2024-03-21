import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:live_football_stats/core/enums/enum_values.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/league_matches.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/match/a_match/match_bloc.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/match/a_match/match_state.dart';

class MatchCard extends StatelessWidget {
  MatchCard({super.key, required this.match, this.heightSize = 70});
  LeagueMatch match;
  double heightSize;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.indigo),
          borderRadius: BorderRadius.circular(10)),
      height: heightSize,
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (match.status == MatchStatus.LIVE)
              Expanded(
                flex: 1,
                child: Text(
                  match.time!,
                  style: const TextStyle(fontSize: 12, color: Colors.green),
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
                decoration: BoxDecoration(color: Colors.pink),
                padding: const EdgeInsets.all(1),
                child: Text(
                  textAlign: TextAlign.center,
                  match.teams!.home!.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 16),
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
                  decoration: BoxDecoration(color: Colors.green),
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
                  decoration: BoxDecoration(color: Colors.green),
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
                decoration: BoxDecoration(color: Colors.pink),
                padding: const EdgeInsets.all(1),
                child: Text(
                  match.teams!.away!.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 16),
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
    );
  }
}
