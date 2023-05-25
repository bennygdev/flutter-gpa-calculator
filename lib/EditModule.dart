import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

import './GPACalculator.dart';

// Edit module form page, where when the user clicks on the edit icon of the modules
// displayed on the home page, home page will route the user to this edit page to edit
// this module.
class EditModuleFormPage extends StatefulWidget {
  final Module module;
  final Function(Module, String, double, int?) updateModule;

  EditModuleFormPage(this.module, this.updateModule);

  @override
  _EditModuleFormPageState createState() => _EditModuleFormPageState();
}

class _EditModuleFormPageState extends State<EditModuleFormPage> {
  // Declare and Initialise variables from class
  String? moduleName;
  double? moduleGrade;
  int? creditUnit;
  String? creditUnitError;
  String? moduleNameError;
  late TextEditingController creditUnitController;
  late TextEditingController _moduleNameController;

  @override
  void initState() {
    super.initState();
    moduleName = widget.module.name;
    moduleGrade = widget.module.grade;
    creditUnit = widget.module.creditUnit;
    creditUnitError = null;
    moduleNameError = null;
    creditUnitController = TextEditingController(text: creditUnit != null ? creditUnit.toString() : '');
    _moduleNameController = TextEditingController(text: widget.module.name);
  }

  // Message for error message when form is incomplete or valid
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
        title: Text('Edit Module'),
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
                'Edit $moduleName module', // Module name display
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
                  errorText: moduleNameError, // show error message when encountered an error
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
                onChanged: (value) {
                  setState(() {
                    moduleName = value; // update value of moduleName variable
                  });
                },
                controller: _moduleNameController,
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
                    moduleGrade = value; // update value of modulegrade
                  });
                },
                items: [
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
                  contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                  errorText: creditUnitError, // show error message when form encounters an error
                ),
                style: TextStyle(
                  fontFamily: 'RubikRegular',
                  fontSize: 18,
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    creditUnit = int.tryParse(value); // update value of creditunit and convert float value to integer
                  });
                },
                controller: creditUnitController,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  validateForm(); // call the validateform function and if there are errors then show error message

                  // stops app from editing module if errors are present
                  if (moduleName!.isNotEmpty && moduleGrade != null && creditUnit != null && creditUnit! > 0) {
                    widget.updateModule(widget.module, moduleName!, moduleGrade!, creditUnit!);
                    Navigator.pop(context, true);
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
                child: Text('Save'),
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
                  image: AssetImage('images/studentgraphic2.png'),
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