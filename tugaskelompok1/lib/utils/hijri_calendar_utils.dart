class HijriDate {
  final int year;
  final int month;
  final int day;

  const HijriDate({
    required this.year,
    required this.month,
    required this.day,
  });
}

class HijriCalendarUtils {
  static const List<String> _bulanMasehi = [
    'Januari',
    'Februari',
    'Maret',
    'April',
    'Mei',
    'Juni',
    'Juli',
    'Agustus',
    'September',
    'Oktober',
    'November',
    'Desember',
  ];

  static const List<String> _bulanHijriah = [
    'Muharram',
    'Safar',
    'Rabiul Awal',
    'Rabiul Akhir',
    'Jumadil Awal',
    'Jumadil Akhir',
    'Rajab',
    'Syaban',
    'Ramadan',
    'Syawal',
    'Zulkaidah',
    'Zulhijah',
  ];

  static DateTime _normalize(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  static String formatMasehi(DateTime date) {
    final d = _normalize(date);
    return '${d.day} ${_bulanMasehi[d.month - 1]} ${d.year}';
  }

  static HijriDate gregorianToHijri(DateTime date) {
    final d = _normalize(date);

    final a = (14 - d.month) ~/ 12;
    final y = d.year + 4800 - a;
    final m = d.month + (12 * a) - 3;

    final julianDay =
        d.day +
        ((153 * m + 2) ~/ 5) +
        365 * y +
        (y ~/ 4) -
        (y ~/ 100) +
        (y ~/ 400) -
        32045;

    int l = julianDay - 1948440 + 10632;
    final n = (l - 1) ~/ 10631;
    l = l - 10631 * n + 354;

    final j =
        (((10985 - l) ~/ 5316) * ((50 * l) ~/ 17719)) +
        ((l ~/ 5670) * ((43 * l) ~/ 15238));

    l =
        l -
        (((30 - j) ~/ 15) * ((17719 * j) ~/ 50)) -
        ((j ~/ 16) * ((15238 * j) ~/ 43)) +
        29;

    final month = (24 * l) ~/ 709;
    final day = l - ((709 * month) ~/ 24);
    final year = 30 * n + j - 30;

    return HijriDate(year: year, month: month, day: day);
  }

  static String formatHijri(DateTime date) {
    final hijri = gregorianToHijri(date);
    return '${hijri.day} ${_bulanHijriah[hijri.month - 1]} ${hijri.year} H';
  }
}
