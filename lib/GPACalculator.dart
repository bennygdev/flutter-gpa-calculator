import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

import './SplashPage.dart';
import './GuidePage.dart';
import './AddModule.dart';
import './EditModule.dart';


// Initialise name, grade, creditunit of modules
class Module {
  String? name;
  double? grade;
  int? creditUnit;

  Module(this.name, this.grade, this.creditUnit);
}

// Home page which shows modules, and CRUD functionalities.
// Home page appears after the user has done going through the introduction screen
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Module> modules = []; // List to store modules
  double gpa = 0.0; // double data type Variable to store GPA

  // Add module function, where module information is added to list.
  void addModule(Module module) {
    setState(() {
      modules.add(module);
      calculateGPA(); // Re-update total GPA
    });
  }

  // Delete module function, where a module can be deleted. Before the user initiates
  // deletion, an alertdialog widget is triggered to let the usr if they really want
  // to delete the module.
  void deleteModule(Module module) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          title: Text('Confirm Delete'),
          content: Text('Are you sure you want to delete this module?'),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // close alertdialog and nothing happens
              },
            ),
            TextButton(
              child: Text('Delete'),
              onPressed: () {
                setState(() {
                  modules.remove(module); // remove module
                  calculateGPA(); // updates the total GPA
                });
                Navigator.of(context).pop(); // close alertdialog
              },
            ),
          ],
        );
      },
    );
  }

  // Function to clear all modules. Triggered when 'clear all' button is tapped.
  // an alertdialog box will popup to confirm if the user really wants to delete all
  // modules. If so, it uses .clear to clear the module list.
  void clearAllModules() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          title: Text('Confirm Clear'),
          content: Text('Are you sure you want to clear all modules?'),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // close alertdialog and nothing happens
              },
            ),
            TextButton(
              child: Text('Clear'),
              onPressed: () {
                setState(() {
                  modules.clear(); // clear modules list
                  calculateGPA(); // update total gpa
                });
                Navigator.of(context).pop(); // close alertdialog window
              },
            ),
          ],
        );
      },
    );
  }

  // The user can edit a selected module. It takes the user to another page to edit
  // the module.
  void editModule(Module module) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditModuleFormPage(module, updateModule)),
    );

    if (result != null && result is bool && result) {
      calculateGPA(); // update total gpa
    }
  }

  // This function is triggered when the user is done editing the module. It updates
  // the module collection list
  void updateModule(Module module, String newName, double newGrade, int? newCreditUnit) {
    setState(() {
      module.name = newName;
      module.grade = newGrade;
      module.creditUnit = newCreditUnit;
    });
  }

  // This calculates the cumulative GPA from all modules, triggered when modules are
  // edited, deleted or cleared.
  void calculateGPA() {
    if (modules.isEmpty) {
      gpa = 0.0;
    } else {
      double totalGradePoints = 0.0;
      double totalCreditUnits = 0.0;

      for (var module in modules) {
        double gradeValue = module.grade!;

        // Modify the grade value for D from 1.1 to 1.0
        // This is because of conflicting values for menu dropdown list during
        // editing or adding a module, where when the GPA is finally calculated
        // it converts D grade of 1.1 to 1.0.
        if (gradeValue == 1.1) {
          gradeValue = 1.0;
        }

        // GPA formula; stores calculations in variable
        totalGradePoints += gradeValue * module.creditUnit!;
        totalCreditUnits += module.creditUnit!;
      }

      gpa = totalGradePoints / totalCreditUnits;
    }
  }

  // Aesthetic function, this will show the grade letter for a module depending on
  // the grade of the module.
  String getGradeLetter(double grade) {
    if (grade >= 4.0) {
      return 'A';
    } else if (grade >= 3.0) {
      return 'B';
    } else if (grade >= 2.0) {
      return 'C';
    } else if (grade >= 1.1) {
      return 'D';
    } else if (grade >= 1.0) {
      return 'E';
    } else {
      return 'F';
    }
  }

  // A color function where the total GPA text color will change according to the
  // total grade of the GPA.
  Color _getTextColor(double gpa) {
    if (gpa >= 4.0) {
      return Color(0xFF0099FF);
    } else if (gpa >= 3.0) {
      return Color(0xFFA0FFCD);
    } else if (gpa >= 2.0) {
      return Color(0xFFFFE6AB);
    } else {
      return Color(0xFFFFADAD);
    }
  }

  @override
  Widget build(BuildContext context) {
    int totalModules = modules.length;
    int totalCreditUnits = modules.fold<int>(0, (sum, module) => sum + (module.creditUnit ?? 0));

    return Scaffold(
      appBar: AppBar(
        title: Image.asset('images/logogreywhite.png', height: 30),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Color(0xFF7FCCFF),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(15),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Color(0xFFD8E9FF),
                  borderRadius: BorderRadius.all(Radius.circular(15.0))
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 15, 15, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Cumulative GPA:',
                              style: TextStyle(
                                fontSize: 22,
                                color: Color(0xFF707070),
                                fontFamily: 'RubikRegular',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            // Displays variable totalModules and totalCreditUnits variables
                            SizedBox(height: 10),
                            Text(
                              'Total Modules: $totalModules',
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xFF707070),
                                fontFamily: 'RubikRegular',
                              ),
                            ),
                            Text(
                              'Total Credit Units: $totalCreditUnits',
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xFF707070),
                                fontFamily: 'RubikRegular',
                              ),
                            ),
                          ],
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0xFFFFFFFF),
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          ),
                          height: 80,
                          width: 125,
                          child: Center(
                            child: Text(
                              '${gpa.toStringAsFixed(3)}', // show total gpa with decimal place of 3.
                              style: TextStyle(
                                fontSize: 35.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'RubikRegular',
                                color: _getTextColor(gpa), // Call a function to determine the text color
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15.0), // Additional space between the previous content and the new text
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // takes user to guide page
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => GuidePage())
                            );
                          },
                          child: Icon(
                            Icons.help_outline_rounded,
                            color: Color(0xFF707070),
                            size: 25,
                          ),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.all(3.0),
                            minimumSize: Size.zero,
                            elevation: 0.0,
                            backgroundColor: Color(0xFFFFFFFF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        Center(
                          child: SizedBox(
                            height: 30,
                            child: ElevatedButton(
                              onPressed: () async {
                                // takes user to add module page
                                final result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => AddModuleFormPage()),
                                );

                                if (result != null && result is Module) {
                                  addModule(result);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFFF090FF),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              child: Text(
                                'Add module',
                                style: TextStyle(
                                    fontFamily: 'RubikMedium'
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              'Added Modules',
              textDirection: TextDirection.ltr,
              style: TextStyle(
                color: Color(0xFF2C2C2C),
                fontFamily: 'RubikMedium',
                fontSize: 20,
              ),
            ),
            SizedBox(height: 10.0),
            // Condition check, if modules empty display a message
            Expanded( // show message if modules list is empty
              child: modules.isEmpty
                  ? Center(
                child: Text(
                  'No modules listed here.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                    fontFamily: 'RubikRegular',
                  ),
                ),
              )
                  : ListView.builder( // show added modules
                itemCount: modules.length,
                itemBuilder: (context, index) {
                  String gradeLetter = getGradeLetter(modules[index].grade!);

                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    ),
                    color: Colors.grey[200],
                    child: ListTile(
                      title: Text(
                        modules[index].name!,
                        style: TextStyle(
                          fontFamily: 'RubikMedium',
                        ),
                      ),
                      subtitle: Text(
                        // display gradeletter of module grade and credit unit of module
                        'Grade: $gradeLetter | Credit Units: ${modules[index].creditUnit}',
                        style: TextStyle(
                          fontFamily: 'RubikMedium',
                        ),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          editModule(modules[index]);
                        },
                      ),
                      onLongPress: () {
                        deleteModule(modules[index]);
                      },
                    ),
                  );
                },
              ),
            ),
            Center(
              child: SizedBox(
                width: 120,
                child: ElevatedButton(
                  onPressed: () {
                    clearAllModules(); // call function clearallmodules
                  },
                  child: Text('Clear All'),
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFFFF5C5C),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}