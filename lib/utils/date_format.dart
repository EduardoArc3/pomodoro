import 'package:intl/intl.dart';

// transforma fecha a formato 18 Mar 2026
String formatDate(String date) {
  try {
    DateTime parsedDate = DateFormat('dd_MM_yy').parse(date);
    String newDate = DateFormat('dd MMM yyyy', 'es').format(parsedDate);

    List<String> parts = newDate.split(' ');
    if (parts.length == 3) {
      String month = parts[1];
      parts[1] = month[0].toUpperCase() + month.substring(1);
      return parts.join(' ');
    }

    return newDate;
  } catch (e) {
    return date;
  }
}
