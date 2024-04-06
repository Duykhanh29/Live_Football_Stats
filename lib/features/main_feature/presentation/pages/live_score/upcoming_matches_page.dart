import 'package:flutter/material.dart';

import '../../widgets/live_score/upcoming_matches_widget.dart';

class UpcomingMatchesPage extends StatelessWidget {
  const UpcomingMatchesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 15, top: 15),
            child: Text('Upcoming matches'),
          ),
          UpcomingMatchesWidget(),
        ],
      ),
    );
  }
}
