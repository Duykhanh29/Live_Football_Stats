import 'package:flutter/material.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/country.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/league.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/league/leagues/leagues_bloc.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/league/leagues/leagues_event.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/league/leagues/leagues_state.dart';
import 'package:live_football_stats/features/main_feature/presentation/pages/league/all_league_of_country_page.dart';

class ExpansionLeagueCard extends StatelessWidget {
  ExpansionLeagueCard({super.key, required this.country});
  Country country;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: ListTile(
          // onExpansionChanged: ,
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) {
                return AllLeagueOfCountryPage(country: country);
              },
            ));
          },
          title: Text(country.name!),
        ));
  }
}
