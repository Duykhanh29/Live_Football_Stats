import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/match.dart';

class HandicapWidget extends StatelessWidget {
  HandicapWidget({super.key, this.handicap});
  Handicap? handicap;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(border: Border.all(color: Colors.greenAccent.shade400)),
      // height: MediaQuery.of(context).size.height * 0.25,
      width: MediaQuery.of(context).size.width * 0.9,
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.only(top: 10, bottom: 15, left: 10, right: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 1),
            child: Text(
              "Handicap",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
            ),
          ),
          Container(
            // decoration: BoxDecoration(border: Border.all(color: Colors.pink)),
            // padding: const EdgeInsets.symmetric(vertical: 5),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              bottomLeft: Radius.circular(20),
                            ),
                            border: Border.all(color: Colors.red, width: 2)),
                        child: Center(
                          child: Text(handicap != null
                              ? handicap!.market.toString()
                              : "none"),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.blue, width: 2)),
                        child: Center(
                          child: Text(handicap != null
                              ? handicap!.home.toString()
                              : "none"),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                            border: Border.all(color: Colors.yellow, width: 2)),
                        child: Center(
                          child: Text(handicap != null
                              ? handicap!.away.toString()
                              : "none"),
                        ),
                      ),
                    )
                  ],
                ),
                const Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Center(
                        child: Text("Market"),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Center(
                        child: Text("Home"),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Center(
                        child: Text("Away"),
                      ),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
