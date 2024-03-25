import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:live_football_stats/core/injection/injection_container.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/country.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/team.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/team/a_team/team_bloc.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/team/a_team/team_event.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/team/a_team/team_state.dart';
import 'package:live_football_stats/features/main_feature/presentation/pages/team/team_overview_screen.dart';
import 'package:live_football_stats/features/main_feature/presentation/pages/team/team_transfers_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TeamMainView extends StatefulWidget {
  TeamMainView({super.key, required this.teamID});
  int teamID;
  @override
  State<TeamMainView> createState() => _TeamMainViewState();
}

class _TeamMainViewState extends State<TeamMainView>
    with TickerProviderStateMixin {
  TabController? controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TabController(length: 2, vsync: this);
    // sl.get<TeamBloc>().add(TeamFetched(teamID: widget.teamID));
    context.read<TeamBloc>().add(TeamFetched(teamID: widget.teamID));
  }

  Team team = Team(
      country: Country(id: 8, name: "england"),
      id: 4137,
      isNation: false,
      name: "Manchester United",
      stadium: StadiumResponse(id: 12, name: "name", city: "city"));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        child: BlocConsumer<TeamBloc, TeamState>(
          builder: (context, state) {
            if (state is TeamFetchSuccess) {
              print("HEY: ${state.team.id!}");
              return TabBarView(
                controller: controller,
                children: [
                  TeamOverviewScreen(),
                  // TeamOverviewScreen(),
                  // TeamOverviewScreen(),
                  // TeamOverviewScreen(),
                  TeamTransferScreen(
                    teamID: state.team.id!,
                  ),
                ],
              );
            } else if (state is TeamFetchFail) {
              return const Center(
                child: Text("Something went wrong"),
              );
            } else {
              return TabBarView(
                controller: controller,
                children: const [
                  SizedBox(),
                  SizedBox(),
                  // SizedBox(),
                  // SizedBox(),
                  // SizedBox(),
                ],
              );
            }
          },
          listener: (context, state) async {
            if (state is TeamFetchFail) {
              EasyLoading.dismiss();
              EasyLoading.showError("Error");
              await Future.delayed(const Duration(seconds: 2));
              EasyLoading.dismiss();
            } else if (state is TeamLoading) {
              EasyLoading.show();
            } else {
              EasyLoading.dismiss();
            }
          },
        ),
      ),
    );
  }

  PreferredSize buildAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(130),
      child: AppBar(
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
        elevation: 3,
        flexibleSpace: BlocBuilder<TeamBloc, TeamState>(
          builder: (context, state) {
            if (state is TeamFetchSuccess) {
              return Container(
                height: 90,
                child: Center(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      state.team.name!,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    // const SizedBox(
                    //   height: 15,
                    // ),
                    Text(
                      state.team.country!.name!,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                  ],
                )),
              );
            } else if (state is TeamFetchFail) {
              return const SizedBox(
                height: 90,
                child: Center(
                  child: Text(""),
                ),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
        actions: [
          InkWell(
            onTap: () {},
            child: const Icon(
              Icons.star_border_rounded,
              size: 30,
            ),
          ),
          const SizedBox(
            width: 20,
          )
        ],
        bottom: TabBar(
          isScrollable: true,
          labelStyle: TextStyle(color: Colors.black),
          indicatorColor: Colors.greenAccent,
          controller: controller,
          tabs: [
            Tab(
              text: "Overview",
            ),
            // Tab(
            //   text: "Matches",
            // ),
            // Tab(
            //   text: "Table",
            // ),
            // Tab(
            //   text: "Squad",
            // ),
            Tab(
              text: "Transfers",
            ),
          ],
        ),
      ),
    );
  }

  // @override
  // // TODO: implement wantKeepAlive
  // bool get wantKeepAlive => true;
}
