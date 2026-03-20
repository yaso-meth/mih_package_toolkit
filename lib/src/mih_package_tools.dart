import 'package:flutter/material.dart';
import 'package:mih_package_toolkit/src/mih_colors.dart';

/// A horizontal toolbar used for navigation within a [MihPackage].
///
/// [MihPackageTools] displays a set of icons that correspond to different
/// modules or pages. It automatically manages the visual state of buttons,
/// using a filled background for the currently selected index.
///
/// Features:
/// * **Dynamic Mapping**: Uses a `Map<Widget, void Function()?>` to pair
///   icons with their respective tap behaviors.
/// * **Selection Highlighting**: Toggles between [IconButton] and
///   [IconButton.filled] based on the [selectedIndex].
/// * **Alignment**: Right-aligned by default to sit neatly in a header.
///
/// ### Example:
/// ```dart
/// MihPackageTools(
///   selectedIndex: 0,
///   tools: {
///     Icon(Icons.home): () => () {
///          setState(() {
///             selectedbodyIndex = 0;
///          });
///       },
///     Icon(Icons.settings): () => () => () {
///          setState(() {
///             selectedbodyIndex = 0;
///          });
///       },
///   },
/// )
/// ```
// ignore: must_be_immutable
class MihPackageTools extends StatefulWidget {
  /// The selected button fill color and unselected icon color
  final Color? toolColor;

  /// The selected button fill color and unselected icon color
  final Color? onSelectedIconColor;

  /// A map where the key is the Icon widget and the value is the
  /// callback function triggered on tap.
  final Map<Widget, void Function()?> tools;

  /// The index of the currently active tool.
  ///
  /// This determines which button is rendered as "filled".
  int selectedIndex;
  MihPackageTools({
    super.key,
    this.toolColor,
    this.onSelectedIconColor,
    required this.tools,
    required this.selectedIndex,
  });

  @override
  State<MihPackageTools> createState() => _MihPackageToolsState();
}

class _MihPackageToolsState extends State<MihPackageTools> {
  /// Generates a list of widgets representing the tools.
  ///
  /// Uses [Visibility] to swap between the active (filled) and
  /// inactive (standard) versions of each icon button.
  List<Widget> getTools() {
    List<Widget> temp = [];
    int index = 0;
    widget.tools.forEach((icon, onTap) {
      temp.add(
        Visibility(
          visible: widget.selectedIndex != index,
          child: IconButton(
            color: widget.toolColor ?? MihColors.secondary(),
            onPressed: onTap,
            icon: icon,
          ),
        ),
      );
      temp.add(
        Visibility(
          visible: widget.selectedIndex == index,
          child: IconButton.filled(
            color: widget.onSelectedIconColor ?? MihColors.primary(),
            onPressed: onTap,
            icon: icon,
            style: IconButton.styleFrom(
              backgroundColor: widget.toolColor ?? MihColors.secondary(),
            ),
          ),
        ),
      );
      index += 1;
    });
    return temp;
  }

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.end, children: getTools());
  }
}
