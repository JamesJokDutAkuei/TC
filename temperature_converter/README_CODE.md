# Code Explanation: Temperature Converter App

This document explains the code in `lib/main.dart` for the Temperature Converter Flutter app. It is written for beginners, with simple explanations for each part of the code.

---

## 1. Importing Flutter Package
```dart
import 'package:flutter/material.dart';
```
This line imports the Flutter Material package, which provides all the basic widgets and tools for building a Flutter app.

---

## 2. Main Function
```dart
void main() {
  runApp(const TemperatureConverterApp());
}
```
This is the entry point of the app. It runs the `TemperatureConverterApp` widget, which starts the app.

---

## 3. TemperatureConverterApp Widget
```dart
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
```
This is the root widget of the app. It sets up the app's title, theme, and the home page (`ConverterPage`).

- `MaterialApp` is a widget that wraps your whole app and provides navigation, theming, etc.
- `debugShowCheckedModeBanner: false` removes the debug banner in the corner.

---

## 4. Enum for Conversion Type
```dart
enum ConversionType { fahrenheitToCelsius, celsiusToFahrenheit }
```
This defines two possible conversion types: Fahrenheit to Celsius and Celsius to Fahrenheit. Enums are a way to define a set of named values.

---

## 5. ConverterPage Widget
```dart
class ConverterPage extends StatefulWidget {
  const ConverterPage({super.key});

  @override
  State<ConverterPage> createState() => _ConverterPageState();
}
```
This is the main page of the app. It is a `StatefulWidget` because it needs to update when the user interacts with it (e.g., enters a value, changes conversion type, or presses the button).

---

## 6. _ConverterPageState Class
This class holds all the logic and UI for the converter page.

### Variables:
- `inputController`: Controls the text input for the temperature.
- `selectedConversion`: Stores which conversion type is selected.
- `convertedValue`: Stores the result of the conversion.
- `conversionHistory`: A list of previous conversions.

### Conversion Function:
```dart
void convertTemperature() {
  final input = double.tryParse(inputController.text);
  if (input == null) {
    setState(() {
      convertedValue = '';
    });
    return;
  }
  double result;
  String historyEntry;
  if (selectedConversion == ConversionType.fahrenheitToCelsius) {
    result = (input - 32) * 5 / 9;
    convertedValue = result.toStringAsFixed(1);
    historyEntry = 'F to C: ${input.toStringAsFixed(1)} ⇒ $convertedValue';
  } else {
    result = input * 9 / 5 + 32;
    convertedValue = result.toStringAsFixed(1);
    historyEntry = 'C to F: ${input.toStringAsFixed(1)} ⇒ $convertedValue';
  }
  setState(() {
    conversionHistory.insert(0, historyEntry);
  });
}
```
- This function reads the input, checks if it's a number, does the conversion, and updates the result and history.
- `setState` tells Flutter to update the UI with the new values.

---

## 7. The build Method
This method describes how to display the UI.

### Scaffold
- `AppBar`: The blue bar at the top with the title "Converter".
- `SafeArea`: Makes sure content doesn't go under notches or system bars.
- `LayoutBuilder`: Lets the app change layout for portrait/landscape.

### Portrait Layout
- **Conversion Selector**: Shows the "Conversion:" label and two radio buttons for selecting the conversion type.
- **Input/Output Row**: Lets the user enter a value and see the result.
- **Convert Button**: Button to perform the conversion.
- **History Box**: Shows a list of previous conversions, most recent at the top.

### Landscape Layout
- The input, output, and history boxes expand to fill the available width.
- The button is centered below the input/output row.
- The history box is below the button and expands as needed.

---

## 8. Widget Explanations
- **TextField**: Lets the user type in a temperature.
- **Radio**: Lets the user pick which conversion to do.
- **OutlinedButton**: The "CONVERT" button.
- **Container**: Used for the output field and history box, with a border for a clean look.
- **ListView**: Shows the history of conversions as a scrollable list.

---

## 9. setState
Whenever the user interacts (changes input, conversion type, or presses the button), `setState` is called to update the UI.

---

## 10. Summary
- The app is structured to be easy to read and modify.
- Each widget and function is used for a clear purpose.
- The UI is responsive and works in both portrait and landscape.

If you are new to Flutter, try changing some text, colors, or layout to see how it works! 