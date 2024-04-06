import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/match_preview.dart';

import '../../../../../core/constants/app_colors.dart';

class PreviewMatchDataWidget extends StatelessWidget {
  PreviewMatchDataWidget({super.key, required this.matchPreview});
  MatchPreview matchPreview;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.thirdBorder),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
            child: Text(
              "Match data",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
            child: Divider(
              height: 1,
              color: Colors.blueGrey.shade300,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  padding: const EdgeInsets.all(2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                          "Excitement rating: ${matchPreview.matchData.excitementRating}"),
                      Text(
                          "Prediction ${matchPreview.matchData.prediction.type}: ${matchPreview.matchData.prediction.choice}"),
                      const Text(
                        "Weather",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      Text("Temp C: ${matchPreview.matchData.weather.tempC}"),
                      Text("Temp F: ${matchPreview.matchData.weather.tempF}"),
                      Text(
                          "Description: ${matchPreview.matchData.weather.description}"),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
