import 'package:flutter/material.dart';
import 'login_page.dart';
import 'data_kelompok.dart';
import 'operasi_angka.dart';
import 'cek_bilangan.dart';
import 'total_angka.dart';
import 'stopwatch_page.dart';
import 'hitung_piramid.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> menus = [
      {'t': 'Data Kelompok', 'i': Icons.people, 'c': Colors.orange, 'p': const DataKelompok()},
      {'t': 'Hitung Angka', 'i': Icons.add_box, 'c': Colors.green, 'p': const OperasiAngka()},
      {'t': 'Cek Bilangan', 'i': Icons.numbers, 'c': Colors.blue, 'p': const CekBilangan()},
      {'t': 'Total', 'i': Icons.summarize, 'c': Colors.purple, 'p': const TotalAngka()},
      {'t': 'Stopwatch', 'i': Icons.timer, 'c': Colors.red, 'p': const StopwatchPage()},
      {'t': 'Hitung Piramid', 'i': Icons.architecture, 'c': Colors.teal, 'p': const HitungPiramid()},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Main Menu"),
        actions: [
          IconButton(onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage())), icon: const Icon(Icons.logout))
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(15),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 15, mainAxisSpacing: 15),
        itemCount: menus.length,
        itemBuilder: (context, i) {
          return InkWell(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => menus[i]['p'])),
            child: Card(
              elevation: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(menus[i]['i'], size: 45, color: menus[i]['c']),
                  const SizedBox(height: 10),
                  Text(menus[i]['t'], style: const TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}