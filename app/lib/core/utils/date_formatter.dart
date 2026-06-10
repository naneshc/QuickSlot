import 'package:intl/intl.dart';

class DateFormatter {
  static String toApiDate(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }

  static String toHumanDate(DateTime dateTime) {
    return DateFormat('EEE, MMM dd, yyyy').format(dateTime);
  }

  static String toHumanDateString(String apiDate) {
    try {
      final parsed = DateTime.parse(apiDate);
      return toHumanDate(parsed);
    } catch (_) {
      return apiDate;
    }
  }
}
