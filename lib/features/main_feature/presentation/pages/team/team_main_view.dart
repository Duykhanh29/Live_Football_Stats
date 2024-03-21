import 'package:flutter/material.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/country.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/team.dart';
import 'package:live_football_stats/features/main_feature/presentation/pages/team/team_overview_screen.dart';
import 'package:live_football_stats/features/main_feature/presentation/pages/team/team_transfers_screen.dart';

class TeamMainView extends StatefulWidget {
  TeamMainView({super.key});

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
    controller = TabController(length: 5, vsync: this);
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
        child: TabBarView(
          controller: controller,
          children: [
            TeamOverviewScreen(),
            TeamOverviewScreen(),
            TeamOverviewScreen(),
            TeamOverviewScreen(),
            TeamTransferScreen(
              teamID: team.id!,
            ),
          ],
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
        flexibleSpace: Container(
          height: 90,
          child: Center(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                team.name!,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              // const SizedBox(
              //   height: 15,
              // ),
              Text(
                team.country!.name!,
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
            ],
          )),
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
            Tab(
              text: "Matches",
            ),
            Tab(
              text: "Table",
            ),
            Tab(
              text: "Squad",
            ),
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
