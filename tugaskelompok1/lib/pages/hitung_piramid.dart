import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter/services.dart';

class HitungPiramid extends StatefulWidget {
  const HitungPiramid({super.key});

  @override
  State<HitungPiramid> createState() => _HitungPiramidState();
}

class _HitungPiramidState extends State<HitungPiramid> {
  final sController = TextEditingController();
  final tController = TextEditingController();

  double volume = 0, luas = 0;
  String errorMessage = '';

  void hitung() {
    double s = double.tryParse(sController.text) ?? 0;
    double t = double.tryParse(tController.text) ?? 0;

    // Validasi agar tidak boleh negatif
    if (s < 0 || t < 0) {
      setState(() {
        errorMessage = "Nilai sisi alas dan tinggi tidak boleh negatif.";
        volume = 0;
        luas = 0;
      });
      return;
    }

    // Validasi agar tidak kosong / nol jika mau lebih aman
    if (s == 0 || t == 0) {
      setState(() {
        errorMessage = "Masukkan nilai sisi alas dan tinggi yang valid.";
        volume = 0;
        luas = 0;
      });
      return;
    }

    setState(() {
      errorMessage = '';
      volume = (1 / 3) * (s * s) * t;
      double tMiring = sqrt(pow(0.5 * s, 2) + pow(t, 2));
      luas = (s * s) + (4 * (0.5 * s * tMiring));
    });
  }

  @override
  void dispose() {
    sController.dispose();
    tController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Kalkulator Piramid")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: sController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
              ],
              decoration: const InputDecoration(
                labelText: "Sisi Alas",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: tController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
              ],
              decoration: const InputDecoration(
                labelText: "Tinggi",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: hitung,
              child: const Text("Hitung Volume & Luas"),
            ),
            const SizedBox(height: 20),

            if (errorMessage.isNotEmpty)
              Text(
                errorMessage,
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),

            const SizedBox(height: 20),

            Text(
              "Volume: ${volume.toStringAsFixed(2)}",
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              "Luas Permukaan: ${luas.toStringAsFixed(2)}",
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}