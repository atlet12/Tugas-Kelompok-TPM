import 'package:flutter/material.dart';
import 'dart:async';

class StopwatchPage extends StatefulWidget {
  const StopwatchPage({super.key});
  @override
  State<StopwatchPage> createState() => _StopwatchPageState();
}

class _StopwatchPageState extends State<StopwatchPage> {
  final Stopwatch _sw = Stopwatch();
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 30), (timer) {
      if (_sw.isRunning) setState(() {});
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Stopwatch")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_sw.elapsed.toString().substring(0, 10), style: const TextStyle(fontSize: 50, fontWeight: FontWeight.bold, fontFamily: 'monospace')),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(onPressed: () => setState(() => _sw.isRunning ? _sw.stop() : _sw.start()), child: Icon(_sw.isRunning ? Icons.pause : Icons.play_arrow)),
                const SizedBox(width: 20),
                FloatingActionButton(onPressed: () => setState(() => _sw.reset()), child: const Icon(Icons.refresh)),
              ],
            )
          ],
        ),
      ),
    );
  }
}