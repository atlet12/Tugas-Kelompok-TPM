import 'package:flutter/material.dart';
import '../utils/hijri_calendar_utils.dart';

class KonversiHijriahPage extends StatefulWidget {
  const KonversiHijriahPage({super.key});

  @override
  State<KonversiHijriahPage> createState() => _KonversiHijriahPageState();
}

class _KonversiHijriahPageState extends State<KonversiHijriahPage> {
  DateTime _selectedDate = DateTime.now();

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Konversi Masehi ke Hijriah')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Tanggal Masehi',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      HijriCalendarUtils.formatMasehi(_selectedDate),
                      style: const TextStyle(fontSize: 18),
                    ),
                    const Divider(height: 24),
                    const Text(
                      'Hasil Konversi Hijriah',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      HijriCalendarUtils.formatHijri(_selectedDate),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: _pickDate,
              icon: const Icon(Icons.calendar_month),
              label: const Text('Input Tanggal Masehi'),
            ),
            const SizedBox(height: 10),
            OutlinedButton.icon(
              onPressed: () {
                setState(() {
                  _selectedDate = DateTime.now();
                });
              },
              icon: const Icon(Icons.today),
              label: const Text('Gunakan Tanggal Sekarang'),
            ),
          ],
        ),
      ),
    );
  }
}
