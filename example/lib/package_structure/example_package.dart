import 'package:example/package_structure/package_tools/tool_body_one.dart';
import 'package:example/package_structure/package_tools/tool_body_two.dart';
import 'package:flutter/material.dart';
import 'package:mih_package_toolkit/mih_package_toolkit.dart';

class ExamplePackage extends StatefulWidget {
  const ExamplePackage({super.key});

  @override
  State<ExamplePackage> createState() => _ExamplePackageState();
}

class _ExamplePackageState extends State<ExamplePackage> {
  int selectedbodyIndex = 0; // Important for state management of the body
  late final ToolBodyOne _toolBodyOne;
  late final ToolBodyTwo _toolBodyTwo;

  @override
  void initState() {
    _toolBodyOne = ToolBodyOne();
    _toolBodyTwo = ToolBodyTwo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MihPackage(
      backgroundColor: MihColors.primary(),
      titleColor: MihColors.secondary(),
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
    Map<Widget, void Function()?> temp = {};
    temp[const Icon(Icons.calculate)] = () {
      setState(() {
        selectedbodyIndex = 0;
      });
    };
    temp[const Icon(Icons.money)] = () {
      setState(() {
        selectedbodyIndex = 1;
      });
    };
    return MihPackageTools(
      toolColor: MihColors.green(),
      onSelectedIconColor: MihColors.primary(),
      tools: temp,
      selectedIndex: selectedbodyIndex,
    );
  }

  List<Widget> toolBodies() {
    return [_toolBodyOne, _toolBodyTwo];
  }
}
