import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

import './GPACalculator.dart';

// Add module form page, where this is triggered when the user tries to add a module.
// This is the page, where it was previously routed from the home page.
class AddModuleFormPage extends StatefulWidget {
  @override
  _AddModuleFormPageState createState() => _AddModuleFormPageState();
}

class _AddModuleFormPageState extends State<AddModuleFormPage> {
  // Declare and initialise variables from class
  String? moduleName;
  double? moduleGrade;
  int? creditUnit;
  String? creditUnitError;
  String? moduleNameError;

  @override
  void initState() {
    super.initState();
    moduleName = '';
    moduleGrade = 4.0;
    creditUnit = null;
    creditUnitError = null;
    moduleNameError = null;
  }

  // Error messages when form encounters issues
  void validateForm() {
    setState(() {
      creditUnitError = creditUnit == null || creditUnit! <= 0 ? 'Please enter a valid credit unit' : null;
      moduleNameError = moduleName!.isEmpty ? 'Please enter a module name' : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Module'),
        backgroundColor: Color(0xFF7FCCFF),
        elevation: 0.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(15),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add a module',
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'RubikMedium'
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Module name',
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'RubikMedium',
                ),
              ),
              SizedBox(height: 5),
              TextField(
                decoration: InputDecoration(
                  errorText: moduleNameError, // show error message when form encounters an issue
                  contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'RubikRegular',
                ),
                onChanged: (value) {
                  setState(() {
                    moduleName = value; // Update modulename string
                  });
                },
              ),
              SizedBox(height: 20),
              Text(
                'Grade',
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'RubikMedium',
                ),
              ),
              SizedBox(height: 5),
              DropdownButtonFormField<double>(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
                value: moduleGrade,
                onChanged: (value) {
                  setState(() {
                    moduleGrade = value; // update modulegrade variable
                  });
                },
                items: [ //dropdown menu for grades
                  DropdownMenuItem(
                    value: 4.0,
                    child: Text('A'),
                  ),
                  DropdownMenuItem(
                    value: 3.0,
                    child: Text('B'),
                  ),
                  DropdownMenuItem(
                    value: 2.0,
                    child: Text('C'),
                  ),
                  // Grade D is 1.1, because of conflicting values with grade E
                  // therefore both values can't be 1. The GPA for grade D is
                  // calculated at the calculateGPA function in GPACalculator.dart
                  DropdownMenuItem(
                    value: 1.1,
                    child: Text('D'),
                  ),
                  DropdownMenuItem(
                    value: 1.0,
                    child: Text('E'),
                  ),
                  DropdownMenuItem(
                    value: 0.0,
                    child: Text('F'),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                'Credit Units',
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'RubikMedium',
                ),
              ),
              SizedBox(height: 5),
              TextField(
                decoration: InputDecoration(
                  errorText: creditUnitError, // shows error message when form encounters an error
                  contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
                style: TextStyle(
                  fontFamily: 'RubikRegular',
                  fontSize: 18,
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    creditUnit = int.tryParse(value); // update creditunit variable and parse float to integer
                  });
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  validateForm(); // calls validateform function to check for errors if not show message

                  // stops app from adding module if errors are present
                  if (moduleName!.isNotEmpty && moduleGrade != null && creditUnit != null && creditUnit! > 0) {
                    Navigator.pop(context, Module(moduleName!, moduleGrade!, creditUnit!));
                  } else {
                    // showDialog(
                    //   context: context,
                    //   builder: (BuildContext context) {
                    //     return AlertDialog(
                    //       title: Text('Incomplete Form'),
                    //       content: Text('Please fill in all the fields with valid values.'),
                    //       actions: [
                    //         TextButton(
                    //           child: Text('OK'),
                    //           onPressed: () {
                    //             Navigator.of(context).pop();
                    //           },
                    //         ),
                    //       ],
                    //     );
                    //   },
                    // );
                  }
                },
                child: Text('Add Module'),
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFFF1A900),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: Image(
                  image: AssetImage('images/studentgraphic1.png'),
                  height: 200,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}