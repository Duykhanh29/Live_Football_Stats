import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:live_football_stats/core/constants/app_colors.dart';
import 'package:live_football_stats/core/constants/app_text_style.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/live_score.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/live_score/live_score_bloc.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/live_score/live_score_state.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/nav_bar/nav_bar_cubit.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/nav_bar/nav_live_score_cubit.dart';
import 'package:live_football_stats/features/main_feature/presentation/pages/live_score/upcoming_matches_page.dart';
import 'package:live_football_stats/features/main_feature/presentation/widgets/live_score/live_score_card.dart';

import '../../widgets/live_score/live_score_widget.dart';
import 'package:flutter_switch/flutter_switch.dart';

class LiveScoreMainView extends StatelessWidget {
  const LiveScoreMainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.secondaryColor,
        // centerTitle: true,
        title: Text(
          "Livescore",
          style: AppTextStyles.appBarTexStyle(),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Text(
              "Live",
              style: AppTextStyles.actionAppBarTextStyle(),
            ),
          ),
          BlocBuilder<NavLiveScoreCubit, bool>(builder: (context, state) {
            return
                //  Switch(
                //   value: state,
                //   onChanged: (value) {
                //     BlocProvider.of<NavLiveScoreCubit>(context).updateValue(value);
                //   },
                // );

                Padding(
              padding: const EdgeInsets.only(right: 15),
              child: FlutterSwitch(
                activeToggleColor: AppColors.liveColor,
                activeColor: AppColors.eventColor1,
                inactiveColor: AppColors.greyBorder,
                width: 65.0,
                height: 30.0,
                valueFontSize: 16.0,
                toggleSize: 30.0,
                value: state,
                borderRadius: 15.0,
                padding: 4.0,
                showOnOff: true,
                onToggle: (value) {
                  BlocProvider.of<NavLiveScoreCubit>(context)
                      .updateValue(value);
                },
              ),
            );
          })
        ],
      ),
      body: BlocBuilder<NavbarCubit, int>(
        builder: (context, state) {
          if (state == 1) {
            return BlocBuilder<NavLiveScoreCubit, bool>(
              builder: (context, state) {
                if (state) {
                  return const LiveScoreWidget();
                } else {
                  return const UpcomingMatchesPage();
                }
              },
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
