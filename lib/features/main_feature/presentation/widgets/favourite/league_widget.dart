import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:live_football_stats/core/constants/app_colors.dart';
import 'package:live_football_stats/core/constants/app_routes_name.dart';
import 'package:live_football_stats/core/constants/app_text_style.dart';
import 'package:live_football_stats/core/helper/divider_helper.dart';
import 'package:live_football_stats/core/utils/common_method.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/favourite/favourite_league_entity.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/match/matches/matches_state.dart';

import '../../../domain/entities/league_matches.dart';
import '../../blocs/favourite/favourite_league/favourite_league_bloc.dart';
import '../../blocs/favourite/favourite_league/favourite_league_event.dart';
import '../../blocs/match/matches/matches_bloc.dart';
import '../../blocs/match/matches/matches_event.dart';
import 'package:live_football_stats/features/main_feature/presentation/widgets/matches/match_card.dart';

class LeagueWidget extends StatefulWidget {
  LeagueWidget({super.key, required this.leagueDataEntity, required this.uid});
  LeagueDataEntity leagueDataEntity;
  String uid;
  @override
  State<LeagueWidget> createState() => _LeagueWidgetState();
}

class _LeagueWidgetState extends State<LeagueWidget> {
  List<LeagueMatch> listMatch = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    int leagueID = int.parse(widget.leagueDataEntity.leagueID!);
    context.read<MatchesBloc>().add(MatchesOfALeagueFetched(leagueID));
  }

  void getCurrentData(List<LeagueMatch> list) {
    DateTime currentTime = DateTime.now();
    setState(() {
      listMatch = CommonMethods.getCurrentListMatches(list, currentTime);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MatchesBloc, MatchesState>(
      builder: (context, state) {
        if (state is MatchesFetchSuccess) {
          return Container(
            decoration: BoxDecoration(
                border:
                    Border.all(color: AppColors.sencondaryBorder, width: 0.8),
                borderRadius: BorderRadius.circular(5)),
            key: UniqueKey(),
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            child: ListTile(
              onTap: () {
                int leagueID = int.parse(widget.leagueDataEntity.leagueID!);
                GoRouter.of(context)
                    .pushNamed(AppRoutesName.leaguePage, extra: leagueID);
              },
              leading: Text(
                widget.leagueDataEntity.leagueName ?? "",
                style: AppTextStyles.headingTextStyle(),
              ),
              trailing: InkWell(
                onTap: () {
                  BlocProvider.of<FavouriteLeagueBloc>(context).add(
                      DeleteFavouriteLeague(
                          leagueID: widget.leagueDataEntity.leagueID!,
                          uid: widget.uid));
                },
                child: const Icon(
                  Icons.star,
                  color: Colors.orangeAccent,
                ),
              ),

              // SliverList.separated(
              //     // physics: NeverScrollableScrollPhysics(),
              //     // shrinkWrap: true,
              //     itemBuilder: (context, index) {
              //       return MatchCard(
              //         match: listMatch[index],
              //         heightSize: 70,
              //       );
              //     },
              //     separatorBuilder: (context, index) =>
              //         DividerHelper.basicDivider(),
              //     itemCount: listMatch.length),
            ),
          );
        } else {
          return const SizedBox();
        }
      },
      listener: (context, state) {
        if (state is MatchesFetchSuccess) {
          // final data = state.leagueMatches;
          // getCurrentData(data.stage![0].matches!);
        }
      },
    );
  }
}
