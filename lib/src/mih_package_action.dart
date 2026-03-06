import 'package:flutter/material.dart';

/// A standardized action button component for the MIH Toolkit.
///
/// [MihPackageAction] provides a consistent wrapper around [IconButton].
/// It is designed for use in headers, toolbars, and navigation bars where
/// precise control over [iconSize] and padding is required.
///
/// By default, it removes all internal padding to ensure the icon aligns
/// perfectly with text or other UI elements.
///
/// ### Example:
/// ```dart
/// MihPackageAction(
///   icon: Icon(Icons.arrow_back),
///   iconSize: 24.0,
///   onTap: () => Navigator.pop(context),
/// )
/// ```
class MihPackageAction extends StatefulWidget {
  /// The callback that is called when the button is tapped.
  ///
  /// If null, the button will be disabled and appear greyed out.
  final void Function()? onTap;

  /// The size of the icon inside the button.
  final double iconSize;

  /// The widget to display as the button's icon (typically an [Icon] or [MihIcons]).
  final Widget icon;
  const MihPackageAction({
    super.key,
    required this.icon,
    required this.iconSize,
    required this.onTap,
  });

  @override
  State<MihPackageAction> createState() => _MihPackageActionState();
}

class _MihPackageActionState extends State<MihPackageAction> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: widget.iconSize,
      padding: const EdgeInsets.all(0),
      onPressed: widget.onTap,
      icon: widget.icon,
    );
  }
}
