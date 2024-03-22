import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:live_football_stats/core/enums/enum_values.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/match_event.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/player.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/team/a_team/team_event.dart';
import 'package:live_football_stats/features/main_feature/presentation/widgets/matches/match_event_card.dart';

class KeyEventsScreen extends StatelessWidget {
  KeyEventsScreen({super.key});
  List<MatchEvent> list = [
    MatchEvent(
        eventType: EventType.GOAL,
        eventMinute: "13",
        team: EventTeam.HOME,
        player: Player(id: 12, name: "Goal Player"),
        assistPlayer: Player(id: 13, name: "Assist")),
    MatchEvent(
        eventType: EventType.OWN_GOAL,
        eventMinute: "13",
        team: EventTeam.HOME,
        player: Player(id: 12, name: "Goal Player"),
        assistPlayer: null),
    MatchEvent(
        eventType: EventType.GOAL,
        eventMinute: "13",
        team: EventTeam.HOME,
        player: Player(id: 12, name: "Goal Player"),
        assistPlayer: Player(id: 13, name: "Assist")),
    MatchEvent(
        eventType: EventType.GOAL,
        eventMinute: "13",
        team: EventTeam.HOME,
        player: Player(id: 12, name: "Goal Player"),
        assistPlayer: Player(id: 13, name: "Assist")),
    MatchEvent(
        eventType: EventType.GOAL,
        eventMinute: "13",
        team: EventTeam.HOME,
        player: Player(id: 12, name: "Goal Player"),
        assistPlayer: Player(id: 13, name: "Assist")),
    MatchEvent(
        eventType: EventType.GOAL,
        eventMinute: "13",
        team: EventTeam.HOME,
        player: Player(id: 12, name: "Goal Player"),
        assistPlayer: Player(id: 13, name: "Assist")),
    MatchEvent(
        eventType: EventType.GOAL,
        eventMinute: "13",
        team: EventTeam.HOME,
        player: Player(id: 12, name: "Goal Player"),
        assistPlayer: Player(id: 13, name: "Assist")),
    MatchEvent(
        eventType: EventType.GOAL,
        eventMinute: "13",
        team: EventTeam.HOME,
        player: Player(id: 12, name: "Goal Player"),
        assistPlayer: Player(id: 13, name: "Assist")),
    MatchEvent(
        eventType: EventType.GOAL,
        eventMinute: "13",
        team: EventTeam.HOME,
        player: Player(id: 12, name: "Goal Player"),
        assistPlayer: Player(id: 13, name: "Assist")),
    MatchEvent(
        eventType: EventType.GOAL,
        eventMinute: "13",
        team: EventTeam.HOME,
        player: Player(id: 12, name: "Goal Player"),
        assistPlayer: Player(id: 13, name: "Assist"))
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: ListView.builder(
        itemBuilder: (context, index) {
          return MatchEventCard(
              matchEvent: list[index],
              color: index % 2 == 0
                  ? Colors.green.shade200
                  : Colors.cyan.shade200);
        },
        itemCount: list.length,
      ),
    );
  }
}
