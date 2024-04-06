import 'package:flutter/material.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:live_football_stats/core/constants/app_colors.dart';
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
        margin: const EdgeInsets.only(top: 5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.appBorder)),
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
          title: Text(
            country.name!,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
        ));
  }
}
