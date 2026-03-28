class JawaCalendarUtils {
  static const List<String> hari = [
    'Senin',
    'Selasa',
    'Rabu',
    'Kamis',
    'Jumat',
    'Sabtu',
    'Minggu',
  ];

  static const List<String> bulan = [
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

  static const List<String> pasaran = [
    'Legi',
    'Pahing',
    'Pon',
    'Wage',
    'Kliwon',
  ];

  static const Map<String, int> neptuHari = {
    'Minggu': 5,
    'Senin': 4,
    'Selasa': 3,
    'Rabu': 7,
    'Kamis': 8,
    'Jumat': 6,
    'Sabtu': 9,
  };

  static const Map<String, int> neptuPasaran = {
    'Legi': 5,
    'Pahing': 9,
    'Pon': 7,
    'Wage': 4,
    'Kliwon': 8,
  };

  static DateTime _normalize(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  static String formatMasehi(DateTime date) {
    final d = _normalize(date);
    final namaHari = hari[d.weekday - 1];
    final namaBulan = bulan[d.month - 1];
    return '$namaHari, ${d.day} $namaBulan ${d.year}';
  }

  static String getPasaran(DateTime date) {
    final d = _normalize(date);

    // Acuan terverifikasi pengguna: 28 Maret 2026 = Sabtu Wage.
    final referensi = DateTime(2026, 3, 28);
    const indexReferensi = 3; // Wage
    final selisih = d.difference(referensi).inDays;
    final index = ((indexReferensi + selisih) % 5 + 5) % 5;
    return pasaran[index];
  }

  static String formatJawa(DateTime date) {
    final d = _normalize(date);
    final namaHari = hari[d.weekday - 1];
    return '$namaHari ${getPasaran(d)}';
  }

  static int neptuTotal(DateTime date) {
    final d = _normalize(date);
    final namaHari = hari[d.weekday - 1];
    final namaPasaran = getPasaran(d);
    return (neptuHari[namaHari] ?? 0) + (neptuPasaran[namaPasaran] ?? 0);
  }
}
