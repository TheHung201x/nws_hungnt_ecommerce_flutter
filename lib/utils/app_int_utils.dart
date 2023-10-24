import 'package:intl/intl.dart';

extension IntExtension on int {
  //format price product
  String get formatPrice {
    NumberFormat formatter = NumberFormat("#,##0.00");
    String formattedPrice = formatter.format(this);
    return formattedPrice;
  }
}
