import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/sidelined_player.dart';
import 'package:live_football_stats/features/main_feature/presentation/widgets/matches/pitch_painter.dart';
import 'package:live_football_stats/features/main_feature/presentation/widgets/matches/team_formation.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/match.dart';
import 'package:live_football_stats/core/enums/enum_values.dart';

import '../../../domain/entities/player.dart';

class PitchWidget extends StatelessWidget {
  PitchWidget(
      {super.key,
      required this.formation,
      required this.players,
      required this.benchPlayers,
      this.sidelinedPlayers});
  String formation;
  List<BenchAway> players;
  List<BenchAway> benchPlayers;
  List<SidelinedPlayer>? sidelinedPlayers;
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      shrinkWrap: true,
      slivers: [
        SliverToBoxAdapter(
          child: Stack(
            alignment: Alignment.center,
            children: [
              CustomPaint(
                painter: PitchPainter(),
                // size: Size(MediaQuery.of(context).size.width * 0.85,
                //     MediaQuery.of(context).size.height * 0.7),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  height: MediaQuery.of(context).size.height * 0.7,
                  width: MediaQuery.of(context).size.width * 0.88,
                ),
              ),
              Container(
                // decoration: const BoxDecoration(color: Colors.white),
                padding: const EdgeInsets.symmetric(vertical: 10),
                height: MediaQuery.of(context).size.height * 0.7,
                width: MediaQuery.of(context).size.width * 0.85,
                child: TeamFormation(
                  formation: formation,
                  players: players,
                ),
              ),
            ],
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            padding: const EdgeInsets.only(left: 20, top: 25),
            child: const Text(
              "Bench",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          sliver: SliverList.separated(
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 2,
                      vertical: 3,
                    ),
                    child: Text(benchPlayers[index].position!.name),
                  ),
                  title: Text(
                    benchPlayers[index].player!.name!,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                );
              },
              separatorBuilder: (context, index) => const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Divider(
                      color: Color.fromARGB(153, 189, 188, 188),
                      height: 2,
                    ),
                  ),
              itemCount: benchPlayers.length),
        ),

        sidelinedPlayers != null && sidelinedPlayers!.isNotEmpty
            ? SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.only(left: 20, top: 25),
                  child: const Text(
                    "Sidelined",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                  ),
                ),
              )
            : const SizedBox(),
        sidelinedPlayers != null && sidelinedPlayers!.isNotEmpty
            ? SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                // padding: const EdgeInsets.symmetric(vertical: 10),
                // decoration: const BoxDecoration(color: Colors.white12),
                sliver: SliverList.separated(
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 2,
                          vertical: 3,
                        ),
                        child: Text(sidelinedPlayers![index].status!),
                      ),
                      title: Text(
                        sidelinedPlayers![index].player!.name!,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(sidelinedPlayers![index].desc!),
                    );
                  },
                  itemCount: sidelinedPlayers!.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Divider(
                        color: Color.fromARGB(153, 189, 188, 188),
                        height: 2,
                      ),
                    );
                  },
                ))
            : const SizedBox(),
        // sidelinedPlayers != null && sidelinedPlayers!.isNotEmpty
        //     ?
        //     : const SizedBox()
      ],
    );
  }
}
