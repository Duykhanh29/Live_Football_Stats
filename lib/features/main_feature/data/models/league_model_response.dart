import 'package:live_football_stats/features/main_feature/domain/entities/league_response.dart';

class LeagueModelResponse {
  int id;
  String name;

  LeagueModelResponse({
    required this.id,
    required this.name,
  });

  factory LeagueModelResponse.fromJson(Map<String, dynamic> json) =>
      LeagueModelResponse(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
  LeagueResponse toEntity() {
    return LeagueResponse(id: id, name: name);
  }
}
