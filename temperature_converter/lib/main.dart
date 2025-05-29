import 'package:flutter/material.dart';

// Entry point of the app
void main() {
  runApp(const TemperatureConverterApp());
}

// The main app widget
class TemperatureConverterApp extends StatelessWidget {
  const TemperatureConverterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Converter',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const ConverterPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// The home page of the app
class ConverterPage extends StatefulWidget {
  const ConverterPage({super.key});

  @override
  State<ConverterPage> createState() => _ConverterPageState();
}

// Enum to represent the conversion type
enum ConversionType { fahrenheitToCelsius, celsiusToFahrenheit }

class _ConverterPageState extends State<ConverterPage> {
  // Controller for the input text field
  final TextEditingController inputController = TextEditingController();

  // Stores the selected conversion type
  ConversionType selectedConversion = ConversionType.fahrenheitToCelsius;

  // Stores the converted value as a string
  String convertedValue = '';

  // Stores the history of conversions
  final List<String> conversionHistory = [];

  // Function to perform the temperature conversion
  void convertTemperature() {
    // Try to parse the input as a double
    final input = double.tryParse(inputController.text);
    if (input == null) {
      setState(() {
        convertedValue = '';
      });
      return;
    }

    double result;
    String historyEntry;

    // Perform the conversion based on the selected type
    if (selectedConversion == ConversionType.fahrenheitToCelsius) {
      result = (input - 32) * 5 / 9;
      convertedValue = result.toStringAsFixed(1);
      historyEntry = 'F to C: ${input.toStringAsFixed(1)} ⇒ $convertedValue';
    } else {
      result = input * 9 / 5 + 32;
      convertedValue = result.toStringAsFixed(1);
      historyEntry = 'C to F: ${input.toStringAsFixed(1)} ⇒ $convertedValue';
    }

    // Update the history and UI
    setState(() {
      conversionHistory.insert(0, historyEntry);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Converter'),
        backgroundColor: Colors.blue[700],
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            bool isWide = constraints.maxWidth > 600;

            Widget conversionSelector = Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Conversion:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                const SizedBox(height: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Radio<ConversionType>(
                      visualDensity: VisualDensity.compact,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      value: ConversionType.fahrenheitToCelsius,
                      groupValue: selectedConversion,
                      onChanged: (value) {
                        setState(() {
                          selectedConversion = value!;
                          convertedValue = '';
                        });
                      },
                    ),
                    const Text(
                      'Fahrenheit to Celsius',
                      style: TextStyle(fontSize: 13),
                    ),
                    Radio<ConversionType>(
                      visualDensity: VisualDensity.compact,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      value: ConversionType.celsiusToFahrenheit,
                      groupValue: selectedConversion,
                      onChanged: (value) {
                        setState(() {
                          selectedConversion = value!;
                          convertedValue = '';
                        });
                      },
                    ),
                    const Text(
                      'Celsius to Fahrenheit',
                      style: TextStyle(fontSize: 13),
                    ),
                  ],
                ),
              ],
            );

            Widget inputOutputRowPortrait = Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 100,
                  height: 36,
                  child: TextField(
                    controller: inputController,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(vertical: 8),
                    ),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  '=',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 12),
                SizedBox(
                  width: 100,
                  height: 36,
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      convertedValue,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            );

            Widget inputOutputRowLandscape = Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: SizedBox(
                    height: 36,
                    child: TextField(
                      controller: inputController,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(vertical: 8),
                      ),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  '=',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: SizedBox(
                    height: 36,
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Text(
                        convertedValue,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );

            Widget convertButton = Center(
              child: SizedBox(
                width: 180,
                height: 36,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    side: const BorderSide(color: Colors.black),
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  onPressed: convertTemperature,
                  child: const Text('CONVERT'),
                ),
              ),
            );

            Widget historyListPortrait = Expanded(
              child: Container(
                margin: const EdgeInsets.only(top: 10),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1),
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.white,
                ),
                child: ListView(
                  children:
                      conversionHistory
                          .map(
                            (entry) => Text(
                              entry,
                              style: const TextStyle(fontSize: 13),
                            ),
                          )
                          .toList(),
                ),
              ),
            );

            Widget historyListLandscape = Expanded(
              child: Container(
                margin: const EdgeInsets.only(top: 10),
                padding: const EdgeInsets.all(8),
                alignment: Alignment.topLeft,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1),
                  color: Colors.white,
                ),
                child: ListView(
                  children:
                      conversionHistory
                          .map(
                            (entry) => Text(
                              entry,
                              style: const TextStyle(fontSize: 13),
                            ),
                          )
                          .toList(),
                ),
              ),
            );

            if (isWide) {
              // Landscape: input/output, button, and history in a row
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    conversionSelector,
                    const SizedBox(height: 10),
                    Expanded(
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            inputOutputRowLandscape,
                            const SizedBox(height: 10),
                            convertButton,
                            historyListLandscape,
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              // Portrait: everything in a column
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    conversionSelector,
                    const SizedBox(height: 10),
                    inputOutputRowPortrait,
                    const SizedBox(height: 10),
                    convertButton,
                    historyListPortrait,
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
