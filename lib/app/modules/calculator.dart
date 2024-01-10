import 'package:flutter/material.dart';

class SimpleCalculator extends StatefulWidget {
  const SimpleCalculator({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => SimpleCalculatorState();
}

class SimpleCalculatorState extends State<SimpleCalculator> {
  TextEditingController variableA = TextEditingController();
  TextEditingController variableB = TextEditingController();
  String result = '0';

  void add() {
    setState(() {
      result =
          (int.parse(variableA.text) + int.parse(variableB.text)).toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Simple Calculator')),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              key: const Key('variableA'),
              style: const TextStyle(color: Colors.black),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              controller: variableA,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            TextField(
              key: const Key('variableB'),
              // add border
              style: const TextStyle(color: Colors.black),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              controller: variableB,
              keyboardType: TextInputType.number,
            ),
            ElevatedButton(
              key: const Key('addButton'),
              onPressed: () => add(),
              child: const Text('Add'),
            ),
            Text(
              key: const Key('result'),
              result,
              style: const TextStyle(fontSize: 35),
            ),
          ],
        ),
      ),
    );
  }
}
