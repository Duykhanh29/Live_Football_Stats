import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    controller = TabController(length: 3, vsync: this);
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
        title: BlocBuilder<LeagueBloc, LeagueState>(
          builder: (context, state) {
            if (state is LeagueFetchSuccess) {
              return Text(
                state.league!.name,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              );
            } else {
              return Container();
            }
          },
        ),
        bottom: TabBar(
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
            Tab(
              text: "Current",
            )
          ],
          labelStyle: const TextStyle(color: Colors.black),
          indicatorColor: Colors.greenAccent,
          controller: controller,
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
                    MatchedOfLeagueScreen(
                      leagueID: widget.leagueId,
                    )
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
                Center(
                  child: Container(),
                ),
              ]);
            }
          },
        ),
      ),
    );
  }
}
