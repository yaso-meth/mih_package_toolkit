import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:mih_package_toolkit/src/mih_button.dart';
import 'package:mih_package_toolkit/src/mih_colors.dart';
import 'package:mih_package_toolkit/src/mih_floating_menu.dart';
import 'package:mih_package_toolkit/src/mih_single_child_scroll.dart';

/// A versatile window container used for dialogs or sub-sections.
///
/// [MihPackageWindow] provides a standardized "windowed" UI that can
/// toggle between [fullscreen] and modal dialog modes.
///
/// Features:
/// * **Adaptive Layout**: Automatically adjusts padding and title size
///   based on screen dimensions (Mobile vs. Desktop/Tablet).
/// * **Integrated Actions**: If [menuOptions] is provided, a
///   [MihFloatingMenu] is automatically added to the window.
/// * **Scroll Management**: Wraps content in [MihSingleChildScroll] if
///   [scrollbarOn] is enabled.
/// * **Close Logic**: Provides a consistent header with a back/close button
///   that triggers [onWindowTapClose].
///
/// ### Example (Modal Dialog):
/// ```dart
/// MihPackageWindow(
///   fullscreen: false,
///   windowTitle: "Settings",
///   onWindowTapClose: () => Navigator.pop(context),
///   windowBody: MySettingsWidget(),
/// )
/// ```
class MihPackageWindow extends StatefulWidget {
  /// The text displayed in the window's header.
  final String? windowTitle;

  /// The main content widget to display inside the window.
  final Widget windowBody;

  /// Optional actions to display via a floating menu button.
  final List<SpeedDialChild>? menuOptions;

  /// Callback triggered when the close/back button in the header is pressed.
  final void Function()? onWindowTapClose;

  /// The background color of the window. Defaults to [MihColors.primary].
  final Color? backgroundColor;

  /// The color used for headers and primary text. Defaults to [MihColors.secondary].
  final Color? foregroundColor;

  /// Whether to display a colored border around the window.
  final bool? borderOn;

  /// If true, the window takes up the full screen.
  /// If false, it renders as a centered modal box.
  final bool fullscreen;

  /// Whether to show a scrollbar for the [windowBody].
  final bool? scrollbarOn;

  /// Whether to use Dark Mode styling.
  final bool? darkMode;
  const MihPackageWindow({
    super.key,
    required this.fullscreen,
    required this.windowTitle,
    this.menuOptions,
    required this.onWindowTapClose,
    required this.windowBody,
    this.borderOn,
    this.scrollbarOn,
    this.backgroundColor,
    this.foregroundColor,
    this.darkMode,
  });

  @override
  State<MihPackageWindow> createState() => _MihPackageWindowState();
}

class _MihPackageWindowState extends State<MihPackageWindow> {
  late double windowTitleSize;
  late double horizontralWindowPadding;
  late double verticalWindowPadding;
  late double windowWidth;
  late double windowHeight;
  late double width;
  late double height;

  void checkScreenSize(Size screenSize) {
    // print("screen width: $width");
    // print("screen height: $height");
    if (screenSize.width > 800) {
      setState(() {
        windowTitleSize = 25;
        horizontralWindowPadding = width / 7;
        verticalWindowPadding = 10;
        windowWidth = width;
        windowHeight = height;
      });
    } else {
      setState(() {
        windowTitleSize = 20;
        horizontralWindowPadding = 10;
        verticalWindowPadding = 10;
        windowWidth = width;
        windowHeight = height;
      });
    }
  }

  Widget getHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (widget.onWindowTapClose != null)
          Padding(
            padding: const EdgeInsets.only(top: 5.0, left: 5.0),
            child: MihButton(
              width: 40,
              height: 40,
              elevation: 10,
              onPressed: widget.onWindowTapClose,
              buttonColor: MihColors.red(darkMode: widget.darkMode),
              child: Icon(
                Icons.close,
                color: MihColors.primary(darkMode: widget.darkMode),
              ),
            ),
          ),
        if (widget.windowTitle != null)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                widget.windowTitle!,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: windowTitleSize,
                  fontWeight: FontWeight.bold,
                  color:
                      widget.foregroundColor ??
                      MihColors.secondary(darkMode: widget.darkMode),
                ),
              ),
            ),
          ),
        if (widget.menuOptions != null)
          Padding(
            padding: const EdgeInsets.only(top: 5.0, right: 5.0),
            child: SizedBox(
              width: 40,
              child: MihFloatingMenu(
                iconSize: 40,
                animatedIcon: AnimatedIcons.menu_close,
                direction: SpeedDialDirection.down,
                children: widget.menuOptions != null ? widget.menuOptions! : [],
                darkMode: widget.darkMode,
              ),
            ),
          ),
      ],
    );
  }

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
    var size = MediaQuery.of(context).size;
    setState(() {
      width = size.width;
      height = size.height;
    });
    checkScreenSize(size);
    return Dialog(
      insetPadding: EdgeInsets.symmetric(
        horizontal: horizontralWindowPadding,
        vertical: verticalWindowPadding,
      ),
      insetAnimationCurve: Easing.emphasizedDecelerate,
      insetAnimationDuration: Durations.short1,
      child: Material(
        elevation: 10,
        shadowColor: Colors.black,
        color:
            widget.backgroundColor ??
            MihColors.primary(darkMode: widget.darkMode),
        borderRadius: BorderRadius.circular(25.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.0),
            border: widget.borderOn == null || !widget.borderOn!
                ? null
                : Border.all(
                    color:
                        widget.foregroundColor ??
                        MihColors.secondary(darkMode: widget.darkMode),
                    width: 5.0,
                  ),
          ),
          child: widget.fullscreen
              ? Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    getHeader(),
                    const SizedBox(height: 5),
                    Expanded(
                      child: widget.scrollbarOn != null || !widget.scrollbarOn!
                          ? widget.windowBody
                          : MihSingleChildScroll(
                              scrollbarOn: true,
                              child: widget.windowBody,
                            ),
                    ),
                  ],
                )
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    getHeader(),
                    const SizedBox(height: 5),
                    Flexible(
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 25,
                          right: 25,
                          bottom: verticalWindowPadding,
                        ),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxHeight: windowHeight * 0.85,
                            maxWidth: windowWidth * 0.85,
                          ),
                          child: MihSingleChildScroll(
                            scrollbarOn: true,
                            child: widget.windowBody,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
