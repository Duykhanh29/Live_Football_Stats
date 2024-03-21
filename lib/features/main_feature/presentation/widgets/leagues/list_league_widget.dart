import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/country.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/league/a_league/league_event.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/league/country/contry_state.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/league/country/country_bloc.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/league/leagues/leagues_bloc.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/league/leagues/leagues_event.dart';
import 'package:live_football_stats/features/main_feature/presentation/blocs/league/leagues/leagues_state.dart';
import 'package:live_football_stats/features/main_feature/presentation/widgets/leagues/a_league_card.dart';
import 'package:live_football_stats/features/main_feature/presentation/widgets/leagues/expansion_league_card.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ListLeagueWidget extends StatelessWidget {
  const ListLeagueWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return
        // RefreshIndicator(
        //   onRefresh: () async {
        //     BlocProvider.of<LeaguesBloc>(context).add(AllLeagueFetched());
        //   },
        //   child:
        BlocBuilder<CountryBloc, CountryState>(
      builder: (context, state) {
        if (state is AllCountryFetchSuccess) {
          return SliverList(
            delegate: SliverChildBuilderDelegate(
                (context, index) => ExpansionLeagueCard(
                      country: state.allCountry![index],
                    ),
                childCount: state.allCountry!.length),
          );
        } else if (state is CountryFetchFail) {
          return const SliverToBoxAdapter(
            child: Center(
              child: Text("Something went wrong"),
            ),
          );
        } else {
          return SliverToBoxAdapter(
            child: Center(
              child: LoadingAnimationWidget.staggeredDotsWave(
                color: Colors.black,
                size: 30,
              ),
            ),
          );
        }
      },
      // ),
    );
  }
}
