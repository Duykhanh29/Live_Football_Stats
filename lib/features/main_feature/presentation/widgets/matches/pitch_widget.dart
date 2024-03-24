import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:live_football_stats/features/main_feature/presentation/widgets/matches/pitch_painter.dart';
import 'package:live_football_stats/features/main_feature/presentation/widgets/matches/team_formation.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/match.dart';
import 'package:live_football_stats/core/enums/enum_values.dart';

import '../../../domain/entities/player.dart';

class PitchWidget extends StatelessWidget {
  PitchWidget({super.key, required this.formation, required this.players});
  String formation;
  List<BenchAway> players;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
          // Positioned(
          //   top: MediaQuery.of(context).size.height * 0.35,
          //   left: MediaQuery.of(context).size.width * 0.5 - 5,
          //   child: MarkedPlayer(
          //       player: BenchAway(
          //           player: Player(id: 1231, name: "Sergio Ramos"),
          //           position: Position.DEFENDER)),
          // ),
          // Align(
          //   alignment: Alignment.bottomCenter,
          //   child: Container(
          //     height: 200,
          //     decoration: BoxDecoration(color: Colors.white),
          //   ),
          // )
        ],
      ),
    );
  }
}
