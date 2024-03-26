import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/league_response.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/match.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/stage_response.dart';
import 'package:live_football_stats/features/main_feature/presentation/pages/league/league_page.dart';

class GameInfoWidget extends StatelessWidget {
  GameInfoWidget(
      {super.key,
      required this.leagueResponse,
      required this.stadium,
      required this.stage});
  LeagueResponse? leagueResponse;
  StageResponse? stage;
  Stadium? stadium;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.blueGrey),
          borderRadius: BorderRadius.circular(15)),
      width: MediaQuery.of(context).size.width * 0.9,
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 5, bottom: 5),
            child: Text(
              "Game information",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
          const Divider(
            color: Colors.grey,
            height: 0.6,
          ),
          ListTile(
            onTap: () {
              if (leagueResponse != null) {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return LeaguePage(leagueId: leagueResponse!.id);
                  },
                ));
              }
            },
            leading: const Icon(Ionicons.trophy),
            title: const Text(
              "Competition",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
            subtitle: Text(
              leagueResponse != null ? leagueResponse!.name : "No data",
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
            ),
          ),
          ListTile(
            leading: const Icon(Ionicons.time_sharp),
            title: const Text(
              "Stage",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
            subtitle: Text(
              stage!.name,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.place_rounded),
            title: const Text(
              "Stadium",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
            subtitle: Text(
              stadium != null ? stadium!.name : "No data",
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
            ),
          ),
        ],
      ),
    );
  }
}
