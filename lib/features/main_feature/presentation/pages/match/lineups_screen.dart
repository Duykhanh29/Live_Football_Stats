import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:live_football_stats/core/constants/app_colors.dart';
import 'package:live_football_stats/core/enums/enum_values.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/match.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/player.dart';
import 'package:live_football_stats/features/main_feature/presentation/widgets/matches/pitch_widget.dart';

import '../../../../../core/constants/app_text_style.dart';

class LineupScreen extends StatefulWidget {
  LineupScreen({super.key, required this.lineups});
  Lineups lineups;
  @override
  State<LineupScreen> createState() => _LineupScreenState();
}

class _LineupScreenState extends State<LineupScreen>
    with TickerProviderStateMixin {
  TabController? controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  List<BenchAway> players = [
    BenchAway(
        player: Player(id: 123, name: " David De Gea"),
        position: Position.GOALKEEPER),
    BenchAway(
        player: Player(id: 1232, name: "Theo Hernández"),
        position: Position.DEFENDER),
    BenchAway(
        player: Player(id: 1231, name: "Sergio Ramos"),
        position: Position.DEFENDER),
    BenchAway(
        player: Player(id: 1234, name: "Aymeric Laporte"),
        position: Position.DEFENDER),
    BenchAway(
        player: Player(id: 123, name: "Achraf Hakimi"),
        position: Position.DEFENDER),
    BenchAway(
        player: Player(id: 123, name: "Luka Modric"),
        position: Position.MIDFIELDER),
    BenchAway(
        player: Player(id: 123, name: "Toni Kroos"),
        position: Position.MIDFIELDER),
    BenchAway(
        player: Player(id: 123, name: "Federico Valverde"),
        position: Position.MIDFIELDER),
    BenchAway(
        player: Player(id: 123, name: "Kylian Mbappé"),
        position: Position.ATTACKER),
    BenchAway(
        player: Player(id: 123, name: "Harry Kane"),
        position: Position.ATTACKER),
    BenchAway(
        player: Player(id: 123, name: " Leroy Sané"),
        position: Position.ATTACKER),
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          TabBar(
            labelStyle: AppTextStyles.tabBarTextStyle(),
            indicatorColor: AppColors.lightTabarColor,
            labelColor: AppColors.secondaryColor,
            controller: controller,
            mouseCursor: MouseCursor.defer,
            splashBorderRadius: BorderRadius.circular(5),
            tabs: const [
              Tab(
                text: "Home",
              ),
              Tab(
                text: "Away",
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              physics: BouncingScrollPhysics(),
              controller: controller,
              children: [
                PitchWidget(
                  formation: widget.lineups.formation!.home!,
                  players: widget.lineups.lineups!.home,
                  benchPlayers: widget.lineups.bench!.home,
                  sidelinedPlayers: widget.lineups.sidelined?.home,
                ),
                PitchWidget(
                  formation: widget.lineups.formation!.away!,
                  players: widget.lineups.lineups!.away,
                  benchPlayers: widget.lineups.bench!.away,
                  sidelinedPlayers: widget.lineups.sidelined?.away,
                ),
                // Text("data1"),
                // Text("data")
              ],
            ),
          ),
        ],
      ),
    );
  }
}
