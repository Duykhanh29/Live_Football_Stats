import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:live_football_stats/core/constants/app_text_style.dart';
import 'package:live_football_stats/core/helper/error_helper.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/live_score.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/live_score/live_score_bloc.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/live_score/live_score_state.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/match/matches_by_date/matches_by_date_bloc.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/match/matches_by_date/matches_by_day_state.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/nav_bar/nav_bar_cubit.dart';
import 'package:live_football_stats/features/main_feature/presentation/widgets/live_score/live_score_card.dart';

import '../matches/matches_of_league_widget.dart';

class LiveScoreWidget extends StatelessWidget {
  const LiveScoreWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // shrinkWrap: true,
          children: [
            // const SliverToBoxAdapter(
            //   child:
            Padding(
              padding: const EdgeInsets.only(left: 10, bottom: 10),
              child: Text(
                "Live matches",
                style: AppTextStyles.headingTextStyle(),
              ),
            ),
            // ),
            BlocBuilder<NavbarCubit, int>(
              builder: (context, state) {
                if (state == 1) {
                  return BlocConsumer<LiveScoreBloc, LiveScoreState>(
                    builder: (context, state) {
                      if (state is LiveScoreFetchSuccess) {
                        List<LiveScore>? list = state.liveScore;
                        if (list != null && list.isNotEmpty) {
                          return ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                              height: 10,
                            ),
                            itemBuilder: (context, index) {
                              return LiveScoreCard(
                                liveScore: list[index],
                              );
                            },
                            itemCount: list.length,
                          );
                        } else {
                          return const
                              //  SliverToBoxAdapter(
                              //   child:
                              Center(
                                  child: SizedBox(
                            child: Text("No match"),
                          )
                                  // ),
                                  );
                        }
                      } else if (state is LiveScoreFetchFail) {
                        return ErrorHelper.basicErrorWidget();
                        //  SliverToBoxAdapter(
                        //   child:
                      } else {
                        return const
                            // SliverToBoxAdapter(
                            // child:
                            SizedBox();
                        // );
                      }
                    },
                    listener: (context, state) {
                      if (state is LiveScoreLoading) {
                        EasyLoading.show();
                      } else {
                        EasyLoading.dismiss();
                      }
                    },
                  );
                } else {
                  return const SizedBox();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
