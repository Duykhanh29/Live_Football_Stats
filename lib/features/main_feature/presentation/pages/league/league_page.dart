import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:live_football_stats/core/constants/app_colors.dart';
import 'package:live_football_stats/core/constants/app_text_style.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/league/a_league/league_bloc.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/league/a_league/league_event.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/league/a_league/league_state.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/nav_bar/nav_league_cubit.dart';

import 'package:live_football_stats/features/main_feature/presentation/pages/league/table_of_league_screen.dart';

import 'matches_of_league_screen.dart';

class LeaguePage extends StatefulWidget {
  LeaguePage({super.key, required this.leagueId});
  int leagueId;

  @override
  State<LeaguePage> createState() => _LeaguePageState();
}

class _LeaguePageState extends State<LeaguePage> with TickerProviderStateMixin {
  TabController? controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<LeagueBloc>().add(LeagueFetchedEvent(widget.leagueId));
    controller = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.secondaryColor,
        centerTitle: true,
        title: BlocBuilder<LeagueBloc, LeagueState>(
          builder: (context, state) {
            if (state is LeagueFetchSuccess) {
              return Text(
                state.league!.name,
                style: AppTextStyles.appBarTexStyle(),
              );
            } else {
              return Container();
            }
          },
        ),
        // flexibleSpace: Column(
        //   mainAxisAlignment: MainAxisAlignment.spaceAround,
        //   children: [
        //     BlocBuilder<LeagueBloc, LeagueState>(
        //       builder: (context, state) {
        //         if (state is LeagueFetchSuccess) {
        //           return Padding(
        //             padding:
        //                 const EdgeInsets.only(top: 10, bottom: 10, left: 15),
        //             child: Text(
        //               state.league!.country.name!,
        //               style: const TextStyle(
        //                   fontSize: 16, fontWeight: FontWeight.w600),
        //             ),
        //           );
        //         } else {
        //           return Container();
        //         }
        //       },
        //     ),
        //   ],
        // ),
        bottom: PreferredSize(
          preferredSize: Size(MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.height * 0.1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BlocBuilder<LeagueBloc, LeagueState>(
                builder: (context, state) {
                  if (state is LeagueFetchSuccess) {
                    return Padding(
                      padding:
                          const EdgeInsets.only(top: 10, bottom: 10, left: 0),
                      child: Text(
                        state.league!.country.name!,
                        style: AppTextStyles.secondAppBarTextStyle(),
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
              TabBar(
                onTap: (value) {
                  context.read<NavLeagueCubit>().updateIndex(value);
                },
                tabs: const [
                  Tab(
                    text: "Macthes",
                  ),
                  Tab(
                    text: "Table",
                  ),
                  // Tab(
                  //   text: "Current",
                  // )
                ],
                labelStyle: AppTextStyles.tabBarTextStyle(),
                indicatorColor: AppColors.lightTabarColor,
                controller: controller,
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 5,
          vertical: 10,
        ),
        child: BlocBuilder<LeagueBloc, LeagueState>(
          builder: (context, state) {
            if (state is LeagueFetchSuccess) {
              return BlocBuilder<NavLeagueCubit, int>(
                builder: (context, state) => TabBarView(
                  controller: controller,
                  children: [
                    MatchedOfLeagueScreen(
                      leagueID: widget.leagueId,
                    ),
                    TableOfLeagueScreen(
                      leagueId: widget.leagueId,
                    ),
                    // MatchedOfLeagueScreen(
                    //   leagueID: widget.leagueId,
                    // )
                  ],
                ),
              );
            } else {
              return TabBarView(controller: controller, children: [
                Center(
                  child: Container(),
                ),
                Center(
                  child: Container(),
                ),
                // Center(
                //   child: Container(),
                // ),
              ]);
            }
          },
        ),
      ),
    );
  }
}
