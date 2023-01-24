import 'package:intl/intl.dart' as intl;

String formatMoney(double amount) {
  return intl.NumberFormat("#,##0.00", "en_US").format(amount);
}
