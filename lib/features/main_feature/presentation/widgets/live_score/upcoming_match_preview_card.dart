import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:live_football_stats/core/constants/app_colors.dart';
import 'package:live_football_stats/core/constants/app_routes_name.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/upcoming_match.dart';
import 'package:live_football_stats/features/main_feature/presentation/pages/match/match_page.dart';

class UpcomingMatchPreviewCard extends StatelessWidget {
  UpcomingMatchPreviewCard({super.key, required this.matchPreview});
  MatchPreview matchPreview;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.of(context).push(MaterialPageRoute(
        //   builder: (context) {
        //     return MatchPage(matchId: matchPreview.id!);
        //   },
        // ));
        context.pushNamed(AppRoutesName.matchPage,
            pathParameters: {'id': "${matchPreview.id}"});
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
            color: AppColors.lighterCardColor,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: AppColors.appBorder)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10, top: 5),
              child: Text(
                matchPreview.time != null
                    ? "${matchPreview.time}, ${matchPreview.date ?? ""}"
                    : "",
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    flex: 3,
                    child: Text(
                      textAlign: TextAlign.center,
                      matchPreview.teams!.home!.name,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w600),
                    )),
                const Expanded(
                    flex: 1,
                    child: Text(
                      "-",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    )),
                Expanded(
                    flex: 3,
                    child: Text(
                      matchPreview.teams!.away!.name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w600),
                    )),
              ],
            ),
            if (matchPreview.wordCount != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 5, top: 10),
                child: Text(
                  matchPreview.wordCount != null
                      ? "Word count: ${matchPreview.wordCount}"
                      : "",
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w400),
                ),
              ),
            if (matchPreview.exitementRating != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 10, top: 5),
                child: Text(
                  matchPreview.exitementRating != null
                      ? "Exitement rating: ${matchPreview.exitementRating}"
                      : "",
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w400),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
