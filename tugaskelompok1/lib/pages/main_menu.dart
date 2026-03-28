import 'dart:async';

import 'package:flutter/material.dart';
import 'login_page.dart';
import 'data_kelompok.dart';
import 'operasi_angka.dart';
import 'cek_bilangan.dart';
import 'total_angka.dart';
import 'stopwatch_page.dart';
import 'hitung_piramid.dart';
import 'kalender_jawa_page.dart';
import 'weton_lahir_page.dart';
import 'konversi_hijriah_page.dart';
import '../utils/jawa_calendar_utils.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  DateTime _now = DateTime.now();
  late final Timer _clockTimer;

  @override
  void initState() {
    super.initState();
    _clockTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;
      setState(() {
        _now = DateTime.now();
      });
    });
  }

  @override
  void dispose() {
    _clockTimer.cancel();
    super.dispose();
  }

  String _twoDigits(int value) => value.toString().padLeft(2, '0');

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> menus = [
      {
        't': 'Data Kelompok',
        'i': Icons.people,
        'c': Colors.orange,
        'p': const DataKelompok(),
      },
      {
        't': 'Hitung Angka',
        'i': Icons.add_box,
        'c': Colors.green,
        'p': const OperasiAngka(),
      },
      {
        't': 'Cek Bilangan',
        'i': Icons.numbers,
        'c': Colors.blue,
        'p': const CekBilangan(),
      },
      {
        't': 'Total',
        'i': Icons.summarize,
        'c': Colors.purple,
        'p': const TotalAngka(),
      },
      {
        't': 'Stopwatch',
        'i': Icons.timer,
        'c': Colors.red,
        'p': const StopwatchPage(),
      },
      {
        't': 'Hitung Piramid',
        'i': Icons.architecture,
        'c': Colors.teal,
        'p': const HitungPiramid(),
      },
      {
        't': 'Tanggal Jawa',
        'i': Icons.calendar_month,
        'c': Colors.brown,
        'p': const KalenderJawaPage(),
      },
      {
        't': 'Weton Lahir',
        'i': Icons.cake,
        'c': Colors.indigo,
        'p': const WetonLahirPage(),
      },
      {
        't': 'Masehi ke Hijriah',
        'i': Icons.mosque,
        'c': Colors.deepPurple,
        'p': const KonversiHijriahPage(),
      },
    ];

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Main Menu'),
            const SizedBox(height: 4),
            Text(
              '${JawaCalendarUtils.formatMasehi(_now)} | ${JawaCalendarUtils.formatJawa(_now)}',
              style: const TextStyle(fontSize: 12),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            Text(
              'Jam: ${_twoDigits(_now.hour)}:${_twoDigits(_now.minute)}:${_twoDigits(_now.second)} | Neptu: ${JawaCalendarUtils.neptuTotal(_now)}',
              style: const TextStyle(fontSize: 12),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const LoginPage()),
            ),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
        itemCount: menus.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, i) {
          return InkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => menus[i]['p']),
            ),
            child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 14,
                  horizontal: 16,
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: menus[i]['c'].withOpacity(0.16),
                      child: Icon(menus[i]['i'], color: menus[i]['c']),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        menus[i]['t'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const Icon(Icons.arrow_forward_ios, size: 16),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
