import 'package:flutter/material.dart';
import 'dart:math';

class CekBilangan extends StatefulWidget {
  const CekBilangan({super.key});
  @override
  State<CekBilangan> createState() => _CekBilanganState();
}

class _CekBilanganState extends State<CekBilangan> {
  final input = TextEditingController();
  String hasil = "Hasil pengecekan";

  bool isPrime(int n) {
    if (n <= 1) return false;
    for (int i = 2; i <= sqrt(n); i++) {
      if (n % i == 0) return false;
    }
    return true;
  }

  void cek() {
    int val = int.tryParse(input.text) ?? 0;
    setState(() {
      String tipe = (val % 2 == 0) ? "Genap" : "Ganjil";
      String prima = isPrime(val) ? "Bilangan Prima" : "Bukan Prima";
      hasil = "$val adalah $tipe dan $prima";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Cek Ganjil/Genap & Prima")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(controller: input, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: "Masukkan Angka")),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: cek, child: const Text("Cek Sekarang")),
            const SizedBox(height: 30),
            Text(hasil, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }
}