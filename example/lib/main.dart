import 'package:example/package_structure/example_package.dart';
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
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: MihColors.primary(),
        colorScheme: ColorScheme(
          brightness: Brightness.dark,
          primary: MihColors.secondary(),
          onPrimary: MihColors.primary(),
          secondary: MihColors.primary(),
          onSecondary: MihColors.secondary(),
          error: MihColors.red(),
          onError: MihColors.primary(),
          surface: MihColors.primary(),
          onSurface: MihColors.secondary(),
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: MihPackageTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ExamplePackage()),
            );
          },
          packageName: "Example Package",
          packageIcon: Icon(MihIcons.mihLogo, color: MihColors.secondary()),
          iconSize: 150,
          textColor: MihColors.secondary(),
        ),
      ),
    );
  }
}
