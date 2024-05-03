import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/favourite/favourite_league/favourite_league_bloc.dart';
import 'package:live_football_stats/features/main_feature/presentation/widgets/favourite/favourite_league_grid_view.dart';
import 'package:live_football_stats/features/main_feature/presentation/widgets/favourite/favourite_team_grid_view.dart';

import '../../blocs/favourite/favourite_league/favourite_league_event.dart';
import '../../blocs/favourite/favourite_team/favourite_team_bloc.dart';
import '../../blocs/favourite/favourite_team/favourite_team_event.dart';

class MainFavouriteView extends StatefulWidget {
  MainFavouriteView({super.key, required this.uid});
  String uid;
  @override
  State<MainFavouriteView> createState() => _MainFavouriteViewState();
}

class _MainFavouriteViewState extends State<MainFavouriteView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<FavouriteLeagueBloc>(context)
        .add(FecthFavouriteLeagues(uid: widget.uid));
    BlocProvider.of<FavouriteTeamBloc>(context)
        .add(FecthFavouriteTeams(uid: widget.uid));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: const CustomScrollView(
        // mainAxisAlignment: MainAxisAlignment.start,
        slivers: [
          SliverToBoxAdapter(child: FavouriteLeagueGridView()),
          SliverToBoxAdapter(child: FavouriteTeamGridView()),
        ],
      ),
    );
  }
}
