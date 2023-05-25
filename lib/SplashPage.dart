import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

import './GPACalculator.dart';

// Splash screen which acts as an introduction screen to user before proceeding
// onto the homepage, uses the introduction screen external package to make it
// possible
class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final _introKey = GlobalKey<IntroductionScreenState>();

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      key: _introKey,
      pages: [
        // PageViewModel used for seperate pages for introduction screen
        PageViewModel(
          title: '',
          bodyWidget: Column(
            children: [
              // Skip button to home page (Row widget)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      goToHome(context); // takes user to homepage
                    },
                    child: Text(
                      'SKIP',
                      style: TextStyle(
                        fontFamily: 'RubikMedium',
                        color: Color(0xFF707070),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFFF9F9F9),
                      elevation: 0.0,
                    ),
                  ),
                ],
              ),
              Image(
                image: AssetImage('images/SplashPageOne.png'),
                height: 250,
              ),
              SizedBox(height: 42),
              Image(
                image: AssetImage('images/logoblue.png'),
                height: 40,
              ),
              SizedBox(height: 16),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: TextStyle(
                    color: Color(0xFF3B3B3B),
                    fontFamily: 'RubikMedium',
                    fontSize: 20,
                  ),
                  children: [
                    TextSpan(text: 'Simplify the process of calculating your GPA with '),
                    TextSpan(
                      text: 'our intuitive and user friendly app',
                      style: TextStyle(color: Color(0xFFF1A900)),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5),
            ],
          ),
        ),
        PageViewModel(
          title: '',
          bodyWidget: Column(
            children: [
              // Skip button to home page (Row widget)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      goToHome(context); // takes user to homepage
                    },
                    child: Text(
                      'SKIP',
                      style: TextStyle(
                        fontFamily: 'RubikMedium',
                        color: Color(0xFF707070),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFFF9F9F9),
                      elevation: 0.0,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 50),
              Image(
                image: AssetImage('images/SplashPageTwo.png'),
                height: 225,
              ),
              SizedBox(height: 16),
              Image(
                image: AssetImage('images/logoblue.png'),
                height: 40,
              ),
              SizedBox(height: 16),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: TextStyle(
                    color: Color(0xFF3B3B3B),
                    fontFamily: 'RubikMedium',
                    fontSize: 20,
                  ),
                  children: [
                    TextSpan(text: 'Precisely evaluate your academic performance '),
                    TextSpan(
                      text: 'that provides insights on your grades',
                      style: TextStyle(color: Color(0xFFF1A900)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        PageViewModel(
          title: '',
          bodyWidget: Column(
            children: [
              SizedBox(height: 70),
              Image(
                image: AssetImage('images/TargetGraphic.png'),
                height: 260,
              ),
              SizedBox(height: 16),
              Image(
                image: AssetImage('images/logoblue.png'),
                height: 40,
              ),
              SizedBox(height: 16),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: TextStyle(
                    color: Color(0xFF3B3B3B),
                    fontFamily: 'RubikMedium',
                    fontSize: 20,
                  ),
                  children: [
                    TextSpan(text: 'Track your academic performance '),
                    TextSpan(
                      text: 'with total accuracy and speed',
                      style: TextStyle(color: Color(0xFFF1A900)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
      // introduction_screen settings
      showSkipButton: false,
      skip: const Text('Skip'),
      onSkip: () {
        Navigator.of(context).pop(); // takes user to homepage
      },
      showNextButton: true,
      next: const Icon(Icons.arrow_forward),
      done: const Text('Done'),
      onDone: () => goToHome(context), // takes user to homepage
      showBackButton: true,
      back: const Icon(Icons.arrow_back),
      dotsDecorator: getDotDecoration(),
    );
  }

  // Go to homepage function
  void goToHome(context) => Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => HomePage())
  );

  // Dots decorator
  DotsDecorator getDotDecoration() => DotsDecorator(
    color: Color(0xFFBDBDBD),
    activeColor: Color(0xFF2195F2),
    size: Size(10, 10),
    activeSize: Size(22, 10),
    activeShape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(24),
    ),
  );
}