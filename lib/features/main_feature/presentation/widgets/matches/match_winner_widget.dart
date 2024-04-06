import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:live_football_stats/core/constants/app_colors.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/match.dart';

class MatchWinnerWidget extends StatelessWidget {
  MatchWinnerWidget({super.key, this.matchWinner});
  MatchWinner? matchWinner;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(border: Border.all(color: AppColors.sencondaryBorder)),
      // height: MediaQuery.of(context).size.height * 0.25,
      width: MediaQuery.of(context).size.width * 0.9,
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.only(top: 10, bottom: 15, left: 10, right: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: Text(
              "Match Winner",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
            ),
          ),
          Container(
            // decoration: BoxDecoration(border: Border.all(color: Colors.pink)),
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                            border: Border.all(
                                color: AppColors.homeWinColor, width: 2)),
                        child: Center(
                          child: Text(matchWinner != null
                              ? matchWinner!.home.toString()
                              : "none"),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: AppColors.drawColor, width: 2)),
                        child: Center(
                          child: Text(matchWinner != null
                              ? matchWinner!.draw.toString()
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
                            border: Border.all(
                                color: AppColors.awayWinColor, width: 2)),
                        child: Center(
                          child: Text(matchWinner != null
                              ? matchWinner!.away.toString()
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
                        child: Text("Home win"),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Center(
                        child: Text("Draw"),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Center(
                        child: Text("Away win"),
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
