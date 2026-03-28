import 'package:flutter/material.dart';
import '../utils/jawa_calendar_utils.dart';

class KalenderJawaPage extends StatefulWidget {
  const KalenderJawaPage({super.key});

  @override
  State<KalenderJawaPage> createState() => _KalenderJawaPageState();
}

class _KalenderJawaPageState extends State<KalenderJawaPage> {
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
      appBar: AppBar(title: const Text('Tanggal & Penanggalan Jawa')),
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
                      'Tanggal Terpilih (Masehi)',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      JawaCalendarUtils.formatMasehi(_selectedDate),
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Penanggalan Jawa',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      JawaCalendarUtils.formatJawa(_selectedDate),
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Neptu: ${JawaCalendarUtils.neptuTotal(_selectedDate)}',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: _pickDate,
              icon: const Icon(Icons.calendar_month),
              label: const Text('Ubah Tanggal Sesuai Keinginan'),
            ),
            const SizedBox(height: 10),
            OutlinedButton.icon(
              onPressed: () {
                setState(() {
                  _selectedDate = DateTime.now();
                });
              },
              icon: const Icon(Icons.today),
              label: const Text('Tanggal Sekarang'),
            ),
            const SizedBox(height: 10),
            OutlinedButton.icon(
              onPressed: () {
                setState(() {
                  _selectedDate = DateTime.now().add(const Duration(days: 1));
                });
              },
              icon: const Icon(Icons.navigate_next),
              label: const Text('Tanggal Berikutnya'),
            ),
          ],
        ),
      ),
    );
  }
}
