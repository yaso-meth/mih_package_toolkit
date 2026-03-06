<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/tools/pub/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/to/develop-packages).
-->

# mih_package_toolkit

A comprehensive UI toolkit and utility library specifically designed to help developers build **MIH Packages** for the MIH app ecosystem. 

This toolkit provides a curated set of widgets, forms, and design utilities—ranging from custom buttons and input fields to complex layout components like floating menus and package windows.

---

## Features

This toolkit provides everything you need to maintain visual and functional consistency within the MIH ecosystem:

* **Form Elements**: Includes `MihForm`, `MihTextField`, `MihDateField`, and `MihDropdownField` for streamlined data entry.
* **Navigation & Layout**: Complex structural components like `MihFloatingMenu`, `MihPackageWindow`, and `MihPackageToolBody`.
* **Feedback & Progress**: Pre-styled `MihSnackBar` and `MihLoadingCircle` for user interaction.
* **Design Tokens**: Built-in access to `MihColors` and `MihIcons` to ensure brand compliance.
* **Specialized Controls**: Widgets like `MihNumericStepper`, `MihRadioOptions`, and `MihToggle`.

## Getting started

To use this library, Add the package to your `pubspec.yaml`:

```bash
flutter pub add mih_package_toolkit
```

and simply add the import to your Dart file:

```dart
import 'package:mih_package_toolkit/mih_package_toolkit.dart';
```

## Usage

```dart
import 'package:flutter/material.dart';
import 'package:mih_package_toolkit/mih_package_toolkit.dart';

class ExamplePackage extends StatefulWidget {
  const ExamplePackage({super.key});

  @override
  State<ExamplePackage> createState() => _ExamplePackageState();
}

class _ExamplePackageState extends State<ExamplePackage> {
  int selectedbodyIndex = 0; // Important for state management of the body

  @override
  Widget build(BuildContext context) {
    return MihPackage(
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
    return MihPackageTools(tools: temp, selectedIndex: selectedbodyIndex);
  }

  List<Widget> toolBodies() {
    return [
      MihPackageToolBody(
        backgroundColor: MihColors.primary(),
        bodyItem: Center(child: Text("Tool Body One")),
      ),
      MihPackageToolBody(
        backgroundColor: MihColors.secondary(),
        bodyItem: Center(child: Text("Tool Body Two")),
      ),
    ];
  }
}
```

## Additional information

For more details about MIH Package Toolkit, including usage instructions and updates, please visit the [MIH Gitea repository](https://git.mzansi-innovation-hub.co.za/yaso_meth/mih_package_toolkit).

### Contributing
Contributions are welcome! If you'd like to improve the package, please fork the repository, make your changes, and submit a pull request. For major changes, please open an issue first to discuss what you would like to change.

### Reporting Issues 
If you encounter any bugs or have feature requests, please file an issue on the [MIH Gitea Issues page](https://git.mzansi-innovation-hub.co.za/yaso_meth/mih_package_toolkit/issues). Provide as much detail as possible to help us address the problem promptly.

### Support and Response 
We strive to respond to issues and pull requests in a timely manner. While this package is maintained voluntarily, we appreciate your patience and community involvement.

Thank you for using the MIH Package Toolkit!