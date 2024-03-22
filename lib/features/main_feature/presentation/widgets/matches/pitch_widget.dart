import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:live_football_stats/features/main_feature/presentation/widgets/matches/pitch_painter.dart';

class PitchWidget extends StatelessWidget {
  const PitchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CustomPaint(
            painter: PitchPainter(),
            // size: Size(MediaQuery.of(context).size.width * 0.85,
            //     MediaQuery.of(context).size.height * 0.7),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.7,
              width: MediaQuery.of(context).size.width * 0.85,
            ),
          ),
          Container(
            decoration: const BoxDecoration(color: Colors.white),
            height: 100,
          ),
        ],
      ),
    );
  }
}
