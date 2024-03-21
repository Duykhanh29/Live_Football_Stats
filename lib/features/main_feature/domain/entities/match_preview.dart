// To parse this JSON data, do
//
//     final previewMatch = previewMatchFromJson(jsonString);

import 'package:equatable/equatable.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/country.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/league_response.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/stage_response.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/team_response.dart';

class MatchPreview extends Equatable {
  int id;
  String date;
  String time;
  int wordCount;
  Country country;
  LeagueResponse league;
  StageResponse stage;
  Teams teams;
  MatchData matchData;
  List<PreviewContent> previewContent;

  MatchPreview({
    required this.id,
    required this.date,
    required this.time,
    required this.wordCount,
    required this.country,
    required this.league,
    required this.stage,
    required this.teams,
    required this.matchData,
    required this.previewContent,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        date,
        time,
        wordCount,
        stage,
        previewContent,
        matchData,
        teams,
        league,
        country
      ];
}

class MatchData extends Equatable {
  Weather weather;
  double excitementRating;
  Prediction prediction;

  MatchData({
    required this.weather,
    required this.excitementRating,
    required this.prediction,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [weather, excitementRating, prediction];
}

class Prediction extends Equatable {
  String type;
  String choice;

  Prediction({
    required this.type,
    required this.choice,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [type, choice];
}

class Weather extends Equatable {
  double tempF;
  double tempC;
  String description;

  Weather({
    required this.tempF,
    required this.tempC,
    required this.description,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [tempC, tempF, description];
}

class PreviewContent extends Equatable {
  String name;
  String content;

  PreviewContent({
    required this.name,
    required this.content,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [name, content];
}

class Teams extends Equatable {
  TeamResponse home;
  TeamResponse away;

  Teams({
    required this.home,
    required this.away,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [home, away];
}
