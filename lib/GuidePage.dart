import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import './GPACalculator.dart';

// Guide page which guides users how GPA is calculated and how the app works
// Uses the introduction screen external package to make this possible
class GuidePage extends StatefulWidget {
  @override
  _GuidePageState createState() => _GuidePageState();
}

class _GuidePageState extends State<GuidePage> {
  final _introKey = GlobalKey<IntroductionScreenState>();

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      key: _introKey,
      pages: [
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
                      Navigator.of(context).pop(); // takes user to homepage
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
                image: AssetImage('images/gradescaletable.png'),
                height: 350,
              ),
              SizedBox(height: 16),
              Text(
                'How to calculate GPA?',
                style: TextStyle(
                  fontFamily: 'RubikMedium',
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 5),
              Text(
                  'The Grade Point Average (GPA) represents your current '
                      'standing in the programme of study. It is calculated '
                      'by ratio of total grade points earned and total credits '
                      'earned to date.\n\nYour GPA is calculated by '
                      '(Module Credit Units Earned * Grade Scale / Credit Units)',
                style: TextStyle(
                  fontFamily: 'RubikRegular',
                ),
              ),
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
                      Navigator.of(context).pop(); // takes user to homepage
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
                image: AssetImage('images/createmodule.png'),
                height: 180,
              ),
              SizedBox(height: 16),
              Text(
                'Add a module',
                style: TextStyle(
                  fontFamily: 'RubikMedium',
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 5),
              Text(
                'To add a module, tap on the "Add module" button at the top '
                    'right. You will be taken to a form where you can key in '
                    'the module information and the module will be added once '
                    'done. The cumulative GPA will also be automatically updated.',
                style: TextStyle(
                  fontFamily: 'RubikRegular',
                ),
              ),
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
                      Navigator.of(context).pop(); // takes user to homepage
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
                image: AssetImage('images/moduleedit.png'),
                height: 350,
              ),
              SizedBox(height: 16),
              Text(
                'Edit a module',
                style: TextStyle(
                  fontFamily: 'RubikMedium',
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 5),
              Text(
                'To edit a module, tap on the edit icon on the added module. '
                    'You will be taken to a form where you can edit '
                    'the module information and the module will be edited once '
                    'done. The cumulative GPA will also be automatically updated.',
                style: TextStyle(
                  fontFamily: 'RubikRegular',
                ),
              ),
            ],
          ),
        ),
        PageViewModel(
          title: '',
          bodyWidget: Column(
            children: [
              Image(
                image: AssetImage('images/deleteandclear.png'),
                height: 350,
              ),
              SizedBox(height: 16),
              Text(
                'Delete & Clear Modules',
                style: TextStyle(
                  fontFamily: 'RubikMedium',
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 5),
              Text(
                'To delete a module, you can do a long press on the added module '
                    'to delete the module. It will delete the module once confirmed.\n\n'
                    'To clear the module, you can tap on the clear all button '
                    'to clear all modules added. The modules will be cleared '
                    'when you have tapped and confirmed clearing all the added '
                    'modules.'
                    'The cumulative GPA will also be automatically updated.',
                style: TextStyle(
                  fontFamily: 'RubikRegular',
                ),
              ),
            ],
          ),
        ),
      ],
      // Introduction_screen settings
      showSkipButton: false,
      skip: const Text('Skip'),
      onSkip: () {
        Navigator.of(context).pop(); // takes user to homepage
      },
      showNextButton: true,
      next: const Icon(Icons.arrow_forward),
      done: const Text('Done'),
      onDone: () {
        Navigator.of(context).pop(); // takes user to homepage
      },
      showBackButton: true,
      back: const Icon(Icons.arrow_back),
      dotsDecorator: getDotDecoration(),
    );
  }

  // Decorate dots for screen
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