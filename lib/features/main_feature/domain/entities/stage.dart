import 'package:equatable/equatable.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/league_response.dart';

class Stage extends Equatable {
  int count;
  dynamic next;
  dynamic previous;
  List<Result> results;

  Stage({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [count, previous, next, results];
}

class Result extends Equatable {
  int id;
  LeagueResponse league;
  String season;
  String name;
  bool hasGroups;
  bool isActive;

  Result({
    required this.id,
    required this.league,
    required this.season,
    required this.name,
    required this.hasGroups,
    required this.isActive,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [league, id, isActive, hasGroups, season, name];
}
