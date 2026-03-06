import 'package:flutter/material.dart';
import 'package:mih_package_toolkit/src/mih_colors.dart';

/// A stylized binary switch with integrated labeling.
///
/// [MihToggle] provides a labeled toggle switch that uses the MIH
/// color palette to provide clear visual feedback.
///
/// Features:
/// * **Semantic Color Coding**: Automatically uses [MihColors.green] for
///   the "On" state and [MihColors.red] for the "Off" state.
/// * **Read-Only Mode**: When [readOnly] is true, the toggle is greyed
///   out and interactions are disabled, preserving the UI layout while
///   preventing input.
/// * **Elevation Support**: Includes a [Material] wrapper to allow for
///   shadows and depth, matching other form components.
/// * **State Syncing**: Automatically updates its internal position if the
///   [initialPostion] property is changed by a parent widget.
///
/// ### Example:
/// ```dart
/// MihToggle(
///   hintText: "Enable Notifications",
///   initialPostion: true,
///   fillColor: Colors.blue,
///   secondaryFillColor: Colors.white,
///   onChange: (val) => print("Toggle is now: $val"),
/// )
/// ```
class MihToggle extends StatefulWidget {
  /// The total width of the toggle row container.
  final double? width;

  /// The label text displayed next to the toggle.
  final String hintText;

  /// The initial state of the toggle (true for on, false for off).
  final bool initialPostion;

  /// The color of the label text and the outer elevation surface.
  final Color fillColor;

  /// The color of the moving toggle thumb.
  final Color secondaryFillColor;

  /// If true, the toggle is displayed in a greyed-out, non-interactive state.
  final bool? readOnly;

  /// The shadow depth of the toggle container.
  final double? elevation;

  /// Whether to use Dark Mode shades for the track colors.
  final bool? darkMode;

  /// Callback triggered whenever the toggle state changes.
  final void Function(bool) onChange;
  const MihToggle({
    super.key,
    this.width,
    required this.hintText,
    required this.initialPostion,
    required this.fillColor,
    required this.secondaryFillColor,
    this.readOnly,
    this.elevation,
    this.darkMode,
    required this.onChange,
  });

  @override
  State<MihToggle> createState() => _MihToggleState();
}

class _MihToggleState extends State<MihToggle> {
  late bool togglePosition;

  @override
  void didUpdateWidget(covariant MihToggle oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialPostion != oldWidget.initialPostion) {
      setState(() {
        togglePosition = widget.initialPostion;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    togglePosition = widget.initialPostion;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              widget.hintText,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: widget.fillColor,
                fontSize: 18,
              ),
            ),
          ),
          const SizedBox(width: 10),
          // Material(
          // elevation: widget.elevation ?? 0.01,
          // shadowColor: widget.secondaryFillColor.withOpacity(0.5),
          // color: Colors.transparent,
          // shape: StadiumBorder(),
          Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(
                30,
              ), // Adjust the border radius to match the toggle
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  offset: Offset(
                    0,
                    widget.elevation ?? 10,
                  ), // Adjust the vertical offset
                  blurRadius: widget.elevation ?? 10,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Switch(
              value: togglePosition,
              trackOutlineColor: WidgetStateProperty.resolveWith<Color?>((
                states,
              ) {
                if (widget.readOnly == true) {
                  return Colors.grey;
                }
                if (states.contains(WidgetState.selected)) {
                  return MihColors.green(
                    darkMode: widget.darkMode,
                  ); // Outline color when active
                }
                return MihColors.red(
                  darkMode: widget.darkMode,
                ); // Outline color when active
              }),
              activeColor: widget.readOnly == true
                  ? Colors.grey
                  : widget.secondaryFillColor,
              activeTrackColor: widget.readOnly == true
                  ? Colors.grey.shade400
                  : MihColors.green(darkMode: widget.darkMode),
              inactiveThumbColor: widget.readOnly == true
                  ? Colors.grey
                  : widget.secondaryFillColor,
              inactiveTrackColor: widget.readOnly == true
                  ? Colors.grey.shade400
                  : MihColors.red(darkMode: widget.darkMode),
              // activeColor: widget.secondaryFillColor,
              // activeTrackColor: widget.fillColor,
              // inactiveThumbColor: widget.fillColor,
              // inactiveTrackColor: widget.secondaryFillColor,
              // onChanged: widget.readOnly != true ? widget.onChange : null,
              onChanged: widget.readOnly != true
                  ? (newValue) {
                      setState(() {
                        togglePosition = newValue; // Update internal state
                      });
                      widget.onChange(newValue); // Call the parent's onChange
                    }
                  : null,
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
    );
  }
}
