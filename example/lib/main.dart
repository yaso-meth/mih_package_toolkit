import 'package:flutter/material.dart';
import 'package:mih_package_toolkit/mih_package_toolkit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Flutter Demo', home: const ExampleMihPackage());
  }
}

class ExampleMihPackage extends StatefulWidget {
  const ExampleMihPackage({super.key});

  @override
  State<ExampleMihPackage> createState() => _ExampleMihPackageState();
}

class _ExampleMihPackageState extends State<ExampleMihPackage> {
  @override
  Widget build(BuildContext context) {
    return MihPackage(
      backgroundColor: MihColors.primary(),
      packageActionButton: actionButton(),
      packageTools: tools(),
      packageToolBodies: toolBodies(),
      packageToolTitles: appToolTitles(),
      selectedBodyIndex: selectedbodyIndex,
      onIndexChange: (newIndex) {
        setState(() {
          selectedbodyIndex = newIndex;
        });
      },
    );
  }

  int selectedbodyIndex = 0; // Important for state management of the body

  Widget actionButton() {
    return MihPackageAction(
      iconColor: MihColors.secondary(),
      icon: Icon(Icons.arrow_back),
      iconSize: 35,
      onTap: () {
        Navigator.pop(context);
      },
    );
  }

  List<String> appToolTitles() {
    List<String> toolTitles = ["Tool 1", "Tool 2"];
    return toolTitles;
  }

  MihPackageTools tools() {
    Map<Widget, void Function()?> toolList = {};
    toolList[const Icon(Icons.calculate)] = () {
      setState(() {
        selectedbodyIndex = 0;
      });
    };
    toolList[const Icon(Icons.money)] = () {
      setState(() {
        selectedbodyIndex = 1;
      });
    };
    return MihPackageTools(
      tools: toolList,
      toolColor: MihColors.secondary(),
      onSelectedIconColor: MihColors.primary(),
      selectedIndex: selectedbodyIndex,
    );
  }

  List<Widget> toolBodies() {
    return [
      MihPackageToolBody(
        backgroundColor: MihColors.primary(),
        bodyItem: Center(
          child: Text(
            "Tool Body One",
            style: TextStyle(
              color: MihColors.secondary(),
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      MihPackageToolBody(
        backgroundColor: MihColors.secondary(),
        bodyItem: Center(
          child: Text(
            "Tool Body Two",
            style: TextStyle(
              color: MihColors.primary(),
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    ];
  }
}
