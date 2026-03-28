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
import '../utils/jawa_calendar_utils.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  DateTime _now = DateTime.now();
  late final Timer _clockTimer;
  DateTime? _birthDate;

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

  Future<void> _pickBirthDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _birthDate ?? DateTime(2000, 1, 1),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate == null || !mounted) return;

    final initialTime =
        _birthDate != null
            ? TimeOfDay(hour: _birthDate!.hour, minute: _birthDate!.minute)
            : const TimeOfDay(hour: 0, minute: 0);

    final pickedTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
      helpText: 'Pilih Jam & Menit Lahir',
    );

    if (pickedTime == null || !mounted) return;

    final initialSecond = _birthDate?.second ?? 0;
    final pickedSecond = await showDialog<int>(
      context: context,
      builder: (dialogContext) {
        int selectedSecond = initialSecond;
        return AlertDialog(
          title: const Text('Pilih Detik Lahir'),
          content: StatefulBuilder(
            builder: (context, setDialogState) {
              return DropdownButton<int>(
                value: selectedSecond,
                isExpanded: true,
                items: List.generate(60, (i) {
                  return DropdownMenuItem<int>(
                    value: i,
                    child: Text(_twoDigits(i)),
                  );
                }),
                onChanged: (value) {
                  if (value == null) return;
                  setDialogState(() {
                    selectedSecond = value;
                  });
                },
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Batal'),
            ),
            FilledButton(
              onPressed:
                  () => Navigator.of(dialogContext).pop(selectedSecond),
              child: const Text('Pilih'),
            ),
          ],
        );
      },
    );

    if (pickedSecond == null) return;

    final result = DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
      pickedTime.hour,
      pickedTime.minute,
      pickedSecond,
    );

    setState(() {
      _birthDate = result;
    });
  }

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
                  const Divider(height: 20),
                  const Text(
                    'Tanggal Lahir & Weton',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  FilledButton.icon(
                    onPressed: _pickBirthDate,
                    icon: const Icon(Icons.cake),
                    label: const Text('Input Tanggal & Waktu Lahir'),
                  ),
                  const SizedBox(height: 6),
                  if (_birthDate == null)
                    const Text('Belum memilih tanggal lahir')
                  else ...[
                    Text(
                      'Tanggal Lahir: ${JawaCalendarUtils.formatMasehi(_birthDate!)}',
                    ),
                    Text(
                      'Waktu Lahir: ${_twoDigits(_birthDate!.hour)}:${_twoDigits(_birthDate!.minute)}:${_twoDigits(_birthDate!.second)}',
                    ),
                    Text('Weton: ${JawaCalendarUtils.formatJawa(_birthDate!)}'),
                    Text('Neptu Weton: ${JawaCalendarUtils.neptuTotal(_birthDate!)}'),
                  ],
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
