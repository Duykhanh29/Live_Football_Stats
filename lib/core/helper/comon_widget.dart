import 'package:flutter/material.dart';
import 'package:live_football_stats/features/main_feature/presentation/pages/league/league_page.dart';

class CommonWidget {
  CommonWidget._();
  static Widget fowardToLeaguePage(BuildContext context, int? leagueID) {
    return Expanded(
      flex: 1,
      child: InkWell(
        onTap: () {
          if (leagueID != null) {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) {
                return LeaguePage(
                  leagueId: leagueID,
                );
              },
            ));
          }
        },
        child: const Icon(
          Icons.arrow_forward_ios_rounded,
          size: 18,
        ),
      ),
    );
  }
}
