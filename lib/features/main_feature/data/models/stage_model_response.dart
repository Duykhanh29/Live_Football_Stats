import 'package:live_football_stats/features/main_feature/domain/entities/stage_response.dart';

class StageModelResponse {
  int id;
  String name;
  bool isActive;

  StageModelResponse({
    required this.id,
    required this.name,
    required this.isActive,
  });

  factory StageModelResponse.fromJson(Map<String, dynamic> json) =>
      StageModelResponse(
        id: json["id"],
        name: json["name"],
        isActive: json["is_active"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "is_active": isActive,
      };
  StageResponse toEntity() {
    return StageResponse(id: id, name: name, isActive: isActive);
  }
}
