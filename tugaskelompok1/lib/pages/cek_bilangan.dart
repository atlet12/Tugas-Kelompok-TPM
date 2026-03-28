import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter/services.dart';

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

  /// Ambil hanya angka dari teks
  String onlyDigits(String text) {
    return text.replaceAll(RegExp(r'[^0-9]'), '');
  }

  void cek() {
    String cleaned = onlyDigits(input.text);

    if (cleaned.isEmpty) {
      setState(() {
        hasil = "Masukkan angka yang valid.";
      });
      return;
    }

    // Update isi input agar huruf langsung hilang
    input.text = cleaned;
    input.selection = TextSelection.fromPosition(
      TextPosition(offset: input.text.length),
    );

    int val = int.tryParse(cleaned) ?? 0;

    setState(() {
      String tipe = (val % 2 == 0) ? "Genap" : "Ganjil";
      String prima = isPrime(val) ? "Bilangan Prima" : "Bukan Prima";
      hasil = "$val adalah $tipe dan $prima";
    });
  }

  @override
  void dispose() {
    input.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Cek Ganjil/Genap & Prima")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: input,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9a-zA-Z\s]')),
              ],
              onChanged: (value) {
                String cleaned = onlyDigits(value);

                if (value != cleaned) {
                  input.value = TextEditingValue(
                    text: cleaned,
                    selection: TextSelection.collapsed(offset: cleaned.length),
                  );
                }
              },
              decoration: const InputDecoration(
                labelText: "Masukkan Angka",
                hintText: "Contoh: 18 February 2025",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: cek,
              child: const Text("Cek Sekarang"),
            ),
            const SizedBox(height: 30),
            Text(
              hasil,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}