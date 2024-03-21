import 'package:equatable/equatable.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/team_response.dart';

class Stadium extends Equatable {
  int? id;
  List<TeamResponse>? teams;
  String? name;
  String? city;
  Stadium({this.city, this.id, this.name, this.teams});
  @override
  // TODO: implement props
  List<Object?> get props => [id, name, city, teams];
}
