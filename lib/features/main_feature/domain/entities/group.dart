import 'package:equatable/equatable.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/league_response.dart';

class Group extends Equatable {
  int? count;
  dynamic next;
  dynamic previous;
  List<Result>? results;

  Group({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [count, next, previous, results];
}

class Result extends Equatable {
  int? id;
  LeagueResponse? league;
  String? season;
  Stage? stage;
  String? name;

  Result({
    required this.id,
    required this.league,
    required this.season,
    required this.stage,
    required this.name,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [id, league, season, stage, name];
}

class Stage extends Equatable {
  int? id;
  String? name;

  Stage({
    required this.id,
    required this.name,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [id, name];
}
