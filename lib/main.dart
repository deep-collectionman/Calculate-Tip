import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _textEditingController = TextEditingController();
  final _percentages = {
    10 : true,
    15 : false,
    20 : false,
    50 : false,
    75 : false,
  };

  double? _result;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_result != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 32.0),
                  child: Text(
                    _result!.toStringAsFixed(2),
                    style: const TextStyle(
                      fontSize: 64.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              Visibility(
                visible: _result == null,
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 32.0),
                  child: Text(
                    'Please enter a value',
                    style: TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const Text('Total Amount'),
              SizedBox(
                width: 100,
                child: TextField(
                  controller: _textEditingController,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    hintText: '\$100.00',
                  ),
                  keyboardType: const TextInputType.numberWithOptions(
                    signed: false,
                    decimal: true,
                  ),
                ),
              ),
              const SizedBox(height: 16.0,),
              ToggleButtons(
                isSelected: _percentages.values.toList(),
                onPressed: _updatePercentage,
                children: _percentages.keys.map((percentage) => Text('${percentage.toString()}%')).toList(),
              ),
              const SizedBox(height: 16.0,),
              TextButton(
                onPressed: _calculateTip,
                child: Container(
                  height: 50,
                  width: 120,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Center(
                    child: Text(
                      'Calculate Tip',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _updatePercentage(int selectedIndex) {
    final keys = _percentages.keys.toList();
    final selectedKey = keys[selectedIndex];
    setState(() {
      for (var key in keys) {
        _percentages[key] = key == selectedKey;
      }
    });
  }

  void _calculateTip() {
    if (_textEditingController.text.isNotEmpty) {
      final totalAmount = double.parse(_textEditingController.text);
      final selectedIndex = _percentages.values.toList().indexWhere((element) => element);
      final percentage = _percentages.keys.toList()[selectedIndex] * 0.01;
      setState(() {
        _result = totalAmount * percentage;
      });
    }
  }
}

