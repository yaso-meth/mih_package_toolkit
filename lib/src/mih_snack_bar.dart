import 'package:flutter/material.dart';

/// A helper function to generate a standardized MIH-styled SnackBar.
///
/// [MihSnackBar] returns a [SnackBar] configured with a modern, floating
/// aesthetic. It is designed to be used with `ScaffoldMessenger.of(context).showSnackBar()`.
///
/// Features:
/// * **Stadium Border**: Uses a pill-shaped [StadiumBorder] for a sleek look.
/// * **Floating Behavior**: Set to [SnackBarBehavior.floating], allowing it
///   to appear above bottom navigation or floating action buttons.
/// * **Auto-Dismiss**: Features a default 2-second duration and a
///   built-in "Dismiss" action.
///
/// ### Example:
/// ```dart
/// ScaffoldMessenger.of(context).showSnackBar(
///   MihSnackBar(
///     backgroundColor: Colors.blue,
///     child: Text("Data saved successfully!"),
///   ),
/// );
/// ```
// ignore: non_constant_identifier_names
SnackBar MihSnackBar({Color? backgroundColor, required Widget child}) {
  return SnackBar(
    backgroundColor: backgroundColor,
    content: child,
    shape: StadiumBorder(),
    behavior: SnackBarBehavior.floating,
    duration: Duration(seconds: 2),
    width: null,
    action: SnackBarAction(label: "Dismiss", onPressed: () {}),
  );
}
