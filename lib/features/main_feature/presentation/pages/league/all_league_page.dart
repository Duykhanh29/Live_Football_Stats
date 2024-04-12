import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:live_football_stats/core/constants/app_colors.dart';
import 'package:live_football_stats/core/constants/app_text_style.dart';
import 'package:live_football_stats/core/helper/loading_helper.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/league/a_league/league_event.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/league/leagues/leagues_bloc.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/league/leagues/leagues_event.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/league/leagues/leagues_state.dart';
import 'package:live_football_stats/features/main_feature/presentation/widgets/leagues/a_league_card.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../../core/helper/error_helper.dart';

class AllLeaguePage extends StatelessWidget {
  const AllLeaguePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.secondaryColor,
        centerTitle: true,
        title: Text(
          "All league",
          style: AppTextStyles.appBarTexStyle(),
        ),
        leading: IconButton(
            onPressed: () {
              //Navigator.of(context).pop();
              GoRouter.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          BlocProvider.of<LeaguesBloc>(context).add(AllLeagueFetched());
        },
        child: BlocBuilder<LeaguesBloc, LeaguesState>(
          builder: (context, state) {
            if (state is LeaguesFetchSuccess) {
              return ListView.separated(
                  itemBuilder: (context, index) =>
                      LeagueCard(league: state.listLeague[index]),
                  separatorBuilder: (context, index) => const Divider(
                        height: 1,
                      ),
                  itemCount: state.listLeague.length);
            } else if (state is LeaguesFetchFail) {
              return ErrorHelper.basicErrorWidget();
            } else {
              return LoadingHelper.staggeredDotsWaveLoading();
            }
          },
        ),
      ),
    );
  }
}
