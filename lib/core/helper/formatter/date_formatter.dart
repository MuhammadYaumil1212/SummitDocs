import 'package:intl/intl.dart';

class DateFormatter {
  static String parseFromString(String dateString) {
    try {
      final inputFormat = DateFormat("dd/MM/yyyy 'at' H");
      final outputFormat = DateFormat('yyyy-MM-dd');
      final dateTime = inputFormat.parse(dateString);
      return outputFormat.format(dateTime);
    } catch (e) {
      // Fallback jika format salah
      return '';
    }
  }
}
