import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:live_football_stats/core/constants/app_colors.dart';
import 'package:live_football_stats/core/constants/app_text_style.dart';
import 'package:live_football_stats/core/error/failures.dart';
import 'package:live_football_stats/core/helper/error_helper.dart';
import 'package:live_football_stats/core/utils/format_date.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/match/matches_by_date/matches_by_date_bloc.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/match/matches_by_date/matches_by_date_event.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/match/matches_by_date/matches_by_day_state.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/nav_bar/nav_bar_cubit.dart';
import 'package:live_football_stats/features/main_feature/presentation/widgets/matches/matches_of_league_widget.dart';

class MatchesMainView extends StatelessWidget {
  MatchesMainView({super.key});

  final EasyInfiniteDateTimelineController _controller =
      EasyInfiniteDateTimelineController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.secondaryColor,
        title: Text(
          "Matches",
          style: AppTextStyles.appBarTexStyle(),
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<NavbarCubit, int>(
        builder: (context, state) {
          if (state == 0) {
            return RefreshIndicator(
              onRefresh: () async {},
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: EasyDateTimeLine(
                      initialDate: DateTime.now(),
                      dayProps: const EasyDayProps(
                        landScapeMode: false,
                        dayStructure: DayStructure.dayStrDayNumMonth,
                        todayHighlightStyle: TodayHighlightStyle.withBackground,
                        // todayHighlightColor: AppColors.secondaryColor,
                        inactiveDayStyle: DayStyle(
                          borderRadius: 48.0,
                          dayNumStyle: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                        activeDayStyle: DayStyle(
                          dayNumStyle: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      activeColor: AppColors.backgroundColor,
                      // firstDate: DateTime(2023, 12, 12),
                      // focusDate: DateTime.now(),
                      // lastDate: DateTime(2024, 12, 12),
                      // controller: _controller,
                      onDateChange: (selectedDate) {
                        print("Date new: ${selectedDate}");
                        String date =
                            FormatDate.dateToDateAndTime2(selectedDate);
                        print("Expected date: ${date}");
                        BlocProvider.of<MatchesByDateBloc>(context)
                            .add(MatchesByDateFetched(date));
                      },
                    ),
                  ),
                  BlocConsumer<MatchesByDateBloc, MatchesByDateState>(
                    listener: (context, state) {
                      if (state is MatchesByDateLoading) {
                        EasyLoading.show();
                      } else {
                        EasyLoading.dismiss();
                      }
                    },
                    builder: (context, state) {
                      if (state is MatchesByDateFetchSuccess) {
                        return SliverList.separated(
                            itemBuilder: (context, index) {
                              if (index == 0) {
                                return Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: MatchesOfLeagueWidget(
                                    leagueMatches:
                                        state.listLeagueMatches[index],
                                  ),
                                );
                              } else if (index ==
                                  state.listLeagueMatches.length - 1) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: MatchesOfLeagueWidget(
                                    leagueMatches:
                                        state.listLeagueMatches[index],
                                  ),
                                );
                              }
                              return MatchesOfLeagueWidget(
                                leagueMatches: state.listLeagueMatches[index],
                              );
                            },
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                                  height: 10,
                                ),
                            itemCount: state.listLeagueMatches.length);
                      } else if (state is MatchesByDateFetchFail) {
                        if (state.failure != null) {
                          if (state.failure is TooManyRequestsFailure) {
                            return SliverToBoxAdapter(
                              child: ErrorHelper.errorWidgetWithMsg(
                                  state.failure!.message!),
                            );
                          }
                        }
                        return SliverToBoxAdapter(
                          child: ErrorHelper.basicErrorWidget(),
                        );
                      } else {
                        return const SliverToBoxAdapter(child: SizedBox());
                      }
                    },
                  ),
                ],
              ),
            );
          } else {
            return const SizedBox();
          }
        },
        listener: (context, state) {
          if (state != 0) {
            EasyLoading.dismiss();
          }
        },
      ),
    );
  }
}
