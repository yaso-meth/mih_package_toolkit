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

<img src='https://git.mzansi-innovation-hub.co.za/yaso_meth/mih_package_toolkit/raw/branch/main/assets/mih_package_toolkit_demo.gif' height='300' alt='MIH Package Demo'>

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

### Attributions
| Icon | Link |
| :--- | :--- |
| access | https://www.flaticon.com/free-icon/access-control_7426564?term=user+access&page=1&position=19&origin=search&related_id=7426564 |
| add business | https://www.flaticon.com/free-icon/business_13569850?term=company+add&page=1&position=25&origin=search&related_id=13569850 |
| add user | https://www.flaticon.com/free-icon/add-user_748137?term=add+user&page=1&position=1&origin=search&related_id=748137 |
| apple music | https://www.flaticon.com/free-icon/music_7566196?term=apple+music&related_id=7566196 |
| business | https://www.flaticon.com/free-icon/contractor_11813336?term=company+profile&page=1&position=2&origin=search&related_id=11813336 |
| calculator | https://www.flaticon.com/free-icon/calculator_2374409?term=calculator&page=1&position=20&origin=search&related_id=2374409 |
| calendar | https://www.flaticon.com/free-icon/calendar_2278049?term=calendar&page=1&position=5&origin=search&related_id=2278049 |
| discord | https://www.flaticon.com/free-icon/discord_5968898?term=discord&page=1&position=3&origin=search&related_id=5968898 |
| doctor | https://www.flaticon.com/free-icon/doctor_10215061?term=doctor&page=1&position=73&origin=search&related_id=10215061 |
| facebook | https://www.flaticon.com/free-icon/facebook_2175193?term=facebook&page=1&position=5&origin=search&related_id=2175193 |
| git | https://www.flaticon.com/free-icon/social_15455742?term=git&page=1&position=4&origin=search&related_id=15455742 |
| i dont know | https://www.flaticon.com/free-icon/i-dont-know_5359909?term=i+dont+know&page=1&position=7&origin=search&related_id=5359909 |
| info | https://www.flaticon.com/free-icon/info_151776?term=about&page=1&position=8&origin=search&related_id=151776 |
| instagram | https://www.flaticon.com/free-icon/instagram_1384031?term=instagram&page=1&position=5&origin=search&related_id=1384031 |
| LinkedIn | https://www.flaticon.com/free-icon/linkedin_3536569?term=linkedin&page=1&position=2&origin=search&related_id=3536569 |
| medium | https://www.flaticon.com/free-icon/medium_5968885?term=medium&page=1&position=7&origin=search&related_id=5968885 |
| messenger | https://www.flaticon.com/free-icon/chat_9333888?term=messenger&page=1&position=8&origin=search&related_id=9333888 |
| minesweeper | https://www.flaticon.com/free-icon/bomb_236454?term=bomb&page=1&position=25&origin=search&related_id=236454 |
| patient file | https://www.flaticon.com/free-icon/patient_2376100?term=medication&page=1&position=6&origin=search&related_id=2376100 |
| patient file | https://www.flaticon.com/free-icon/hospital_1233930?term=medical+snake&page=1&position=7&origin=search&related_id=1233930 |
| pinterest | https://www.flaticon.com/free-icon/pinterest_733622?term=pinterest&page=1&position=6&origin=search&related_id=733622 |
| reddit | https://www.flaticon.com/free-icon/reddit_3128263?term=reddit&page=1&position=5&origin=search&related_id=3128263 |
| snapchat | https://www.flaticon.com/free-icon/snapchat_733627?term=snapchat&page=1&position=6&origin=search&related_id=733627 |
| spotify | https://www.flaticon.com/free-icon/spotify-logo_87409?term=spotify&page=1&position=2&origin=search&related_id=87409 |
| Threads | https://www.flaticon.com/free-icon/threads_12105336?term=threads&page=1&position=1&origin=search&related_id=12105336 |
| TikTok | https://www.flaticon.com/free-icon/tik-tok_3046120?term=tiktok&page=1&position=1&origin=search&related_id=3046120 |
| Twitch | https://www.flaticon.com/free-icon/twitch_5968952?term=twitch&page=1&position=7&origin=search&related_id=5968952 |
| user | https://www.flaticon.com/free-icon/user_1077063?term=profile&page=1&position=6&origin=search&related_id=1077063 |
| Wallet | https://www.flaticon.com/free-icon/wallet-passes-app_3884407?term=wallet&page=1&position=21&origin=search&related_id=3884407 |
| weechat | https://www.flaticon.com/free-icon/wechat_732142?term=wechat&page=1&position=2&origin=search&related_id=732142 |
| whatsapp | https://www.flaticon.com/free-icon/whatsapp_2111774?term=whatsapp&page=1&position=8&origin=search&related_id=2111774 |
| x | https://www.flaticon.com/free-icon/twitter_5968958?term=x&page=1&position=5&origin=search&related_id=5968958 |
| YouTube | https://www.flaticon.com/free-icon/youtube_152810?term=youtube&page=1&position=9&origin=search&related_id=152810 |
| youtube music | https://www.flaticon.com/free-icon/music_15069232?term=youtube+music&page=1&position=4&origin=search&related_id=15069232 |
