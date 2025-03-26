import 'package:intl/intl.dart';

String formatCurrency(double amount) {
  final format = NumberFormat.currency(locale: 'en_US', symbol: '\$');
  return format.format(amount);
}
