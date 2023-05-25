import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import './GPACalculator.dart';
import './SplashPage.dart';

// Main function runs the app 'GPA Calculator App' which will run the whole GPA program
// that is housed.
void main() {
  runApp(GPACalculatorApp());
}

// It runs the app's splash page, where it is a introduction screen. The splash
// page connects with the GPA Calculator app.
class GPACalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GPA Calculator',
      home: SplashPage(),
    );
  }
}