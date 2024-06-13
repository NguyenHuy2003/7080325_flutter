import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class MyObject {
  int value;
  MyObject({
    required this.value,
  });
  // Phương thức tăng giá trị
  void increment() {
    value++;
  }

  // Phương thức giảm giá trị
  void decrement() {
    value--;
  }

  // Phương thức trả về giá trị hiện tại
  set values(int newValue) {
    this.value = newValue;
  }
}

class _MyAppState extends State<MyApp> {
  MyObject? _myObject;
  String? title;

  Widget _buildText() {
    return Text(
      'Giá trị: ${_myObject?.value}',
      style: const TextStyle(fontSize: 20),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: const Icon(Icons.person),
          title: Text(title ?? 'Debugging App'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildText(),
              OutlinedButton(
                onPressed: () {
                  _myObject?.value++;
                  setState(() {});
                },
                child: const Text('Tính toán'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
