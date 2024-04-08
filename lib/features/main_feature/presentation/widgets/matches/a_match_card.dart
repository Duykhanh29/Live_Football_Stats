import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:live_football_stats/core/enums/enum_values.dart';
import 'package:live_football_stats/core/helper/error_helper.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/match/a_match/match_bloc.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/match/a_match/match_state.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/match.dart';

class AMatchCard extends StatelessWidget {
  AMatchCard({super.key, required this.match});
  Match match;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MatchBloc, MatchState>(
      builder: (context, state) {
        if (state is MatchLoading) {
          return const SizedBox();
        } else if (state is MatchFetchSuccess) {
          return Container(
            height: 70,
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (match.status == MatchStatus.LIVE)
                  Text(
                    match.time!,
                    style: const TextStyle(fontSize: 12, color: Colors.green),
                  ),
                const SizedBox(
                  width: 30,
                ),
                Text(
                  match.teams!.home!.name,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(
                  width: 10,
                ),
                if (match.status == MatchStatus.LIVE ||
                    match.status == MatchStatus.FINISHED)
                  // Text(
                  //     "${match.goals.homeFtGoals} - ${match.goals.awayFtGoals}"),
                  if (match.status != MatchStatus.LIVE &&
                      match.status != MatchStatus.FINISHED)
                    Text(match.time!),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  match.teams!.away!.name,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(
                  width: 30,
                ),
              ],
            ),
          );
        } else {
          return ErrorHelper.basicErrorWidget();
        }
      },
    );
  }
}
