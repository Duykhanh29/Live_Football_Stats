import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:live_football_stats/core/constants/app_routes_name.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/league.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/league/a_league/league_bloc.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/league/a_league/league_event.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/match/matches/matches_bloc.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/match/matches/matches_event.dart';
import 'package:live_football_stats/features/main_feature/presentation/pages/league/league_page.dart';

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
      trailing: InkWell(
        onTap: () {
          
        },
        child: Icon(Icons.star),
      ),
    );
  }
}
