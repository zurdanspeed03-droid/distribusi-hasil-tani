import 'package:intl/intl.dart';

class FormatHelper {
  static String formatCurrency(int value) {
    final formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    return formatter.format(value);
  }

  static String formatDate(DateTime date) {
    final formatter = DateFormat('dd MMM yyyy, HH:mm');
    return formatter.format(date);
  }
}
