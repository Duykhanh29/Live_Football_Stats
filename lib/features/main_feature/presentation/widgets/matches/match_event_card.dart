import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ionicons/ionicons.dart';
import 'package:live_football_stats/core/constants/image_data.dart';
import 'package:live_football_stats/core/enums/enum_values.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/match_event.dart';

class MatchEventCard extends StatelessWidget {
  MatchEventCard({super.key, required this.color, required this.matchEvent});
  MatchEvent matchEvent;
  Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(5), color: color),
      child: Row(
        mainAxisAlignment: matchEvent.team == EventTeam.HOME
            ? MainAxisAlignment.start
            : MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (matchEvent.team == EventTeam.HOME)
            Expanded(
              flex: 4,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // first is time
                    Text(
                      matchEvent.eventMinute!,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w500),
                    ),

                    // second
                    if (matchEvent.eventType! != EventType.SUBSTITUTION)
                      Text(
                        matchEvent.player!.name!,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w800),
                      ),
                    if (matchEvent.eventType! == EventType.SUBSTITUTION)
                      Text(
                        matchEvent.playerIn!.name!,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w800),
                      ),

                    // third
                    if (matchEvent.eventType! != EventType.SUBSTITUTION &&
                        matchEvent.eventType! == EventType.GOAL &&
                        matchEvent.assistPlayer != null)
                      Text(
                        matchEvent.assistPlayer!.name!,
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                    if (matchEvent.eventType! != EventType.SUBSTITUTION &&
                        matchEvent.eventType! == EventType.PENALTY_GOAL)
                      const Text(
                        "PEN",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                    if (matchEvent.eventType! == EventType.SUBSTITUTION)
                      Text(
                        matchEvent.playerOut!.name!,
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                  ],
                ),
              ),
            ),
          if (matchEvent.team != EventTeam.HOME)
            Expanded(flex: 4, child: Container()),
          Expanded(
            flex: 1,
            child: SizedBox(
              child: Center(
                  child: matchEvent.eventType! == EventType.SUBSTITUTION
                      ? Image.asset(
                          ImageData.substitutionImage,
                          height: 20,
                          width: 20,
                        )
                      : matchEvent.eventType! == EventType.GOAL ||
                              matchEvent.eventType! == EventType.PENALTY_GOAL
                          ? Image.asset(
                              ImageData.goalImage,
                              height: 20,
                              width: 20,
                            )
                          : matchEvent.eventType! == EventType.OWN_GOAL
                              ? Image.asset(
                                  ImageData.substitutionImage,
                                  height: 20,
                                  width: 20,
                                  color: Colors.red,
                                )
                              : matchEvent.eventType! == EventType.YELLOW_CARD
                                  ? Image.asset(
                                      ImageData.yellowCardImage,
                                      height: 20,
                                      width: 20,
                                    )
                                  : matchEvent.eventType! == EventType.RED_CARD
                                      ? Image.asset(
                                          ImageData.yellowCardImage,
                                          height: 20,
                                          width: 20,
                                        )
                                      : Image.asset(
                                          ImageData.yellowRedCardImage,
                                          height: 20,
                                          width: 20,
                                        )),
            ),
          ),
          if (matchEvent.team != EventTeam.AWAY)
            Expanded(flex: 4, child: Container()),
          if (matchEvent.team == EventTeam.AWAY)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    matchEvent.eventMinute!,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  if (matchEvent.eventType! != EventType.SUBSTITUTION)
                    Text(
                      matchEvent.player!.name!,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w800),
                    ),
                  if (matchEvent.eventType! == EventType.SUBSTITUTION)
                    Text(
                      matchEvent.playerIn!.name!,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w800),
                    ),
                  if (matchEvent.eventType! != EventType.SUBSTITUTION &&
                      matchEvent.eventType! == EventType.GOAL &&
                      matchEvent.assistPlayer != null)
                    Text(
                      matchEvent.assistPlayer!.name!,
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                  if (matchEvent.eventType! != EventType.SUBSTITUTION &&
                      matchEvent.eventType! == EventType.PENALTY_GOAL)
                    const Text(
                      "PEN",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                  if (matchEvent.eventType! == EventType.SUBSTITUTION)
                    Text(
                      matchEvent.playerOut!.name!,
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
