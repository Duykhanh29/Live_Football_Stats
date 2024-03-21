import 'package:live_football_stats/features/main_feature/data/models/team_model_response.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/stadium.dart';

class StadiumModel {
  int id;
  List<TeamModelResponse> teams;
  String name;
  String city;

  StadiumModel({
    required this.id,
    required this.teams,
    required this.name,
    required this.city,
  });

  factory StadiumModel.fromJson(Map<String, dynamic> json) => StadiumModel(
        id: json["id"],
        teams: List<TeamModelResponse>.from(
            json["teams"].map((x) => TeamModelResponse.fromJson(x))),
        name: json["name"],
        city: json["city"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "teams": List<dynamic>.from(teams.map((x) => x.toJson())),
        "name": name,
        "city": city,
      };
  Stadium toEntity() {
    return Stadium(
        city: city,
        id: id,
        name: name,
        teams: teams.map((e) => e.toEntity()).toList());
  }
}
