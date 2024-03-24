import 'dart:math';

import 'package:flutter/material.dart';
import 'package:live_football_stats/core/enums/enum_values.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/match.dart';

class TeamFormation extends StatefulWidget {
  List<BenchAway> players;
  String formation;

  TeamFormation({required this.players, required this.formation});

  @override
  State<TeamFormation> createState() => _TeamFormationState();
}

class _TeamFormationState extends State<TeamFormation> {
  int initialPlayer = 0;

  @override
  Widget build(BuildContext context) {
    List<String> listFormation = [];
    List<int> listInt = [];
    if (widget.formation != "None") {
      listFormation = widget.formation.split("-");
      listInt = listFormation.map((e) => int.parse(e)).toList();
      listInt.insert(0, 1);
    }
    return widget.formation != "None"
        ? Stack(
            children: List<Widget>.generate(listInt.length, (index) {
            List<BenchAway> listPlayers = [];
            for (var i = initialPlayer;
                i <= listInt[index] + initialPlayer - 1;
                i++) {
              listPlayers.add(widget.players[i]);
              // listPlayers[valueIndex] = ;
            }
            setState(() {
              if (listInt[index] + initialPlayer > 10) {
                initialPlayer = 0;
              } else {
                initialPlayer = listInt[index] + initialPlayer;
              }
            });
            return PositionedPlayer(
              players: listPlayers,
              number: listPlayers.length,
              playingPosition: index,
              totalPlayingPosition: listInt.length,
            );
          })

            // players.asMap().entries.map((entry) {
            //   final index = entry.key;
            //   final player = entry.value;
            //   return PositionedPlayer(
            //       index: index, player: player, formation: formation);
            // }).toList(),
            )
        : Container();
  }
}

class PositionedPlayer extends StatelessWidget {
  final List<BenchAway> players;
  int playingPosition;
  int number;
  int totalPlayingPosition;
  PositionedPlayer(
      {required this.players,
      required this.number,
      required this.playingPosition,
      required this.totalPlayingPosition});

  @override
  Widget build(BuildContext context) {
    double? top;
    double? left;
    print("playingPosition: $playingPosition");
    print("totalPlayingPosition: $totalPlayingPosition");
    print("number: $number");
    // Định vị ngẫu nhiên cho mỗi cầu thủ trên sân
    if (playingPosition == 0) {
      top = MediaQuery.of(context).size.height * 0.58;
      left = MediaQuery.of(context).size.width * 0.32;
      // } else {
      //   top = MediaQuery.of(context).size.height * 0.3 * 0.5 + 10;
      // }
    } else if (playingPosition == 1) {
      top = MediaQuery.of(context).size.height * 0.46;
    } else if (playingPosition == 2) {
      if (totalPlayingPosition == 5) {
        top = MediaQuery.of(context).size.height * 0.28;
      } else {
        top = MediaQuery.of(context).size.height * 0.26;
      }
    } else if (playingPosition == 3) {
      if (totalPlayingPosition == 5) {
        top = MediaQuery.of(context).size.height * 0.20;
      } else {
        top = MediaQuery.of(context).size.height * 0.12;
      }
    } else {
      if (totalPlayingPosition == 5) {
        top = MediaQuery.of(context).size.height * 0.1;
      } else {
        top = MediaQuery.of(context).size.height * 0.1;
      }
    }

    if (playingPosition != 0) {
      return Positioned(
        top: top,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: List<Widget>.generate(players.length, (index) {
              if (playingPosition == 1) {
                if (number > 3) {
                  if (index == 0 || index == players.length - 1) {
                    return Container(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).size.height * 0.06),
                        child: MarkedPlayer(player: players[index]));
                  } else {
                    return MarkedPlayer(player: players[index]);
                  }
                } else {
                  return MarkedPlayer(player: players[index]);
                }
              } else if (playingPosition == 2) {
                if (number < 5) {
                  if (number > 2) {
                    if (index == 0 || index == players.length - 1) {
                      return Container(
                          padding: EdgeInsets.only(
                              bottom:
                                  MediaQuery.of(context).size.height * 0.06),
                          child: MarkedPlayer(player: players[index]));
                    } else {
                      return Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.1),
                        child: MarkedPlayer(player: players[index]),
                      );
                    }
                  } else {
                    return Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.1),
                      child: MarkedPlayer(player: players[index]),
                    );
                  }
                } else {
                  if (index == 0 ||
                      index == players.length - 1 ||
                      index == (players.length - 1) / 2) {
                    return Container(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).size.height * 0.1),
                        child: MarkedPlayer(player: players[index]));
                  } else {
                    return Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.1),
                      child: MarkedPlayer(player: players[index]),
                    );
                  }
                }
              } else if (playingPosition == 3 && totalPlayingPosition == 4 ||
                  playingPosition == 3 && totalPlayingPosition == 5) {
                if (number > 2) {
                  if (index == (players.length - 1) / 2) {
                    return Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).size.height * 0.06),
                        child: MarkedPlayer(player: players[index]));
                  } else {
                    return MarkedPlayer(player: players[index]);
                  }
                } else {
                  return MarkedPlayer(player: players[index]);
                }
              } else {
                return MarkedPlayer(player: players[index]);
              }
            }),
          ),
        ),
      );
    } else {
      return Positioned(
        // left: left,
        top: top,
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.85,
          child: Center(
            child: MarkedPlayer(player: players[0]),
          ),
        ),
      );
    }
  }
}

class MarkedPlayer extends StatelessWidget {
  MarkedPlayer({super.key, required this.player});
  final BenchAway player;
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints:
          BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.17),
      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.06,
            height: MediaQuery.of(context).size.width * 0.06,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue,
            ),
            child: Center(
              child: Text(
                player.position! == Position.ATTACKER
                    ? "CF"
                    : player.position! == Position.DEFENDER
                        ? "CB"
                        : player.position! == Position.MIDFIELDER
                            ? "CM"
                            : "GK",
                style: const TextStyle(color: Colors.white, fontSize: 10),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(2),
            child: Text(
              player.player!.name!,
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.clip,
            ),
          )
        ],
      ),
    );
  }
}
