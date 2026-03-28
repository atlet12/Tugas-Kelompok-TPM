import 'package:flutter/material.dart';

class OperasiAngka extends StatefulWidget {
  const OperasiAngka({super.key});

  @override
  State<OperasiAngka> createState() => _OperasiAngkaState();
}

class _OperasiAngkaState extends State<OperasiAngka> {
  List<TextEditingController> controllers = [
    TextEditingController(),
    TextEditingController(),
  ];

  double hasil = 0;

  void tambahField() {
    setState(() {
      controllers.add(TextEditingController());
    });
  }

  void hitungTambah() {
    double total = 0;

    for (var c in controllers) {
      total += double.tryParse(c.text) ?? 0;
    }

    setState(() {
      hasil = total;
    });
  }

  void hitungKurang() {
    if (controllers.isEmpty) return;

    double total = double.tryParse(controllers[0].text) ?? 0;

    for (int i = 1; i < controllers.length; i++) {
      total -= double.tryParse(controllers[i].text) ?? 0;
    }

    setState(() {
      hasil = total;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Penjumlahan Banyak Angka")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: controllers.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: TextField(
                      controller: controllers[index],
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Angka ${index + 1}",
                        border: const OutlineInputBorder(),
                      ),
                    ),
                  );
                },
              ),
            ),

            ElevatedButton(
              onPressed: tambahField,
              child: const Text("Tambah Angka"),
            ),

            const SizedBox(height: 15),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: hitungTambah,
                    child: const Text("Tambah"),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: hitungKurang,
                    child: const Text("Kurang"),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            Text(
              "Hasil: $hasil",
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),
          ],
        ),
      ),
    );
  }
}