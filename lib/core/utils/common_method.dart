import 'package:live_football_stats/core/utils/format_date.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/favourite/favourite_league_entity.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/league_matches.dart';

import '../../features/main_feature/domain/entities/favourite/favourite_team_entity.dart';

class CommonMethods {
  CommonMethods._();
  static int findCurrentIndexMatch(List<LeagueMatch> matches, DateTime time) {
    String currentTime;
    DateTime dateTime = time;
    int result;
    do {
      currentTime = FormatDate.dateToDateAndTime(dateTime);

      result = matches.indexWhere((match) => match.date! == currentTime);
      if (result == -1) {
        dateTime = dateTime.add(const Duration(days: 1));
      }
    } while (result == -1);
    return result;
  }

  static List<LeagueMatch> getCurrentListMatches(
      List<LeagueMatch> matches, DateTime time) {
    String currentTime;
    DateTime dateTime = time;
    int result;
    List<LeagueMatch> list = [];
    do {
      currentTime = FormatDate.dateToDateAndTime(dateTime);

      result = matches.indexWhere((match) => match.date! == currentTime);
      if (result == -1) {
        dateTime = dateTime.add(const Duration(days: 1));
      } else {
        for (var element in matches) {
          list.add(element);
        }
      }
    } while (result == -1);
    return list;
  }

  static bool isHeadingContent(String text) {
    String firstLetter = text.substring(0, 1);
    if (firstLetter.toLowerCase() == "h") {
      return true;
    }
    return false;
  }

  static String convertHttpToWS(String url) {
    if (url.startsWith('https://')) {
      return 'wss://${url.substring(8)}';
    } else {
      return 'ws://${url.substring(7)}';
    }
  }

  static bool isFavouriteLeagueExisted(
      String leagueID, FavouriteLeagueEntity leagueEntity) {
    for (var i = 0; i < leagueEntity.leagues!.length; i++) {
      if (leagueID == leagueEntity.leagues![i].leagueID) {
        return true;
      }
    }
    return false;
  }

  static bool isFavouriteTeamExisted(
      String teamID, FavouriteTeamEntity teamEntity) {
    for (var i = 0; i < teamEntity.teams!.length; i++) {
      if (teamID == teamEntity.teams![i].teamID) {
        return true;
      }
    }
    return false;
  }
}
