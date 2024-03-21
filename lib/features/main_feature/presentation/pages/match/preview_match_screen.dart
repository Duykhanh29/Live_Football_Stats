import 'package:flutter/material.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/country.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/league_response.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/match_preview.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/stage_response.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/team_response.dart';
import 'package:live_football_stats/features/main_feature/presentation/widgets/matches/preview_match_data_widget.dart';

import '../../widgets/matches/preview_basic_info_widget.dart';
import '../../widgets/matches/preview_match_content_widget.dart';

class PreviewMatchScreen extends StatelessWidget {
  PreviewMatchScreen({super.key});
  MatchPreview matchPreview = MatchPreview(
      id: 879421,
      date: "02-03-2024",
      time: "20:00",
      wordCount: 551,
      country: Country(id: 60, name: "spain"),
      league: LeagueResponse(id: 297, name: "La Liga"),
      stage: StageResponse(id: 11273, name: "Primera Division", isActive: true),
      teams: Teams(
          home: TeamResponse(id: 4890, name: "Valencia"),
          away: TeamResponse(id: 4883, name: "Real Madrid")),
      matchData: MatchData(
          weather: Weather(
              tempF: 57.2, tempC: 14.0, description: "patchy rain nearby"),
          excitementRating: 5.5,
          prediction: Prediction(type: "match_winner", choice: "away")),
      previewContent: [
        PreviewContent(
            name: "p1",
            content:
                "Two giants of the Spain La Liga league, Valencia and Real Madrid, are set to go head-to-head at the Estadio De Mestalla stadium in Valencia this Saturday, March 2 at 20:00 (UTC). Fans can expect a thrilling match as both teams will battle it out for victory. However, it won't just be the players facing some challenges, as there is predicted to be patchy rain nearby and temperatures of 57 degrees (F). In their previous encounter on November 11, 2023, Real Madrid took the win with a dominant 5-1 score, with the talented Vinícius Júnior scoring 2 goals for his team."),
        PreviewContent(
            name: "h1",
            content:
                "Consistent Scoring: Hugo Duro's Impact at Estadio De Mestalla Stadium"),
        PreviewContent(
            name: "p2",
            content:
                "Valencia has been displaying impressive performances on their home turf, triumphing in 3 matches and securing a draw in 1 out of their last 5 games. Their goal scoring abilities have been on point at Estadio De Mestalla, scoring a total of 7 goals in their last 5 home matches. In their recent La Liga encounter, they held Sevilla to a goalless draw. The team also has the advantage of having a fit star player, Hugo Duro, who has already scored 10 goals in this tournament. Against opponents of similar ranking, Valencia has won 1 match, lost 4, and drawn 0, scoring an average of 0.4 goals and conceding 1.2 goals. However, with Duro back in the game and having a record of 5 goals in 13 home games this season, the team is looking to improve their goal tally and secure a win in their upcoming match."),
        PreviewContent(
            name: "h2",
            content:
                "Dazzling Double: Vinícius Júnior's Impressive Performance Seals Win for His Team"),
        PreviewContent(
            name: "p3",
            content:
                "Real Madrid has been on a roll in their away games, with 3 wins and 1 draw in their last 5 matches. They have also been scoring well on the road, netting a total of 8 goals in their last 5 away games. In their most recent match, they secured a tight 1-0 victory over Sevilla in La Liga. Furthermore, the team can count on the impressive talent of J. Bellingham, who has scored a total of 16 goals so far in the tournament. With a healthy squad, Real Madrid is heading into this game with confidence. In their previous encounter on 11.11.2023, Vinícius Júnior scored an impressive 2 goals, contributing to their 5-1 win over the opposing team. "),
        PreviewContent(
            name: "p4",
            content:
                "In the last 8 matches, the average total of goals between the two clubs has been 3.38, making for exciting and competitive games. In the 63 times that Valencia and Real Madrid have faced each other, Valencia has emerged victorious 14 times while also drawing 14 times. On the other hand, Real Madrid has claimed victory in 35 of their encounters. This longstanding rivalry between the two powerhouses makes for an exhilarating and unpredictable matchup every time they meet on the field"),
        PreviewContent(
            name: "h3",
            content:
                "The Explosive Showdown: A Recap of the 9 Goals in Valencia vs. Real Madrid's Latest Match"),
        PreviewContent(
            name: "p5",
            content:
                "In their previous encounter, Valencia and Real Madrid put on an astonishing display of football, with a combined total of 9 goals in a thrilling 5-1 match. As they prepare to face each other once again, the anticipation for another electrifying game is palpable. With their determination and skill, the players are poised to deliver another captivating performance and create yet another memorable outcome.")
      ]);
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      shrinkWrap: true,
      slivers: [
        // SliverToBoxAdapter(
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        SliverToBoxAdapter(
          child: PreviewBasicInfoWidget(
            matchPreview: matchPreview,
          ),
        ),
        SliverToBoxAdapter(
          child: PreviewMatchDataWidget(
            matchPreview: matchPreview,
          ),
        ),
        PreviewContentWidget(
          matchPreview: matchPreview,
        ),
      ],
      // ),
      // )
      // ],
    );
  }
}
