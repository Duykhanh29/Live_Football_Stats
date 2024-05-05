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

  static List<LeagueMatch> getAllMatchesOfAllStage(List<Stage> listStage) {
    List<LeagueMatch> list = [];
    for (var i = 0; i < listStage.length; i++) {
      list.addAll(listStage[i].matches ?? []);
    }
    return list;
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

  static List<LeagueMatch> sortLeagueMatchesInAStage(
      List<LeagueMatch> matches) {
    matches.sort(
      (a, b) {
        DateTime dateTime1 = FormatDate.dateTimeStringToDate(a.date!);
        DateTime dateTime2 = FormatDate.dateTimeStringToDate(b.date!);
        if (dateTime1.compareTo(dateTime2) > 0) {
          return -1;
        }
        return 1;
      },
    );
    return matches;
  }

  static List<Stage> sortStages(List<Stage> stages) {
    stages.sort(
      (a, b) {
        List<LeagueMatch> leagueA = sortLeagueMatchesInAStage(a.matches!);
        List<LeagueMatch> leagueB = sortLeagueMatchesInAStage(b.matches!);
        DateTime dateTime1 =
            FormatDate.dateTimeStringToDate(leagueA.first.date!);
        DateTime dateTime2 =
            FormatDate.dateTimeStringToDate(leagueB.last.date!);
        if (dateTime1.compareTo(dateTime2) > 0) {
          return 1;
        }
        return -1;
      },
    );
    return stages;
  }

  static List<int> getCurrentMatchOfCupLeague(
      List<Stage> stages, DateTime time) {
    List<int> list = [];
    String currentTime;
    DateTime dateTime = time;
    int matchIndex = -1;
    int stageIndex = -1;
    do {
      for (var i = 0; i < stages.length; i++) {
        currentTime = FormatDate.dateToDateAndTime(dateTime);
        matchIndex = stages[i]
            .matches!
            .indexWhere((match) => match.date! == currentTime);
        if (matchIndex == -1) {
          dateTime = dateTime.add(const Duration(days: 1));
        } else {
          stageIndex = i;
        }
      }
    } while (matchIndex == -1 || stageIndex == -1);
    list.add(stageIndex);
    list.add(matchIndex);
    return list;
  }
}
