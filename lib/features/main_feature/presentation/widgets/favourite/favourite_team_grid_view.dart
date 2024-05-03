import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:live_football_stats/core/constants/image_data.dart';
import 'package:live_football_stats/features/main_feature/presentation/widgets/favourite/favourite_team_card.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_routes_name.dart';
import '../../../../../core/constants/app_text_style.dart';
import '../../../domain/entities/favourite/favourite_team_entity.dart';
import '../../blocs/favourite/favourite_team/favourite_team_bloc.dart';
import '../../blocs/favourite/favourite_team/favourite_team_state.dart';

class FavouriteTeamGridView extends StatelessWidget {
  const FavouriteTeamGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavouriteTeamBloc, FavouriteTeamState>(
      builder: (context, state) {
        if (state is FavouriteTeamFetchedSucess) {
          final FavouriteTeamEntity teamEntity = state.favouriteTeam;
          return Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              decoration:
                  BoxDecoration(border: Border.all(color: AppColors.appBorder)),
              constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.38 - 10),
              padding: const EdgeInsets.all(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Favourite Teams",
                          style: AppTextStyles.headingTextStyle(),
                        ),
                        TextButton(
                          onPressed: () {
                            context
                                .pushNamed(AppRoutesName.listFavouriteTeamPage);
                          },
                          child: const Text(
                            "See all",
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  teamEntity.teams != null && teamEntity.teams!.isNotEmpty
                      ? Expanded(
                          child: GridView.builder(
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10),
                            itemBuilder: (context, index) {
                              return AFavouriteTeamCard(
                                team: teamEntity.teams![index],
                              );
                            },
                            scrollDirection: Axis.horizontal,
                            itemCount: teamEntity.teams!.length > 10
                                ? 10
                                : teamEntity.teams!.length,
                          ),
                        )
                      : Center(
                          child: Image.asset(
                            ImageData.emptyImage,
                            height: 100,
                            width: 100,
                          ),
                        ),
                ],
              ));
        } else if (state is FavouriteTeamFetchedFail) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            height: MediaQuery.of(context).size.height * 0.24,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration:
                BoxDecoration(border: Border.all(color: AppColors.greyBorder)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("Favourite Teams",
                    style: AppTextStyles.headingTextStyle()),
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    ImageData.emptyImage,
                    height: 100,
                    width: 100,
                  ),
                ),
                const SizedBox(
                  height: 20,
                )
              ],
            ),
          );
        }
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.2,
        );
      },
    );
  }
}
