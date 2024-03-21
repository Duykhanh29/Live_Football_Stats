import 'package:intl/intl.dart';

class FormatDate {
  FormatDate._();
  static DateTime dateTimeStringToDate(String dateTime) {
    return DateFormat('dd/MM/yyyy').parse(dateTime);
  }

  static DateTime timeStringToDateTime(String time) {
    return DateFormat('hh:mm').parse(time);
  }

  static String dateToDateAndTime(DateTime dateTime) {
    return DateFormat('dd/MM/yyyy').format(dateTime);
  }
}
