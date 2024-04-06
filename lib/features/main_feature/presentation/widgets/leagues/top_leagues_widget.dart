import 'package:flutter/material.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/country.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/league.dart';
import 'package:live_football_stats/features/main_feature/presentation/widgets/leagues/a_league_card.dart';
import 'package:live_football_stats/features/main_feature/presentation/widgets/leagues/top_league_card.dart';

class TopLeaguesWidget extends StatelessWidget {
  TopLeaguesWidget({super.key});
  List<League> topLeagues = [
    League(
        country: Country(id: 60, name: 'spain'),
        id: 297,
        name: "La Liga",
        isCup: false),
    League(
        country: Country(id: 4, name: 'europe'),
        id: 310,
        name: 'UEFA Champions League',
        isCup: true),
    League(
        country: Country(id: 4, name: 'europe'),
        id: 326,
        name: 'Europa League',
        isCup: true),
    League(
        country: Country(id: 4, name: 'europe'),
        id: 323,
        name: 'UEFA European Championship',
        isCup: true),
    League(
        country: Country(id: 8, name: 'england'),
        id: 228,
        name: "Premier League",
        isCup: false),
    League(
        country: Country(id: 8, name: 'england'),
        id: 230,
        name: "FA Cup",
        isCup: false),
    League(
        country: Country(id: 103, name: 'international'),
        id: 313,
        name: "FIFA World Cup",
        isCup: true),
    League(
        country: Country(id: 27, name: 'germany'),
        id: 241,
        name: "Bundesliga",
        isCup: false),
    League(
        country: Country(id: 6, name: 'italy'),
        id: 253,
        name: "Serie A",
        isCup: false),
    League(
        country: Country(id: 9, name: 'france'),
        id: 235,
        name: "Ligue 1",
        isCup: false),
  ];
  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 30, bottom: 10),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate(
          (context, index) => TopLeagueCard(
            league: topLeagues[index],
          ),
          childCount: topLeagues.length,
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 15,
          crossAxisSpacing: 15,
        ),
      ),
    );
  }
}
