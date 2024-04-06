import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:live_football_stats/core/constants/app_colors.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/live_score.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/live_score/live_score_bloc.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/live_score/live_score_state.dart';
import 'package:live_football_stats/features/main_feature/presentation/pages/live_score/upcoming_matches_page.dart';
import 'package:live_football_stats/features/main_feature/presentation/widgets/live_score/live_score_card.dart';

import '../../widgets/live_score/live_score_widget.dart';

class LiveScoreMainView extends StatelessWidget {
  const LiveScoreMainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        title: const Text(
          "Livescore",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          // shrinkWrap: true,

          children: [
            LiveScoreWidget()
            //  UpcomingMatchesPage(),
          ],
        ),
      ),
    );
  }
}
