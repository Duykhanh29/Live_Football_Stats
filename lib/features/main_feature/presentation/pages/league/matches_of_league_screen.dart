import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:live_football_stats/core/utils/common_method.dart';
import 'package:live_football_stats/core/utils/format_date.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/league_matches.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/match/matches/matches_bloc.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/match/matches/matches_event.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/match/matches/matches_state.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/nav_bar/nav_league_cubit.dart';
import 'package:live_football_stats/features/main_feature/presentation/widgets/matches/match_card.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:sticky_grouped_list/sticky_grouped_list.dart';

import '../../../../../core/helper/error_helper.dart';

class MatchedOfLeagueScreen extends StatefulWidget {
  MatchedOfLeagueScreen({super.key, required this.leagueID});
  int leagueID;

  @override
  State<MatchedOfLeagueScreen> createState() => _MatchedOfLeagueScreenState();
}

class _MatchedOfLeagueScreenState extends State<MatchedOfLeagueScreen> {
  ScrollController _scrollController = ScrollController();
  final GroupedItemScrollController itemScrollController =
      GroupedItemScrollController();
  String currentTime = FormatDate.dateToDateAndTime(DateTime.now());
  double heightSize = 60;
  int currentMatchIndex = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<MatchesBloc>().add(MatchesOfALeagueFetched(widget.leagueID));
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   _scrollToCurrentMatch();
    // });
  }

  void _scrollToIndex(int index) {
    itemScrollController.jumpTo(
      index: index,
      // duration: Duration(milliseconds: 500),
      // curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NavLeagueCubit, int>(listener: (context, state) {
      if (state != 0) {
        EasyLoading.dismiss();
      }
    }, builder: (context, state) {
      if (state == 0) {
        return BlocConsumer<MatchesBloc, MatchesState>(
          builder: (context, state) {
            if (state is MatchesFetchSuccess) {
              int currentIndex = CommonMethods.findCurrentIndexMatch(
                  state.leagueMatches.stage![0].matches!, DateTime.now());
              currentMatchIndex =
                  state.leagueMatches.stage![0].matches!.length - currentIndex;
              print(
                  "Match: ${state.leagueMatches.stage![0].matches![currentMatchIndex].teams!.home!.name} and ${state.leagueMatches.stage![0].matches![currentMatchIndex].teams!.away!.name} and time: ${state.leagueMatches.stage![0].matches![currentMatchIndex].time}");
              print("Total: ${state.leagueMatches.stage![0].matches!.length}");
              // // WidgetsBinding.instance.addPostFrameCallback((_) {
              // //   _scrollToCurrentMatch(
              // //       state.leagueMatches.stage![0].matches!.length);
              // // });
              // itemScrollController.scrollTo(
              //     index: currentMatchIndex, duration: Duration(seconds: 2));
              // itemScrollController.jumpTo(index: currentMatchIndex);
              WidgetsBinding.instance.addPostFrameCallback((_) {
                _scrollToIndex(currentMatchIndex);
              });

              return StickyGroupedListView<LeagueMatch, DateTime>(
                initialScrollIndex: currentMatchIndex,
                itemScrollController: itemScrollController,
                elements: state.leagueMatches.stage![0].matches!,
                groupBy: (leagueMatch) {
                  return DateTime(
                      FormatDate.dateTimeStringToDate(leagueMatch.date!).year,
                      FormatDate.dateTimeStringToDate(leagueMatch.date!).month,
                      FormatDate.dateTimeStringToDate(leagueMatch.date!).day);
                },
                groupSeparatorBuilder: (element) {
                  return Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    padding: const EdgeInsets.only(top: 20),
                    // height: 35,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 209, 246, 251)),
                          child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Text(element.date!)),
                        ),
                      ],
                    ),
                  );
                },
                itemComparator: (leagueMatch1, leagueMatch2) => FormatDate
                        .dateTimeStringToDate(leagueMatch1.date!)
                    .compareTo(
                        FormatDate.dateTimeStringToDate(leagueMatch2.date!)),
                reverse: true,
                physics: const BouncingScrollPhysics(),
                // floatingHeader: true,
                order: StickyGroupedListOrder.DESC,
                itemBuilder: (context, element) {
                  return MatchCard(
                    match: element,
                    heightSize: heightSize,
                  );
                },
              );
            } else if (state is MatchesLoading) {
              return Container();
            } else if (state is InitialMatches) {
              return Container();
            } else {
              return ErrorHelper.basicErrorWidget();
            }
          },
          listener: (context, state) {
            if (state is MatchesLoading) {
              EasyLoading.show(status: 'Loading...');
            } else {
              EasyLoading.dismiss();
            }
          },
        );
      } else {
        return Container();
      }
    });
  }
}
