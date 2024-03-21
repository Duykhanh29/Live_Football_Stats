import 'package:flutter/material.dart';
import 'package:live_football_stats/core/enums/enum_values.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/match.dart';
import 'package:live_football_stats/features/main_feature/presentation/widgets/matches/a_match_card.dart';

class LatestMatchWidget extends StatelessWidget {
  LatestMatchWidget({super.key, required this.match});
  Match match;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (match.status == MatchStatus.LIVE)
            Text(MatchStatus.LIVE.toString()),
          if (match.status != MatchStatus.LIVE) Text("Next Match"),
          Text(match.stage!.name),
          AMatchCard(
            match: match,
          ),
        ],
      ),
    );
  }
}
