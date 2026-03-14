import 'package:flutter/material.dart';

class OperasiAngka extends StatefulWidget {
  const OperasiAngka({super.key});
  @override
  State<OperasiAngka> createState() => _OperasiAngkaState();
}

class _OperasiAngkaState extends State<OperasiAngka> {
  final n1 = TextEditingController();
  final n2 = TextEditingController();
  double hasil = 0;

  void hitung(bool isTambah) {
    double val1 = double.tryParse(n1.text) ?? 0;
    double val2 = double.tryParse(n2.text) ?? 0;
    setState(() => hasil = isTambah ? val1 + val2 : val1 - val2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Penjumlahan & Pengurangan")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(controller: n1, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: "Angka 1", border: OutlineInputBorder())),
            const SizedBox(height: 15),
            TextField(controller: n2, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: "Angka 2", border: OutlineInputBorder())),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(child: ElevatedButton(onPressed: () => hitung(true), child: const Text("Tambah"))),
                const SizedBox(width: 10),
                Expanded(child: ElevatedButton(onPressed: () => hitung(false), child: const Text("Kurang"))),
              ],
            ),
            const SizedBox(height: 40),
            Text("Hasil: $hasil", style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.indigo)),
          ],
        ),
      ),
    );
  }
}