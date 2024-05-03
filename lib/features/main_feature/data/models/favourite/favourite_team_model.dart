import 'package:live_football_stats/features/main_feature/domain/entities/favourite/favourite_team_entity.dart';

class FavouriteTeamModel {
  String? uid;
  List<TeamDataModel>? teams;
  FavouriteTeamModel({this.uid, this.teams});
  factory FavouriteTeamModel.fromJson(Map<String, dynamic> json) {
    return FavouriteTeamModel(
        teams: json['teams'] != null
            ? (json['teams'] as List<dynamic>)
                .map((e) => TeamDataModel.fromJson(e))
                .toList()
            : null,
        uid: json['uid']);
  }
  Map<String, dynamic> toJson() => {
        'teams': teams?.map((e) => e.toJson()).toList(),
        'uid': uid,
      };
  FavouriteTeamEntity toEntity() {
    return FavouriteTeamEntity(
        teams: teams?.map((e) => e.toEntity()).toList(), uid: uid);
  }

  factory FavouriteTeamModel.fromEntity(FavouriteTeamEntity teamEntity) {
    return FavouriteTeamModel(
        teams:
            teamEntity.teams?.map((e) => TeamDataModel.fromEntity(e)).toList(),
        uid: teamEntity.uid);
  }
}

class TeamDataModel {
  String? teamID;
  String? teamName;
  TeamDataModel({this.teamID, this.teamName});
  factory TeamDataModel.fromJson(Map<String, dynamic> json) {
    return TeamDataModel(teamID: json['teamID'], teamName: json['teamName']);
  }
  Map<String, dynamic> toJson() => {
        'teamID': teamID,
        'teamName': teamName,
      };
  TeamDataEntity toEntity() {
    return TeamDataEntity(teamID: teamID, teamName: teamName);
  }

  factory TeamDataModel.fromEntity(TeamDataEntity teamEntity) {
    return TeamDataModel(
        teamID: teamEntity.teamID, teamName: teamEntity.teamName);
  }
}
