import 'package:flutter/material.dart';

class ConverterScreen extends StatefulWidget {
  @override
  _ConverterScreenState createState() => _ConverterScreenState();
}

class _ConverterScreenState extends State<ConverterScreen> {
  String _selectedConversion = 'F to C';
  TextEditingController _controller = TextEditingController();
  String _result = '';
  List<String> _history = [];

  void _convert() {
    double input = double.tryParse(_controller.text) ?? 0.0;
    double convertedValue;
    if (_selectedConversion == 'F to C') {
      convertedValue = (input - 32) * 5 / 9;
    } else {
      convertedValue = input * 9 / 5 + 32;
    }
    setState(() {
      _result = convertedValue.toStringAsFixed(2);
      _history.insert(0, '$_selectedConversion: $input => $_result');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Temperature Converter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButton<String>(
              value: _selectedConversion,
              items: <String>['F to C', 'C to F']
                  .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedConversion = newValue!;
                });
              },
            ),
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter temperature',
              ),
            ),
            ElevatedButton(
              onPressed: _convert,
              child: Text('Convert'),
            ),
            SizedBox(height: 20),
            Text(
              'Result: $_result',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _history.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_history[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
