import 'package:flutter/material.dart';
import '../utils/jawa_calendar_utils.dart';

class WetonLahirPage extends StatefulWidget {
  const WetonLahirPage({super.key});

  @override
  State<WetonLahirPage> createState() => _WetonLahirPageState();
}

class _WetonLahirPageState extends State<WetonLahirPage> {
  DateTime? _birthDateTime;

  String _twoDigits(int value) => value.toString().padLeft(2, '0');

  Future<void> _pickBirthDateTime() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _birthDateTime ?? DateTime(2000, 1, 1),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate == null || !mounted) return;

    final initialTime =
        _birthDateTime != null
            ? TimeOfDay(
              hour: _birthDateTime!.hour,
              minute: _birthDateTime!.minute,
            )
            : const TimeOfDay(hour: 0, minute: 0);

    final pickedTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
      helpText: 'Pilih Jam & Menit Lahir',
    );

    if (pickedTime == null || !mounted) return;

    final initialSecond = _birthDateTime?.second ?? 0;
    final pickedSecond = await showDialog<int>(
      context: context,
      builder: (dialogContext) {
        int selectedSecond = initialSecond;
        return AlertDialog(
          title: const Text('Pilih Detik Lahir'),
          content: StatefulBuilder(
            builder: (context, setDialogState) {
              return DropdownButton<int>(
                value: selectedSecond,
                isExpanded: true,
                items: List.generate(60, (i) {
                  return DropdownMenuItem<int>(
                    value: i,
                    child: Text(_twoDigits(i)),
                  );
                }),
                onChanged: (value) {
                  if (value == null) return;
                  setDialogState(() {
                    selectedSecond = value;
                  });
                },
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Batal'),
            ),
            FilledButton(
              onPressed: () => Navigator.of(dialogContext).pop(selectedSecond),
              child: const Text('Pilih'),
            ),
          ],
        );
      },
    );

    if (pickedSecond == null) return;

    setState(() {
      _birthDateTime = DateTime(
        pickedDate.year,
        pickedDate.month,
        pickedDate.day,
        pickedTime.hour,
        pickedTime.minute,
        pickedSecond,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Weton Lahir')),
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
                      'Input Tanggal dan Waktu Lahir',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    FilledButton.icon(
                      onPressed: _pickBirthDateTime,
                      icon: const Icon(Icons.cake),
                      label: const Text('Pilih Tanggal & Waktu Lahir'),
                    ),
                    const SizedBox(height: 10),
                    if (_birthDateTime == null)
                      const Text('Belum memilih tanggal dan waktu lahir')
                    else ...[
                      Text(
                        'Tanggal Lahir: ${JawaCalendarUtils.formatMasehi(_birthDateTime!)}',
                      ),
                      Text(
                        'Waktu Lahir: ${_twoDigits(_birthDateTime!.hour)}:${_twoDigits(_birthDateTime!.minute)}:${_twoDigits(_birthDateTime!.second)}',
                      ),
                      const SizedBox(height: 8),
                      Text('Weton: ${JawaCalendarUtils.formatJawa(_birthDateTime!)}'),
                      Text(
                        'Neptu Weton: ${JawaCalendarUtils.neptuTotal(_birthDateTime!)}',
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
