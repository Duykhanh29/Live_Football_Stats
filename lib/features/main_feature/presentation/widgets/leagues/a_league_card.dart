import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:live_football_stats/core/constants/app_routes_name.dart';
import 'package:live_football_stats/features/main_feature/data/models/favourite/favourite_league_model.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/league.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/league/a_league/league_bloc.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/league/a_league/league_event.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/match/matches/matches_bloc.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/match/matches/matches_event.dart';
import 'package:live_football_stats/features/main_feature/presentation/pages/league/league_page.dart';

import '../../../../../core/helper/snack_bar_helper.dart';
import '../../../../../core/utils/common_method.dart';
import '../../../../auth/presentation/blocs/auth/auth_bloc.dart';
import '../../../../auth/presentation/blocs/auth/auth_state.dart';
import '../../blocs/favourite/favourite_league/favourite_league_bloc.dart';
import '../../blocs/favourite/favourite_league/favourite_league_event.dart';
import '../../blocs/favourite/favourite_league/favourite_league_state.dart';

class LeagueCard extends StatelessWidget {
  LeagueCard({super.key, required this.league});
  League league;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        // Navigator.of(context).push(MaterialPageRoute(
        //   builder: (context) {
        //     return LeaguePage(leagueId: league.id);
        //   },
        // ));
        context.pushNamed(AppRoutesName.leaguePage, extra: league.id);
      },
      title: Text(league.name),
      subtitle: Text(league.country.name!),
      trailing: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, authState) {
          if (authState is AuthorizedState) {
            return BlocConsumer<FavouriteLeagueBloc, FavouriteLeagueState>(
              builder: (context, state) {
                if (state is FavouriteLeagueFetchedSucess) {
                  final data = state.favouriteLeague;
                  final isExisted = CommonMethods.isFavouriteLeagueExisted(
                      league.id.toString(), data);
                  if (isExisted) {
                    return InkWell(
                      onTap: () {
                        BlocProvider.of<FavouriteLeagueBloc>(context).add(
                            DeleteFavouriteLeague(
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
                  }
                }
                return InkWell(
                  onTap: () {},
                  child: const Icon(Icons.star),
                );
              },
              listener: (context, state) {
                if (state is FavouriteLeagueFailWithNoInternet) {
                  SnackbarHelper.showSnackBar(context, state.message ?? "");
                }
              },
            );
          } else {
            return InkWell(
              onTap: () {},
              child: const Icon(Icons.star),
            );
          }
        },
      ),
    );
  }
}
