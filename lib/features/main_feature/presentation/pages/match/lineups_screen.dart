import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:live_football_stats/features/main_feature/presentation/widgets/matches/pitch_widget.dart';

class LineupScreen extends StatefulWidget {
  LineupScreen({super.key});

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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          TabBar(
            indicatorColor: Colors.amberAccent.shade200,
            labelColor: Colors.indigo.shade300,
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
              children: const [
                PitchWidget(),
                PitchWidget(),
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
