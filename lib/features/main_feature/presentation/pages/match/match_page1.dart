import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:live_football_stats/core/constants/app_colors.dart';
import 'package:live_football_stats/core/constants/app_routes_name.dart';
import 'package:live_football_stats/core/constants/app_text_style.dart';
import 'package:live_football_stats/core/constants/image_data.dart';
import 'package:live_football_stats/core/enums/enum_values.dart';
import 'package:live_football_stats/core/helper/error_helper.dart';
import 'package:live_football_stats/core/injection/injection_container.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/country.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/league_response.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/player.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/stage_response.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/team_response.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/match/a_match/match_bloc.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/match/a_match/match_event.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/match/a_match/match_state.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/match/preview_match/preview_match_event.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/match/preview_match/preview_match_state.dart';
import 'package:live_football_stats/features/main_feature/presentation/pages/league/table_of_league_screen.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/match.dart';
import 'package:live_football_stats/features/main_feature/presentation/pages/match/head_to_head_screen.dart';
import 'package:live_football_stats/features/main_feature/presentation/pages/match/key_events_screen.dart';
import 'package:live_football_stats/features/main_feature/presentation/pages/match/lineups_screen.dart';
import 'package:live_football_stats/features/main_feature/presentation/pages/match/match_overview_screen.dart';
import 'package:live_football_stats/features/main_feature/presentation/pages/match/preview_match_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:live_football_stats/features/main_feature/presentation/pages/team/team_main_view.dart';

import '../../../../../core/error/failures.dart';
import '../../blocs/match/preview_match/preview_match_bloc.dart';

class MatchPage1 extends StatefulWidget {
  MatchPage1({super.key, required this.matchId});
  int matchId;

  @override
  State<MatchPage1> createState() => _MatchPageState();
}

