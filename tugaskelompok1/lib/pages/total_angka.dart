import 'package:flutter/material.dart';

class TotalAngka extends StatefulWidget {
  const TotalAngka({super.key});
  @override
  State<TotalAngka> createState() => _TotalAngkaState();
}

class _TotalAngkaState extends State<TotalAngka> {
  final input = TextEditingController();
  int total = 0;

  void hitung() {
    int sum = 0;
    String text = input.text;
    for (int i = 0; i < text.length; i++) {
      sum += int.tryParse(text[i]) ?? 0;
    }
    setState(() => total = sum);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Total Digit Angka")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(controller: input, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: "Masukkan Deretan Angka")),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: hitung, child: const Text("Jumlahkan")),
            const SizedBox(height: 30),
            Text("Total: $total", style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}