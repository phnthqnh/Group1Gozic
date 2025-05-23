import 'package:intl/intl.dart';

class AppUtils{
  String formatCurrency(double amount) {
    final formatter = NumberFormat.currency(
      locale: 'vi_VN',
      symbol: '', // bỏ ký hiệu ₫
      decimalDigits: 0, // không hiển thị phần thập phân
    );
    return "${formatter.format(amount)} VND";
  }
}