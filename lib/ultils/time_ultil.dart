int getTimeOnline({DateTime? time}) {
  DateTime now = DateTime.now().toLocal();
  int minute = now.difference(time!).inMinutes;
  if (minute > 60) {
    int hours = now.difference(time).inHours;
    if (hours > 23) {
      int days = now.difference(time).inDays;
      return days;
    }
    return hours;
  }
  return minute;
}

String getTimeOnlineString({DateTime? time}) {
  DateTime now = DateTime.now().toLocal();
  int minute = now.difference(time!).inMinutes;
  if (minute > 60) {
    int hours = now.difference(time).inHours;
    if (hours > 6) {
      return "";
    }
    return "$hours hour ago";
  }
  return "$minute minute ago";
}

String formatDate({required DateTime time}) {
  time = time.toLocal();
  DateTime now = DateTime.now().toLocal();
  String hour = time.hour.toString();
  String minute = time.minute.toString();
  String month = time.month.toString();
  String day = time.day.toString();
  if (time.hour <= 9) hour = "0" + hour;
  if (time.minute <= 9) minute = "0" + minute;
  if (time.month <= 9) month = "0" + month;
  if (time.day <= 9) day = "0" + day;

  if (now.day == time.day) return "$hour:$minute";
  if (now.year == time.year) return "$day-$month at $hour:$minute";
  return time.toString();
}

String formatDateWithoutHour({required DateTime time}) {
  time = time.toLocal();
  DateTime now = DateTime.now().toLocal();
  String hour = time.hour.toString();
  String minute = time.minute.toString();
  String month = time.month.toString();
  String day = time.day.toString();
  if (time.hour <= 9) hour = "0" + hour;
  if (time.minute <= 9) minute = "0" + minute;
  if (time.month <= 9) month = "0" + month;
  if (time.day <= 9) day = "0" + day;

  if (now.day == time.day) return "$hour:$minute";
  if (now.year == time.year) return "$day-$month";
  return time.toString();
}
