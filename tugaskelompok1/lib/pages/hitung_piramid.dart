import 'package:flutter/material.dart';
import 'dart:math';

class HitungPiramid extends StatefulWidget {
  const HitungPiramid({super.key});
  @override
  State<HitungPiramid> createState() => _HitungPiramidState();
}

class _HitungPiramidState extends State<HitungPiramid> {
  final sController = TextEditingController();
  final tController = TextEditingController();
  double volume = 0, luas = 0;

  void hitung() {
    double s = double.tryParse(sController.text) ?? 0;
    double t = double.tryParse(tController.text) ?? 0;
    setState(() {
      volume = (1/3) * (s * s) * t;
      double tMiring = sqrt(pow(0.5 * s, 2) + pow(t, 2));
      luas = (s * s) + (4 * (0.5 * s * tMiring));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Kalkulator Piramid")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(controller: sController, decoration: const InputDecoration(labelText: "Sisi Alas", border: OutlineInputBorder())),
            const SizedBox(height: 10),
            TextField(controller: tController, decoration: const InputDecoration(labelText: "Tinggi", border: OutlineInputBorder())),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: hitung, child: const Text("Hitung Volume & Luas")),
            const SizedBox(height: 30),
            Text("Volume: ${volume.toStringAsFixed(2)}", style: const TextStyle(fontSize: 18)),
            Text("Luas Permukaan: ${luas.toStringAsFixed(2)}", style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}