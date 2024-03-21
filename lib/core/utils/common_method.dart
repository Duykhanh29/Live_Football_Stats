import 'package:live_football_stats/core/utils/format_date.dart';
import 'package:live_football_stats/features/main_feature/domain/entities/league_matches.dart';

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

  static bool isHeadingContent(String text) {
    String firstLetter = text.substring(0, 1);
    if (firstLetter.toLowerCase() == "h") {
      return true;
    }
    return false;
  }
}
