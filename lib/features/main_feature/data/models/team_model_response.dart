import 'package:live_football_stats/features/main_feature/domain/entities/team_response.dart';

class TeamModelResponse {
  int id;
  String name;

  TeamModelResponse({
    required this.id,
    required this.name,
  });

  factory TeamModelResponse.fromJson(Map<String, dynamic> json) =>
      TeamModelResponse(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
  TeamResponse toEntity() {
    return TeamResponse(id: id, name: name);
  }
}
