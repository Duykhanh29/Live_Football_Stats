import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/head_to_head.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/team_response.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/match/head_to_head/head_to_head_bloc.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/match/head_to_head/head_to_head_event.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/match/head_to_head/head_to_head_state.dart';

import '../../widgets/matches/head_to_head_overall_widget.dart';

class HeadToHeadScreen extends StatefulWidget {
  HeadToHeadScreen({super.key, required this.team1Id, required this.team2Id});
  int team1Id, team2Id;
  @override
  State<HeadToHeadScreen> createState() => _HeadToHeadScreenState();
}

class _HeadToHeadScreenState extends State<HeadToHeadScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<HeadToHeadBloc>(context).add(
        HeadToHeadFetched(team1ID: widget.team1Id, team2ID: widget.team2Id));
  }

  // HeadToHead headToHead = HeadToHead(
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HeadToHeadBloc, HeadToHeadState>(
      builder: (context, state) {
        if (state is HeadToHeadFetchSuccess) {
          return Container(
            padding: const EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  HeadToHeadWidget(
                      draw: state.headToHead.stats!.overall!.overallDraws!,
                      name: "Overall",
                      team1Wins:
                          state.headToHead.stats!.overall!.overallTeam1Wins!,
                      team2Wins:
                          state.headToHead.stats!.overall!.overallTeam2Wins!,
                      team1Scored:
                          state.headToHead.stats!.overall!.overallTeam1Scored!,
                      team2Scored:
                          state.headToHead.stats!.overall!.overallTeam2Scored!,
                      totalGames:
                          state.headToHead.stats!.overall!.overallGamesPlayed!,
                      team1: state.headToHead.team1!,
                      team2: state.headToHead.team2!),
                  HeadToHeadWidget(
                      draw: state
                          .headToHead.stats!.team1AtHome!.team1DrawsAtHome!,
                      name: "${state.headToHead.team1!.name} at home",
                      team1Wins:
                          state.headToHead.stats!.team1AtHome!.team1WinsAtHome!,
                      team2Wins: state
                          .headToHead.stats!.team1AtHome!.team1LossesAtHome!,
                      team1Scored: state
                          .headToHead.stats!.team1AtHome!.team1ScoredAtHome!,
                      team2Scored: state
                          .headToHead.stats!.team1AtHome!.team1ConcededAtHome!,
                      totalGames: state.headToHead.stats!.team1AtHome!
                          .team1GamesPlayedAtHome!,
                      team1: state.headToHead.team1!,
                      team2: state.headToHead.team2!),
                  HeadToHeadWidget(
                      draw: state
                          .headToHead.stats!.team2AtHome!.team2DrawsAtHome!,
                      name: "${state.headToHead.team2!.name} at home",
                      team1Wins:
                          state.headToHead.stats!.team2AtHome!.team2WinsAtHome!,
                      team2Wins: state
                          .headToHead.stats!.team2AtHome!.team2LossesAtHome!,
                      team1Scored: state
                          .headToHead.stats!.team2AtHome!.team2ScoredAtHome!,
                      team2Scored: state
                          .headToHead.stats!.team2AtHome!.team2ConcededAtHome!,
                      totalGames: state.headToHead.stats!.team2AtHome!
                          .team2GamesPlayedAtHome!,
                      team1: state.headToHead.team1!,
                      team2: state.headToHead.team2!),
                ],
              ),
            ),
          );
        } else if (state is HeadToHeadFetchFail) {
          return Center(
            child: Text(state.message ?? ""),
          );
        } else {
          return const SizedBox();
        }
      },
      listener: (context, state) {
        if (state is HeadToHeadLoading) {
          EasyLoading.show();
        } else {
          EasyLoading.dismiss();
        }
      },
    );
  }
}
