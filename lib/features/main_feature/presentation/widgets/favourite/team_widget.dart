import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:live_football_stats/core/constants/app_routes_name.dart';
import 'package:live_football_stats/core/constants/app_text_style.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../domain/entities/favourite/favourite_team_entity.dart';
import '../../blocs/favourite/favourite_league/favourite_league_bloc.dart';
import '../../blocs/favourite/favourite_league/favourite_league_event.dart';

class TeamWidget extends StatelessWidget {
  TeamWidget({super.key, required this.teamDataEntity, required this.uid});
  TeamDataEntity teamDataEntity;
  String uid;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.sencondaryBorder, width: 0.8),
          borderRadius: BorderRadius.circular(5)),
      key: UniqueKey(),
      padding: const EdgeInsets.all(5),
      child: ListTile(
        onTap: () {
          int teamID = int.parse(teamDataEntity.teamID!);
          GoRouter.of(context).pushNamed(AppRoutesName.teamPage, extra: teamID);
        },
        leading: Text(
          teamDataEntity.teamName ?? "",
          style: AppTextStyles.headingTextStyle(),
        ),
        trailing: InkWell(
          onTap: () {
            BlocProvider.of<FavouriteLeagueBloc>(context).add(
                DeleteFavouriteLeague(
                    leagueID: teamDataEntity.teamID!, uid: uid));
          },
          child: const Icon(
            Icons.star,
            color: Colors.orangeAccent,
          ),
        ),
      ),
    );
  }
}
