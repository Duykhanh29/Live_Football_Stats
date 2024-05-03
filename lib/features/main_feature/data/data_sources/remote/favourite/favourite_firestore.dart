import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../models/favourite/favourite_league_model.dart';
import '../../../models/favourite/favourite_team_model.dart';

abstract class FavouriteFirestore {
  Future<FavouriteLeagueModel?> getFavouriteLeague(String uid);
  Future<FavouriteTeamModel?> getFavouriteTeam(String uid);
  Future<bool> addFavouriteTeam(
      {required String uid, required TeamDataModel teamData});
  Future<bool> addFavouriteLeague(
      {required String uid, required LeagueDataModel leagueData});
  Future<bool> deleteFavouriteTeam(
      {required String uid, required String teamID});
  Future<bool> deleteFavouriteLeague(
      {required String uid, required String leagueID});
}

class FavouriteFirestoreImpl implements FavouriteFirestore {
  FirebaseFirestore firestore;
  FavouriteFirestoreImpl({required this.firestore});
  @override
  Future<bool> addFavouriteLeague(
      {required String uid, required LeagueDataModel leagueData}) async {
    try {
      final doc = firestore.collection('favouriteLeagues').doc(uid);
      final result = await doc.get();
      if (result.exists) {
        final data = result.data();
        FavouriteLeagueModel leagueModel = FavouriteLeagueModel.fromJson(data!);
        leagueModel.leagues!.add(leagueData);
        await doc.update(leagueModel.toJson());
      } else {
        FavouriteLeagueModel leagueModel =
            FavouriteLeagueModel(leagues: [leagueData], uid: uid);
        await doc.set(leagueModel.toJson());
      }
      return true;
    } catch (e) {
      print("An error: ${e.toString()}");
      throw Exception(e);
    }
  }

  @override
  Future<bool> addFavouriteTeam(
      {required String uid, required TeamDataModel teamData}) async {
    try {
      final doc = firestore.collection('favouriteTeams').doc(uid);
      final result = await doc.get();
      if (result.exists) {
        final data = result.data();
        FavouriteTeamModel teamModel = FavouriteTeamModel.fromJson(data!);
        teamModel.teams!.add(teamData);
        await doc.update(teamModel.toJson());
      } else {
        FavouriteTeamModel teamModel =
            FavouriteTeamModel(teams: [teamData], uid: uid);
        await doc.set(teamModel.toJson());
      }
      return true;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<bool> deleteFavouriteLeague(
      {required String uid, required String leagueID}) async {
    try {
      final leagueDoc = firestore.collection('favouriteLeagues').doc(uid);
      final snapshot = await leagueDoc.get();
      if (snapshot.exists) {
        final data = snapshot.data();
        FavouriteLeagueModel leagueModel = FavouriteLeagueModel.fromJson(data!);
        leagueModel.leagues!
            .removeWhere((element) => element.leagueID == leagueID);
        leagueDoc.update(leagueModel.toJson());
      }
      return true;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<bool> deleteFavouriteTeam(
      {required String uid, required String teamID}) async {
    try {
      final teamDoc = firestore.collection('favouriteTeams').doc(uid);
      final snapshot = await teamDoc.get();
      if (snapshot.exists) {
        final data = snapshot.data();
        FavouriteTeamModel teamModel = FavouriteTeamModel.fromJson(data!);
        teamModel.teams!.removeWhere((element) => element.teamID == teamID);
        teamDoc.update(teamModel.toJson());
      }
      return true;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<FavouriteLeagueModel?> getFavouriteLeague(String uid) async {
    try {
      final leagueDoc = firestore.collection('favouriteLeagues').doc(uid);
      final snapshot = await leagueDoc.get();
      if (snapshot.exists) {
        final data = snapshot.data();
        FavouriteLeagueModel leagueModel = FavouriteLeagueModel.fromJson(data!);
        return leagueModel;
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<FavouriteTeamModel?> getFavouriteTeam(String uid) async {
    try {
      final teamDoc = firestore.collection('favouriteTeams').doc(uid);
      final snapshot = await teamDoc.get();
      if (snapshot.exists) {
        final data = snapshot.data();
        FavouriteTeamModel teamModel = FavouriteTeamModel.fromJson(data!);
        return teamModel;
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
