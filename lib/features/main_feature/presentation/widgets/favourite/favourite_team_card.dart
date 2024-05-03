import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_routes_name.dart';
import '../../../../../core/constants/app_text_style.dart';
import '../../../domain/entities/favourite/favourite_team_entity.dart';

class AFavouriteTeamCard extends StatelessWidget {
  AFavouriteTeamCard({super.key, required this.team});
  TeamDataEntity team;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        int teamID = int.parse(team.teamID!);
        context.pushNamed(AppRoutesName.teamPage, extra: teamID);
      },
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(3),
        height: MediaQuery.of(context).size.height * 0.15,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.thirdBorder,
              width: 2,
            ),
            color: AppColors.cardColor),
        child: Text(
          team.teamName ?? "",
          style: AppTextStyles.commonTextStyle(),
          textAlign: TextAlign.center,
          overflow: TextOverflow.clip,
        ),
      ),
    );
  }
}
