/// Formats an amount as app-standard currency, e.g. `$67.00`.
String formatPrice(double amount) => '\$${amount.toStringAsFixed(2)}';

/// Snapshot of a confirmed appointment, shown on the booking-success screen.
class BookingSummary {
  const BookingSummary({
    required this.clinicName,
    required this.serviceName,
    required this.date,
    required this.time,
    required this.total,
    required this.bookingRef,
  });

  /// Builds a summary with a freshly generated booking reference.
  factory BookingSummary.create({
    required String clinicName,
    required String serviceName,
    required DateTime date,
    required String time,
    required double total,
  }) {
    return BookingSummary(
      clinicName: clinicName,
      serviceName: serviceName,
      date: date,
      time: time,
      total: total,
      bookingRef: _generateBookingRef(),
    );
  }

  final String clinicName;
  final String serviceName;
  final DateTime date;
  final String time;
  final double total;
  final String bookingRef;

  static const _weekdayNames = [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun',
  ];

  static const _monthNames = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  String get formattedDate =>
      '${_weekdayNames[date.weekday - 1]}, ${date.day} '
      '${_monthNames[date.month - 1]} ${date.year}';

  String get formattedTotal => formatPrice(total);

  static String _generateBookingRef() {
    final now = DateTime.now();
    return '#BK-${now.year}${_pad(now.month)}${_pad(now.day)}-'
        '${now.millisecondsSinceEpoch % 1000}';
  }

  static String _pad(int n) => n.toString().padLeft(2, '0');
}

class DateOptionModel {
  DateOptionModel(this.date);

  final DateTime date;

  static const _weekdayNames = [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun',
  ];

  String get dayName => _weekdayNames[date.weekday - 1];
  String get dayNumber => date.day.toString();

  bool isSameDate(DateTime other) =>
      date.year == other.year &&
      date.month == other.month &&
      date.day == other.day;
}
