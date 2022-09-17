extension DateTimeX on DateTime {
  String get getDateInTimeAgo {
    DateTime currentDate = DateTime.now();
    var dateDifference = currentDate.difference(this);

    int dayAgo = dateDifference.inDays;
    int hourAgo = dateDifference.inHours;
    int minuteAgo = dateDifference.inMinutes;
    int secondAgo = dateDifference.inSeconds;

    if (dayAgo >= 1) {
      return "$dayAgo day(s) ago";
    } else if (hourAgo >= 1) {
      return "$hourAgo hour(s) ago";
    } else if (minuteAgo >= 1) {
      return "$minuteAgo minute(s) ago";
    } else if (secondAgo >= 1) {
      return "$secondAgo second(s) ago";
    } else {
      return "just now";
    }
  }
}
