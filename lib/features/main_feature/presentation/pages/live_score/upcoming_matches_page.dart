import 'package:flutter/material.dart';

import '../../widgets/live_score/upcoming_matches_widget.dart';

class UpcomingMatchesPage extends StatelessWidget {
  const UpcomingMatchesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 15, bottom: 10, top: 15),
            child: Text(
              'Upcoming matches',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
          ),
          UpcomingMatchesWidget(),
        ],
      ),
    );
  }
}
