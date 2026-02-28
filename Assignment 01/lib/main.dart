import 'package:flutter/material.dart';

void main() {
  runApp(const VangtiChaiApp());
}

class VangtiChaiApp extends StatelessWidget {
  const VangtiChaiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'VangtiChai',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const VangtiChaiHome(),
    );
  }
}

class VangtiChaiHome extends StatefulWidget {
  const VangtiChaiHome({super.key});

  @override
  State<VangtiChaiHome> createState() => _VangtiChaiHomeState();
}

class _VangtiChaiHomeState extends State<VangtiChaiHome> {
  int amount = 0;

  final List<int> notes = [500, 100, 50, 20, 10, 5, 2, 1];

  void addDigit(int digit) {
    setState(() {
      amount = amount * 10 + digit;
    });
  }

  void clearAmount() {
    setState(() {
      amount = 0;
    });
  }

  Map<int, int> calculateChange() {
    int remaining = amount;
    Map<int, int> change = {};

    for (int note in notes) {
      int count = remaining ~/ note;
      if (count > 0) {
        change[note] = count;
        remaining %= note;
      }
    }
    return change;
  }

  Widget buildKeypadButton(String text, VoidCallback onTap) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 18),
          ),
          child: Text(
            text,
            style: const TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
  Widget buildKeypad() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            buildKeypadButton('1', () => addDigit(1)),
            buildKeypadButton('2', () => addDigit(2)),
            buildKeypadButton('3', () => addDigit(3)),
          ],
        ),
        Row(
          children: [
            buildKeypadButton('4', () => addDigit(4)),
            buildKeypadButton('5', () => addDigit(5)),
            buildKeypadButton('6', () => addDigit(6)),
          ],
        ),
        Row(
          children: [
            buildKeypadButton('7', () => addDigit(7)),
            buildKeypadButton('8', () => addDigit(8)),
            buildKeypadButton('9', () => addDigit(9)),
          ],
        ),
        Row(
          children: [
            buildKeypadButton('C', clearAmount),
            buildKeypadButton('0', () => addDigit(0)),
            const Spacer(),
          ],
        ),
      ],
    );
  }

  Widget buildChangeTable() {
    final change = calculateChange();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Change:',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: ListView(
            children: notes.map((note) {
              int count = change[note] ?? 0;
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Text(
                  '৳$note  :  $count',
                  style: const TextStyle(fontSize: 16),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('VangtiChai'),
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isLandscape = constraints.maxWidth > constraints.maxHeight;

          return Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Row(
                  children: [
                    const Text(
                      'Taka:',
                      style: TextStyle(fontSize: 22),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      amount.toString(),
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: isLandscape
                      ? Row(
                    children: [
                      Expanded(child: buildChangeTable()),
                      const SizedBox(width: 12),
                      Expanded(
                        child: SingleChildScrollView(
                          child: buildKeypad(),
                        ),
                      ),

                    ],
                  )
                      : Column(
                    children: [
                      Expanded(child: buildChangeTable()),
                      const SizedBox(height: 12),
                      buildKeypad(),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
