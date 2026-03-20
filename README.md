# mih_package_toolkit

A comprehensive UI toolkit and utility library specifically designed to help developers build **MIH Packages** for the MIH Project ecosystem. 

This toolkit provides a curated set of widgets, forms, and design utilities-ranging from custom buttons and input fields to complex layout components like floating menus and package windows.

## Features

This toolkit provides everything you need to maintain visual and functional consistency within the MIH ecosystem:

* **Form Elements**: Includes `MihButton`, `MihForm`, `MihTextFormField`, `MihDateField`, `MihTimeField`, and `MihDropdownField`, `MihSearchBar`,  for streamlined data entry.
* **Navigation & Layout**: Complex structural components like `MihPackage`, `MihPackageTitle`, `MihPackageAction`, `MihPackageTools`,  `MihPackageToolBody`, `MihPackageWindow`, `MihSingleChildScroll`, and `MihFloatingMenu`, .
* **Feedback & Progress**: Pre-styled `MihSnackBar` and `MihLoadingCircle` for user interaction.
* **Design Tokens**: Built-in access to `MihColors` and `MihIcons` to ensure brand compliance.
* **Specialized Controls**: Widgets like `MihNumericStepper`, `MihRadioOptions`, and `MihToggle`.

## Demo

<img src='assets/mih_package_toolkit_demo.gif' height='300' alt='MIH Package Demo'>

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
```

---

## Android Setup & Troubleshooting

This package relies on **`local_auth`** and **`app_settings`**. Due to recent updates in these plugins, your Android project must meet specific SDK and NDK version requirements.

### 1. Official Plugin Documentation
If you encounter platform-specific issues (such as biometric permission errors), please refer to the official setup guides:

*   [**local_auth (Android Integration)**](https://pub.dev/packages/local_auth#android-integration) — *Note: Requires `FlutterFragmentActivity` in your MainActivity.*
*   [**app_settings (Documentation)**](https://pub.dev/packages/app_settings) — *Note: Required for opening system settings natively.*

### 2. Required Build Configuration
Update your `android/app/build.gradle.kts` (or `build.gradle`) to match the versions required by these plugins:

```kotlin
android {
    // Required by the latest app_settings
    compileSdk = 36 

    // Required by local_auth & app_settings native dependencies
    ndkVersion = "27.0.12077973"

    defaultConfig {
        // local_auth requires a minimum of SDK 21
        minSdk = 21
        ...
    }
}
```

## Additional information

For more details about MIH Package Toolkit, including usage instructions and updates, please visit the [MIH Gitea repository](https://git.mzansi-innovation-hub.co.za/yaso_meth/mih_package_toolkit).

### Contributing
Contributions are welcome! If you'd like to improve the package, please fork the repository, make your changes, and submit a pull request. For major changes, please open an issue first to discuss what you would like to change.

### Reporting Issues/ Feature Requests 
If you encounter any bugs or have feature requests, please log an issue on the [MIH Gitea Issues page](https://git.mzansi-innovation-hub.co.za/yaso_meth/mih_package_toolkit/issues). Provide as much detail as possible to help us address the problem promptly.

### Support and Response 
We strive to respond to issues and pull requests in a timely manner. While this package is maintained voluntarily, we appreciate your patience and community involvement.

If you would like to support the MIH development team directly, please feel free to contribute to the [MIH Project via DonaHub](https://donahub.co.za/campaigns/mih-project)

Thank you for using the MIH Package Toolkit!
