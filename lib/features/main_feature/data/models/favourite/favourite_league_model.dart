import '../../../domain/entities/favourite/favourite_league_entity.dart';

class FavouriteLeagueModel {
  String? uid;
  List<LeagueDataModel>? leagues;

  FavouriteLeagueModel({this.uid, this.leagues});
  factory FavouriteLeagueModel.fromJson(Map<String, dynamic> json) {
    return FavouriteLeagueModel(
        leagues: json['leagues'] != null
            ? (json['leagues'] as List<dynamic>)
                .map((e) => LeagueDataModel.fromJson(e))
                .toList()
            : null,
        uid: json['uid']);
  }
  Map<String, dynamic> toJson() => {
        'leagues': leagues?.map((e) => e.toJson()).toList(),
        'uid': uid,
      };
  FavouriteLeagueEntity toEntity() {
    return FavouriteLeagueEntity(
        leagues: leagues?.map((e) => e.toEntity()).toList(), uid: uid);
  }

  factory FavouriteLeagueModel.fromEntity(FavouriteLeagueEntity leagueEntity) {
    return FavouriteLeagueModel(
        leagues: leagueEntity.leagues
            ?.map((e) => LeagueDataModel.fromEntity(e))
            .toList(),
        uid: leagueEntity.uid);
  }
}

class LeagueDataModel {
  String? leagueID;
  String? leagueName;
  LeagueDataModel({this.leagueID, this.leagueName});
  factory LeagueDataModel.fromJson(Map<String, dynamic> json) {
    return LeagueDataModel(
        leagueID: json['leagueID'], leagueName: json['leagueName']);
  }
  Map<String, dynamic> toJson() => {
        'leagueID': leagueID,
        'leagueName': leagueName,
      };
  LeagueDataEntity toEntity() {
    return LeagueDataEntity(leagueID: leagueID, leagueName: leagueName);
  }

  factory LeagueDataModel.fromEntity(LeagueDataEntity leagueEntity) {
    return LeagueDataModel(
        leagueID: leagueEntity.leagueID, leagueName: leagueEntity.leagueName);
  }
}
