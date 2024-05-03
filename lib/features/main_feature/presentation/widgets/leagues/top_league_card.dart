import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:live_football_stats/core/constants/app_colors.dart';
import 'package:live_football_stats/core/constants/app_routes_name.dart';
import 'package:live_football_stats/core/helper/snack_bar_helper.dart';
import 'package:live_football_stats/core/injection/injection_container.dart';
import 'package:live_football_stats/core/utils/common_method.dart';
import 'package:live_football_stats/features/auth/domain/entities/user_entity.dart';
import 'package:live_football_stats/features/auth/presentation/blocs/auth/auth_bloc.dart';
import 'package:live_football_stats/features/auth/presentation/blocs/auth/auth_state.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/league.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/favourite/favourite_league/favourite_league_bloc.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/favourite/favourite_league/favourite_league_event.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/favourite/favourite_league/favourite_league_state.dart';
import 'package:live_football_stats/features/main_feature/presentation/pages/league/league_page.dart';

import '../../../data/models/favourite/favourite_league_model.dart';

class TopLeagueCard extends StatelessWidget {
  TopLeagueCard({super.key, required this.league});
  League league;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.of(context).push(MaterialPageRoute(
        //   builder: (context) {
        //     return LeaguePage(
        //       leagueId: league.id,
        //     );
        //   },
        // ));
        context.pushNamed(AppRoutesName.leaguePage, extra: league.id);
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.indigoAccent),
            borderRadius: BorderRadius.circular(20),
            color: AppColors.cardColor),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        height: MediaQuery.of(context).size.height * 0.25,
        width: MediaQuery.of(context).size.width * 0.3,
        child: Stack(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 1, vertical: 2),
                  child: Text(
                    league.name,
                    textAlign: TextAlign.center,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontWeight: FontWeight.w700, fontSize: 18),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 1, vertical: 2),
                  child: Text(
                    league.country.name!,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontWeight: FontWeight.w700, fontSize: 14),
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.topRight,
              child: BlocBuilder<AuthBloc, AuthState>(
                builder: (context, authState) {
                  if (authState is AuthorizedState) {
                    BlocProvider.of<FavouriteLeagueBloc>(context).add(
                        FecthFavouriteLeagues(uid: authState.user!.userID!));
                    return BlocConsumer<FavouriteLeagueBloc,
                        FavouriteLeagueState>(
                      builder: (context, state) {
                        if (state is FavouriteLeagueFetchedSucess) {
                          final data = state.favouriteLeague;
                          final isExisted =
                              CommonMethods.isFavouriteLeagueExisted(
                                  league.id.toString(), data);
                          if (isExisted) {
                            return InkWell(
                              onTap: () {
                                BlocProvider.of<FavouriteLeagueBloc>(context)
                                    .add(DeleteFavouriteLeague(
                                        leagueID: league.id.toString(),
                                        uid: authState.user!.userID!));
                              },
                              child: const Icon(
                                Icons.star,
                                color: Colors.orangeAccent,
                              ),
                            );
                          } else {
                            return InkWell(
                              onTap: () {
                                LeagueDataModel leagueDataModel =
                                    LeagueDataModel(
                                        leagueID: league.id.toString(),
                                        leagueName: league.name);
                                BlocProvider.of<FavouriteLeagueBloc>(context)
                                    .add(AddFavouriteLeague(
                                        leagueData: leagueDataModel,
                                        uid: authState.user!.userID!));
                              },
                              child: const Icon(Icons.star),
                            );
                          }
                        }
                        return InkWell(
                          onTap: () {
                            LeagueDataModel leagueDataModel = LeagueDataModel(
                                leagueID: league.id.toString(),
                                leagueName: league.name);
                            BlocProvider.of<FavouriteLeagueBloc>(context).add(
                                AddFavouriteLeague(
                                    leagueData: leagueDataModel,
                                    uid: authState.user!.userID!));
                          },
                          child: const Icon(Icons.star),
                        );
                      },
                      listener: (context, state) {
                        if (state is FavouriteLeagueFailWithNoInternet) {
                          SnackbarHelper.showSnackBar(
                              context, state.message ?? "");
                        }
                      },
                    );
                  } else {
                    return InkWell(
                      onTap: () async {
                        EasyLoading.showInfo(
                            "You need login to access this feature");
                        Future.delayed(const Duration(seconds: 4));
                        EasyLoading.dismiss();
                      },
                      child: const Icon(Icons.star),
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
