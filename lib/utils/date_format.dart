import 'package:intl/intl.dart';

// transforma fecha a formato 18 Mar 2026
String formatDate(DateTime date) {
  try {
    String newDate = DateFormat('dd MMM yyyy', 'es').format(date);

    List<String> parts = newDate.split(' ');
    if (parts.length == 3) {
      String month = parts[1];
      parts[1] = month[0].toUpperCase() + month.substring(1);
      return parts.join(' ');
    }

    return newDate;
  } catch (e) {
    return date.toString();
  }
}
