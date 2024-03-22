import 'package:flutter/material.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/head_to_head.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/team_response.dart';

class HeadToHeadWidget extends StatelessWidget {
  HeadToHeadWidget(
      {super.key,
      required this.draw,
      required this.name,
      required this.team1Wins,
      required this.team2Wins,
      required this.team1Scored,
      required this.team2Scored,
      required this.totalGames,
      required this.team1,
      required this.team2});
  int team1Wins;
  int team2Wins;
  int draw;
  String name;
  int totalGames;
  int team1Scored;
  int team2Scored;
  TeamResponse team1, team2;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.teal.shade300),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Text(
              "Overall",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ),
          Text(
            "Total games: $totalGames",
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Wins $team1Wins",
              ),
              Text(
                "Drawns $draw",
              ),
              Text(
                "Wins $team2Wins",
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildBar(context, Colors.orangeAccent, team1Wins, totalGames),
              buildBar(context, Colors.blueAccent, draw, totalGames),
              buildBar(context, Colors.pinkAccent, team2Wins, totalGames),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Text("${team1.name} wins: $team1Wins"),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Text("${team2.name} wins: $team2Wins"),
          ),
        ],
      ),
    );
  }

  Widget buildBar(BuildContext context, Color color, int value, int total) {
    double width = (value / total) * MediaQuery.of(context).size.width * 0.85;
    return Container(
      width: width,
      height: 10,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(5), color: color),
      padding: const EdgeInsets.symmetric(horizontal: 1),
    );
  }
}
