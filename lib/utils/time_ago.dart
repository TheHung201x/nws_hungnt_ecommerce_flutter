import 'package:ecommerce/generated/l10n.dart';
import 'package:ecommerce/models/enums/max_time_ago.dart';
import 'package:intl/intl.dart';

String getTimeAgo(String date,
    [maxAgoType = MaxAgoType.year, showTime = true]) {
  DateTime currentDate = DateTime.now();

  var different = currentDate.difference(DateTime.parse(date));

  if (different.inDays > 365) {
    if (maxAgoType != MaxAgoType.year) return formatDate(date, showTime);

    return "${(different.inDays / 365).floor()} ${(different.inDays / 365).floor() == 1 ? S.current.year : S.current.years} ${S.current.ago}";
  }

  if (different.inDays > 30) {
    if (maxAgoType.index < MaxAgoType.month.index) {
      return formatDate(date, showTime);
    }

    return "${(different.inDays / 30).floor()} ${(different.inDays / 30).floor() == 1 ?  S.current.month :  S.current.months} ${S.current.ago}";
  }

  if (different.inDays > 7) {
    if (maxAgoType.index < MaxAgoType.week.index) {
      return formatDate(date, showTime);
    }

    return "${(different.inDays / 7).floor()} ${(different.inDays / 7).floor() == 1 ?  S.current.week :  S.current.weeks } ${S.current.ago}";
  }

  if (different.inDays > 0) {
    if (maxAgoType.index < MaxAgoType.day.index) {
      return formatDate(date, showTime);
    }

    return "${different.inDays} ${different.inDays == 1 ? S.current.day : S.current.days} ${S.current.ago}";
  }

  if (different.inHours > 0) {
    if (maxAgoType.index < MaxAgoType.hour.index) {
      return formatDate(date, showTime);
    }

    return "${different.inHours} ${different.inHours == 1 ? S.current.hour : S.current.hours} ${S.current.ago}";
  }

  if (different.inMinutes > 0) {
    if (maxAgoType.index < MaxAgoType.minute.index) {
      return formatDate(date, showTime);
    }

    return "${different.inMinutes} ${different.inMinutes == 1 ? S.current.minute :  S.current.minutes} ${S.current.ago}";
  }

  if (different.inMinutes == 0) {
    if (maxAgoType.index < MaxAgoType.minute.index) {
      return formatDate(date, showTime);
    }

    return S.current.just_now;
  }

  return formatDate(date, showTime);
}

String formatDate(String date, bool showTime) =>
    DateFormat('${showTime ? 'HH:mm, ' : ''}dd/MM/yyyy').format(
      DateTime.parse(date),
    );
