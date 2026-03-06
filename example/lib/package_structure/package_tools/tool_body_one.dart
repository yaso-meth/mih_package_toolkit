import 'package:flutter/material.dart';
import 'package:mih_package_toolkit/mih_package_toolkit.dart';

class ToolBodyOne extends StatefulWidget {
  const ToolBodyOne({super.key});

  @override
  State<ToolBodyOne> createState() => _ToolBodyOneState();
}

class _ToolBodyOneState extends State<ToolBodyOne> {
  @override
  Widget build(BuildContext context) {
    return MihPackageToolBody(
      backgroundColor: MihColors.primary(),
      bodyItem: MihSingleChildScroll(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "This tool body is to showcase mih button, windows snackbar and colors",
              style: TextStyle(fontSize: 24, color: MihColors.secondary()),
            ),
            SizedBox(height: 20),
            MihButton(
              buttonColor: MihColors.secondary(),
              width: 300,
              child: Text(
                "Show Snackbar",
                style: TextStyle(
                  color: MihColors.primary(),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  MihSnackBar(
                    backgroundColor: MihColors.red(),
                    child: Text(
                      "Hello from the snackbar",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 20),
            MihButton(
              buttonColor: MihColors.secondary(),
              width: 300,
              child: Text(
                "Open Mih Window",
                style: TextStyle(
                  color: MihColors.primary(),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                showMihWindow(null, null, "Default Window");
              },
            ),
            SizedBox(height: 20),
            MihButton(
              buttonColor: MihColors.grey(),
              width: 300,
              child: Text(
                "Grey Button",
                style: TextStyle(
                  color: MihColors.primary(),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                showMihWindow(
                  MihColors.grey(),
                  MihColors.primary(),
                  "Grey Window",
                );
              },
            ),
            SizedBox(height: 20),
            MihButton(
              buttonColor: MihColors.green(),
              width: 300,
              child: Text(
                "Green Window",
                style: TextStyle(
                  color: MihColors.primary(),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                debugPrint("Green Button Pressed");
                showMihWindow(
                  MihColors.green(),
                  MihColors.primary(),
                  "Green Window",
                );
              },
            ),
            SizedBox(height: 20),
            MihButton(
              buttonColor: MihColors.red(),
              width: 300,
              child: Text(
                "Red Window",
                style: TextStyle(
                  color: MihColors.primary(),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                debugPrint("Red Button Pressed");
                showMihWindow(
                  MihColors.red(),
                  MihColors.primary(),
                  "Red Window",
                );
              },
            ),
            SizedBox(height: 20),
            MihButton(
              buttonColor: MihColors.pink(),
              width: 300,
              child: Text(
                "Pink Window",
                style: TextStyle(
                  color: MihColors.primary(),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                debugPrint("Pink Button Pressed");
                showMihWindow(
                  MihColors.pink(),
                  MihColors.primary(),
                  "Pink Window",
                );
              },
            ),
            SizedBox(height: 20),
            MihButton(
              buttonColor: MihColors.orange(),
              width: 300,
              child: Text(
                "Orange Window",
                style: TextStyle(
                  color: MihColors.primary(),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                debugPrint("Orange Button Pressed");
                showMihWindow(
                  MihColors.orange(),
                  MihColors.primary(),
                  "Orange Window",
                );
              },
            ),
            SizedBox(height: 20),
            MihButton(
              buttonColor: MihColors.yellow(),
              width: 300,
              child: Text(
                "Yellow Window",
                style: TextStyle(
                  color: MihColors.primary(),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                debugPrint("Yellow Button Pressed");
                showMihWindow(
                  MihColors.yellow(),
                  MihColors.primary(),
                  "Yellow Window",
                );
              },
            ),
            SizedBox(height: 20),
            MihButton(
              buttonColor: MihColors.bluishPurple(),
              width: 300,
              child: Text(
                "Bluish Purple Window",
                style: TextStyle(
                  color: MihColors.secondary(),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                debugPrint("Bluish Purple Button Pressed");
                showMihWindow(
                  MihColors.bluishPurple(),
                  MihColors.secondary(),
                  "Bluish Purple Window",
                );
              },
            ),
            SizedBox(height: 20),
            MihButton(
              buttonColor: MihColors.purple(),
              width: 300,
              child: Text(
                "Purple Window",
                style: TextStyle(
                  color: MihColors.primary(),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                debugPrint("Purple Button Pressed");
                showMihWindow(
                  MihColors.purple(),
                  MihColors.primary(),
                  "Purple Window",
                );
              },
            ),
            SizedBox(height: 20),
            MihButton(
              buttonColor: MihColors.gold(),
              width: 300,
              child: Text(
                "Gold Window",
                style: TextStyle(
                  color: MihColors.primary(),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                debugPrint("Gold Button Pressed");
                showMihWindow(
                  MihColors.gold(),
                  MihColors.primary(),
                  "Gold Window",
                );
              },
            ),
            SizedBox(height: 20),
            MihButton(
              buttonColor: MihColors.silver(),
              width: 300,
              child: Text(
                "Silver Window",
                style: TextStyle(
                  color: MihColors.primary(),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                debugPrint("Silver Button Pressed");
                showMihWindow(
                  MihColors.silver(),
                  MihColors.primary(),
                  "Silver Window",
                );
              },
            ),
            SizedBox(height: 20),
            MihButton(
              buttonColor: MihColors.bronze(),
              width: 300,
              child: Text(
                "Bronze Window",
                style: TextStyle(
                  color: MihColors.primary(),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                debugPrint("Bronze Button Pressed");
                showMihWindow(
                  MihColors.bronze(),
                  MihColors.primary(),
                  "Bronze Window",
                );
              },
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  void showMihWindow(Color? bdColor, Color? fgColor, String title) {
    showDialog(
      context: context,
      builder: (context) {
        return MihPackageWindow(
          backgroundColor: bdColor,
          foregroundColor: fgColor,
          fullscreen: false,
          windowTitle: title,
          onWindowTapClose: () {
            Navigator.of(context).pop();
          },
          windowBody: SizedBox(height: 500),
        );
      },
    );
  }
}
