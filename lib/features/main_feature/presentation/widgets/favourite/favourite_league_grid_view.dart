import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:live_football_stats/core/constants/app_colors.dart';
import 'package:live_football_stats/core/constants/app_routes_name.dart';
import 'package:live_football_stats/features/main_feature/presentation/widgets/favourite/favourite_league_card.dart';

import '../../../../../core/constants/app_text_style.dart';
import '../../../../../core/constants/image_data.dart';
import '../../../domain/entities/favourite/favourite_league_entity.dart';
import '../../blocs/favourite/favourite_league/favourite_league_bloc.dart';
import '../../blocs/favourite/favourite_league/favourite_league_state.dart';

class FavouriteLeagueGridView extends StatelessWidget {
  const FavouriteLeagueGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavouriteLeagueBloc, FavouriteLeagueState>(
      builder: (context, state) {
        if (state is FavouriteLeagueFetchedSucess) {
          final FavouriteLeagueEntity favouriteLeagueEntity =
              state.favouriteLeague;
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.38 - 10),
            decoration:
                BoxDecoration(border: Border.all(color: AppColors.thirdBorder)),
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
                      Text("Favourite Leagues",
                          style: AppTextStyles.headingTextStyle()),
                      TextButton(
                        onPressed: () {
                          context
                              .pushNamed(AppRoutesName.listFavouriteLeaguePage);
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
                favouriteLeagueEntity.leagues != null &&
                        favouriteLeagueEntity.leagues!.isNotEmpty
                    ? Expanded(
                        child: GridView.builder(
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10),
                          itemBuilder: (context, index) {
                            return AFavouriteLeagueCard(
                              league: favouriteLeagueEntity.leagues![index],
                            );
                          },
                          scrollDirection: Axis.horizontal,
                          itemCount: favouriteLeagueEntity.leagues!.length > 10
                              ? 10
                              : favouriteLeagueEntity.leagues!.length,
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
            ),
          );
        } else if (state is FavouriteLeagueFetchedFail) {
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
                Text("Favourite Leagues",
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