class _MatchPageState extends State<MatchPage1> with TickerProviderStateMixin {
  TabController? tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 6, vsync: this);
    BlocProvider.of<MatchBloc>(context).add(MatchFetched(widget.matchId));
    BlocProvider.of<PreviewMatchBloc>(context)
        .add(PreviewMatchFetched(widget.matchId));
  }

  @override
  void dispose() {
    tabController?.dispose();
    sl.get<MatchBloc>().close();
    sl.get<MatchBloc>().close();
    // BlocProvider.of<MatchBloc>(context).close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              titleTextStyle: AppTextStyles.appBarTexStyle(),
              toolbarHeight: 160,
              // stretch: true,
              excludeHeaderSemantics: true,
              backgroundColor: AppColors.backgroundColor,
              centerTitle: false,
              title: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                // decoration:
                //     BoxDecoration(border: Border.all(color: Colors.purple)),
                child: BlocBuilder<MatchBloc, MatchState>(
                  builder: (context, state) {
                    if (state is MatchFetchSuccess) {
                      return StreamBuilder(
                          stream: sl.get<MatchBloc>().liveMatchStream,
                          builder: (context, snapshot) {
                            print(
                                "connectionState is: ${snapshot.connectionState}");
                            print("data is ${snapshot.data}");
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const SizedBox();
                            } else if (snapshot.connectionState ==
                                    ConnectionState.done ||
                                snapshot.connectionState ==
                                    ConnectionState.active) {
                              if (snapshot.hasData && snapshot.data != null) {
                                print("Olahhelo1");
                                Match theMatch = snapshot.data as Match;
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      flex: 4,
                                      child: GestureDetector(
                                        onTap: () {
                                          context.pushNamed(
                                              AppRoutesName.teamPage,
                                              extra: theMatch.teams!.home!.id);
                                          // Navigator.of(context).push(MaterialPageRoute(
                                          //   builder: (context) {
                                          //     return TeamMainView(
                                          //         teamID: state.match!.teams!.home!.id);
                                          //   },
                                          // ));
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(2),
                                          child: Text(
                                            theMatch.teams!.home!.name,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w500),
                                            textAlign: TextAlign.start,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 3,
                                          ),
                                        ),
                                      ),
                                    ),
                                    if (state.match!.status == MatchStatus.LIVE)
                                      Expanded(
                                          flex: 2,
                                          child: Container(
                                              child: Text(
                                            "${theMatch.goals!.homeFtGoals} - ${theMatch.goals!.awayFtGoals}",
                                            textAlign: TextAlign.start,
                                            style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400),
                                          ))),
                                    if (theMatch.status != MatchStatus.LIVE &&
                                        theMatch.status != MatchStatus.FINISHED)
                                      Expanded(
                                          flex: 2,
                                          child: Container(
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black)),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    "${theMatch.date}",
                                                    textAlign: TextAlign.start,
                                                    style: const TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                  Text(
                                                    "${theMatch.time}",
                                                    textAlign: TextAlign.start,
                                                    style: const TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ],
                                              ))),
                                    if (theMatch.status == MatchStatus.FINISHED)
                                      Expanded(
                                          flex: 2,
                                          child: Container(
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.black)),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "${theMatch.goals!.homeFtGoals}",
                                                    textAlign: TextAlign.start,
                                                    style: const TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                  const Text("-"),
                                                  Text(
                                                    "${theMatch.goals!.awayFtGoals}",
                                                    textAlign: TextAlign.start,
                                                    style: const TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ],
                                              ))),
                                    Expanded(
                                      flex: 4,
                                      child: GestureDetector(
                                        onTap: () {
                                          // Navigator.of(context).push(MaterialPageRoute(
                                          //   builder: (context) {
                                          //     return TeamMainView(
                                          //         teamID: state.match!.teams!.away!.id);
                                          //   },
                                          // ));
                                          context.pushNamed(
                                              AppRoutesName.teamPage,
                                              extra: theMatch.teams!.away!.id);
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(2),
                                          child: Text(
                                            theMatch.teams!.away!.name,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w500),
                                            textAlign: TextAlign.center,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 3,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                );
                              } else {
                                return const Text("Error");
                              }
                            } else {
                              return const SizedBox(
                                child: Text("OKOKOKOKOKOK"),
                              );
                            }
                          });
                    } else if (state is MatchFetchFail) {
                      return const Text("Error");
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              ),
              actions: [
                InkWell(
                  onTap: () {},
                  child: Icon(Icons.star_rounded),
                ),
                const SizedBox(
                  width: 10,
                )
              ],
              // onStretchTrigger: () {

              // },
              expandedHeight: 200,
              // forceElevated: true,
              pinned: true,
              floating: true,
              leading: Container(
                // padding: const EdgeInsets.only(top: 15),
                width: 40,
                height: 40,

                child: InkWell(
                  onTap: () {
                    //        Navigator.of(context).pop();
                    context.pop();
                  },
                  child: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                ),
              ),
              flexibleSpace: FlexibleSpaceBar(
                expandedTitleScale: 1.2,
                titlePadding: const EdgeInsets.symmetric(horizontal: 20),
                centerTitle: true,
                title: TabBar(
                  labelStyle: AppTextStyles.tabBarTextStyle(),
                  isScrollable: true,
                  dividerColor: AppColors.lightTabarColor,
                  controller: tabController,
                  tabs: const [
                    Tab(
                      text: "Overview",
                    ),
                    Tab(
                      text: "Preview",
                    ),
                    Tab(
                      text: "Key events",
                    ),
                    Tab(
                      text: "Lineups",
                    ),
                    Tab(
                      text: "Standing",
                    ),
                    Tab(
                      text: "H2H",
                    )
                  ],
                ),
                background: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0),
                  ),
                  child: Image.asset(
                    ImageData.footballImage,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: true,
              child: BlocConsumer<MatchBloc, MatchState>(
                builder: (context, state) {
                  if (state is MatchFetchSuccess) {
                    return StreamBuilder(
                        stream: sl.get<MatchBloc>().liveMatchStream,
                        builder: (context, snapshot) {
                          print(
                              "connectionState is: ${snapshot.connectionState}");
                          print("data is ${snapshot.data}");
                          if (snapshot.connectionState ==
                                  ConnectionState.done ||
                              snapshot.connectionState ==
                                  ConnectionState.active) {
                            Match? theMatch = snapshot.data;
                            if (snapshot.hasData && snapshot.data != null) {
                              print("Olahhelo");
                              return TabBarView(
                                controller: tabController,
                                children: [
                                  OverviewMatchWidget(
                                    matchStatus: theMatch!.status!,
                                    handicap: theMatch.odds!.handicap,
                                    matchWinner: theMatch.odds!.matchWinner,
                                    overUnder: theMatch.odds!.overUnder,
                                    leagueResponse: theMatch.league,
                                    stadium: theMatch.stadium,
                                    stage: theMatch.stage,
                                  ),
                                  BlocBuilder<PreviewMatchBloc,
                                          PreviewMatchState>(
                                      builder: (context, state) {
                                    if (state is MatchPreviewFetchSuccess) {
                                      return PreviewMatchScreen(
                                        matchPreview: state.match,
                                      );
                                    } else if (state is PreviewMatchFetchFail) {
                                      return ErrorHelper.basicErrorWidget();
                                    } else {
                                      return const SizedBox(
                                        child: Text("À oke oke oke oke"),
                                      );
                                    }
                                  }),
                                  KeyEventsScreen(
                                    listEvent: theMatch.events!,
                                  ),
                                  LineupScreen(
                                    lineups: theMatch.lineups!,
                                  ),
                                  TableOfLeagueScreen(
                                    leagueId: theMatch.league!.id,
                                  ),
                                  HeadToHeadScreen(
                                      team1Id: theMatch.teams!.home!.id,
                                      team2Id: theMatch.teams!.away!.id),
                                ],
                              );
                            } else {
                              return ErrorHelper.basicErrorWidget();
                            }
                          } else {
                            return const SizedBox(
                              child: Text("Naniiiii"),
                            );
                          }
                        });
                  } else if (state is MatchFetchFail) {
                    if (state.failure != null) {
                      if (state.failure is TooManyRequestsFailure) {
                        return ErrorHelper.errorWidgetWithMsg(
                            state.failure!.message!);
                      }
                    }
                    return ErrorHelper.basicErrorWidget();
                  } else {
                    return const SizedBox(
                      child: Text("Hellowwwwww"),
                    );
                  }
                },
                listener: (context, state) async {
                  if (state is MatchLoading) {
                    EasyLoading.show();
                  } else if (state is MatchFetchFail) {
                    EasyLoading.dismiss();
                    EasyLoading.showError("An error has occurred");
                    EasyLoading.dismiss();
                  } else {
                    EasyLoading.dismiss();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
