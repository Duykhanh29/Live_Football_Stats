import 'package:flutter/material.dart';
import 'package:live_football_stats/core/constants/app_text_style.dart';

import '../../widgets/live_score/upcoming_matches_widget.dart';

class UpcomingMatchesPage extends StatelessWidget {
  const UpcomingMatchesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15, bottom: 10, top: 15),
            child: Text(
              'Upcoming matches',
              style: AppTextStyles.headingTextStyle(),
            ),
          ),
          const UpcomingMatchesWidget(),
        ],
      ),
    );
  }
}
