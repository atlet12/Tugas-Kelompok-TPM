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
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Main Menu"),
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
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.fromLTRB(15, 15, 15, 8),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Kalender Hari Ini',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Jam: ${_twoDigits(_now.hour)}:${_twoDigits(_now.minute)}:${_twoDigits(_now.second)}',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 4),
                  Text(JawaCalendarUtils.formatMasehi(_now)),
                  Text('Jawa: ${JawaCalendarUtils.formatJawa(_now)}'),
                  Text('Neptu: ${JawaCalendarUtils.neptuTotal(_now)}'),
                ],
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.fromLTRB(15, 8, 15, 15),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
              ),
              itemCount: menus.length,
              itemBuilder: (context, i) {
                return InkWell(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => menus[i]['p']),
                  ),
                  child: Card(
                    elevation: 4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(menus[i]['i'], size: 45, color: menus[i]['c']),
                        const SizedBox(height: 10),
                        Text(
                          menus[i]['t'],
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
