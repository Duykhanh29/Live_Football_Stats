import 'package:flutter/material.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/match_preview.dart';

class PreviewBasicInfoWidget extends StatelessWidget {
  PreviewBasicInfoWidget({super.key, required this.matchPreview});
  MatchPreview matchPreview;
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: MediaQuery.of(context).size.height * 0.2,
      padding: const EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.18,
            width: MediaQuery.of(context).size.width * 0.4,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.lightGreen.shade300),
              borderRadius: BorderRadius.circular(5),
            ),
            padding: const EdgeInsets.all(5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  padding: const EdgeInsets.all(2),
                  child: Text(
                    matchPreview.teams.home.name,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                    maxLines: 3,
                  ),
                ),
                const Text(
                  "&",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                Container(
                  padding: const EdgeInsets.all(2),
                  child: Text(
                    matchPreview.teams.away.name,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                    maxLines: 3,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.18,
            width: MediaQuery.of(context).size.width * 0.5,
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.45,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.lightGreen.shade300),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text(
                        "League",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                      Text(
                        matchPreview.league.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 16),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.45,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.lightGreen.shade300),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text(
                        "Stage",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                      Text(
                        matchPreview.stage.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 16),
                      ),
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
