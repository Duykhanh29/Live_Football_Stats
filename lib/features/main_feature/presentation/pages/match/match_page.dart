import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:live_football_stats/core/enums/enum_values.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/country.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/league_response.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/player.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/stage_response.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/team_response.dart';
import 'package:live_football_stats/features/main_feature/presentation/pages/league/table_of_league_screen.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/match.dart';
import 'package:live_football_stats/features/main_feature/presentation/pages/match/head_to_head_screen.dart';
import 'package:live_football_stats/features/main_feature/presentation/pages/match/key_events_screen.dart';
import 'package:live_football_stats/features/main_feature/presentation/pages/match/lineups_screen.dart';
import 'package:live_football_stats/features/main_feature/presentation/pages/match/match_overview_screen.dart';
import 'package:live_football_stats/features/main_feature/presentation/pages/match/preview_match_screen.dart';

class MatchPage extends StatefulWidget {
  const MatchPage({super.key});

  @override
  State<MatchPage> createState() => _MatchPageState();
}

class _MatchPageState extends State<MatchPage> with TickerProviderStateMixin {
  TabController? tabController;
  Match match = Match(
      stage: StageResponse(id: 234, name: "fas", isActive: true),
      league: LeagueResponse(id: 297, name: "La liga"),
      country: Country(id: 1234, name: "Fdsaf"),
      id: 123,
      date: "12-12-2023",
      time: "12",
      teams: Teams(
          home: TeamResponse(id: 12, name: "dfa"),
          away: TeamResponse(id: 32, name: "dfsfa")),
      stadium: Stadium(id: 34, name: "fdasfsd", city: "yju6"),
      status: MatchStatus.LIVE,
      minute: -1,
      winner: Winner.HOME,
      hasExtraTime: true,
      hasPenalties: false,
      goals: Goals(
          homeHtGoals: 2,
          awayHtGoals: 1,
          homeFtGoals: 1,
          awayFtGoals: 0,
          homeEtGoals: 0,
          awayEtGoals: 0,
          homePenGoals: 0,
          awayPenGoals: 0),
      events: [],
      odds: Odds(
          matchWinner: MatchWinner(home: 2, draw: 3, away: 2),
          overUnder: OverUnder(total: 4, over: 2, under: 2),
          handicap: Handicap(market: 3, home: 2, away: 1),
          lastModifiedTimestamp: 23456),
      lineups: Lineups(
          lineupType: LineupType.LIVE,
          lineups: LineupData(home: [
            BenchAway(
                player: Player(id: 123, name: "name"),
                position: Position.ATTACKER)
          ], away: const []),
          bench: Bench(home: const [], away: const []),
          sidelined: Sidelined(home: [], away: []),
          formation: Formation(home: "4-3-3", away: "4-2-3-1")),
      matchPreview: MatchPreview(
          hasPreview: false, wordCount: 1234, excitementRating: 3));
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 6, vsync: this);
  }

  @override
  void dispose() {
    tabController?.dispose();
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
              titleTextStyle: TextStyle(fontSize: 20),
              toolbarHeight: 160,
              // stretch: true,
              excludeHeaderSemantics: true,
              backgroundColor: Colors.cyan,
              centerTitle: false,
              title: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.purple)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 4,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        child: Text(
                          match.teams!.home!.name,
                          style: const TextStyle(fontWeight: FontWeight.w500),
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                        ),
                      ),
                    ),
                    if (match.status == MatchStatus.LIVE)
                      Expanded(
                          flex: 2,
                          child: Container(
                              child: Text(
                            "${match.goals!.homeFtGoals} - ${match.goals!.awayFtGoals}",
                            textAlign: TextAlign.start,
                          ))),
                    if (match.status != MatchStatus.LIVE)
                      Expanded(
                          flex: 2,
                          child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black)),
                              child: FittedBox(
                                child: Column(
                                  children: [
                                    Text(
                                      "${match.date}",
                                      textAlign: TextAlign.start,
                                    ),
                                    Text(
                                      "${match.time}",
                                      textAlign: TextAlign.start,
                                    ),
                                  ],
                                ),
                              ))),
                    Expanded(
                      flex: 4,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        child: Text(
                          match.teams!.away!.name,
                          style: const TextStyle(fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                        ),
                      ),
                    )
                  ],
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
                    Navigator.of(context).pop();
                  },
                  child: const Icon(
                    Icons.arrow_back_ios,
                    // color: MyTheme.white,
                  ),
                ),
              ),
              flexibleSpace: FlexibleSpaceBar(
                expandedTitleScale: 1.2,
                titlePadding: const EdgeInsets.symmetric(horizontal: 20),
                centerTitle: true,
                title: TabBar(
                  isScrollable: true,
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
                  child: Image.network(
                    'https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcQCD1JTfnXsJQq9hCpfnJ-5TfubGjSWhsfJNkW0Mea7x7yw8XF5',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            // bottom: TabBar(controller: tabController, tabs: const [
            //   Tab(
            //     text: "Overview",
            //   ),
            //   Tab(
            //     text: "Preview",
            //   ),
            //   Tab(
            //     text: "Key events",
            //   ),
            //   Tab(
            //     text: "Lineups",
            //   ),
            //   Tab(
            //     text: "Standing",
            //   ),
            //   Tab(
            //     text: "H2H",
            //   )
            // ]),
            // ),
            SliverFillRemaining(
              hasScrollBody: true,
              child: TabBarView(
                controller: tabController,
                children: [
                  OverviewMatchWidget(
                    matchStatus: match.status!,
                    handicap: match.odds!.handicap,
                    matchWinner: match.odds!.matchWinner,
                    overUnder: match.odds!.overUnder,
                    leagueResponse: match.league!,
                    stadium: match.stadium!,
                    stage: match.stage,
                  ),
                  PreviewMatchScreen(),
                  const KeyEventsScreen(),
                  const LineupScreen(),
                  TableOfLeagueScreen(
                    leagueId: match.league!.id,
                  ),
                  HeadToHeadScreen(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
