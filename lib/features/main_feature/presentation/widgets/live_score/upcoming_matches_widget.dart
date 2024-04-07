import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:live_football_stats/core/helper/error_helper.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/match/upcoming_matches/upcoming_matches_bloc.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/match/upcoming_matches/upcoming_matches_state.dart';
import 'package:live_football_stats/features/main_feature/presentation/widgets/live_score/upcoming_matches_of_league_widget.dart';

import '../../../../../core/helper/divider_helper.dart';

class UpcomingMatchesWidget extends StatelessWidget {
  const UpcomingMatchesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UpcomingMatchesBloc, UpcomingMatchesState>(
      builder: (context, state) {
        if (state is UpcomingMatchesFetchSuccess) {
          if (state.upcomingMatches.count != null &&
              state.upcomingMatches.count != 0 &&
              state.upcomingMatches.results != null &&
              state.upcomingMatches.results!.isNotEmpty) {
            return ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return UpcomingMatchesOfLeagueWidget(
                      upcomingMatchesOfLeague:
                          state.upcomingMatches.results![index]);
                },
                separatorBuilder: (context, index) =>
                    DividerHelper.sizedboxDivider(),
                itemCount: state.upcomingMatches.results!.length);
          }
          return const Center(
            child: Text("No data"),
          );
        } else if (state is UpcomingMatchesFetchFail) {
          return ErrorHelper.basicErrorWidget();
        } else {
          return const SizedBox();
        }
      },
      listener: (context, state) {
        if (state is UpcomingMatchesLoading) {
          EasyLoading.show();
        } else {
          EasyLoading.dismiss();
        }
      },
    );
  }
}
