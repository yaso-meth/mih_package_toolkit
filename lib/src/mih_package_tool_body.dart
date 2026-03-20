import 'package:flutter/material.dart';
import 'package:mih_package_toolkit/src/mih_colors.dart';

/// A structural container for individual pages within a [MihPackage].
///
/// [MihPackageToolBody] acts as the primary wrapper for page content. It
/// provides consistent layout rules, including:
/// * **Responsive Padding**: Automatically adjusts horizontal and vertical
///   spacing based on screen size and the presence of a border.
/// * **Optional Framing**: Can display a rounded border using [borderOn].
/// * **Theme Integration**: Border and background colors sync with [MihColors].
///
/// This widget is typically used as an item in the `appBody` list of a [MihPackage].
///
/// ### Example:
/// ```dart
/// MihPackageToolBody(
///   backgroundColor: Colors.white,
///   borderOn: true,
///   borderColor: Colors.blue,
///   bodyItem: Center(child: Text("Page Content")),
/// )
/// ```
class MihPackageToolBody extends StatefulWidget {
  /// The background color of the content area.
  final Color backgroundColor;

  /// The color of the outer border. Defaults to [MihColors.secondary] if null.
  final Color? borderColor;

  /// Whether to display a 3.0 width rounded border around the content.
  final bool? borderOn;

  /// The main widget to be displayed inside this body container.
  final Widget bodyItem;

  /// Custom horizontal padding. Defaults to 10.0 if [borderOn] is true,
  /// otherwise 0.0.
  final double? innerHorizontalPadding;

  /// Whether to use Dark Mode styling for default border colors.
  final bool? darkMode;
  const MihPackageToolBody({
    super.key,
    required this.backgroundColor,
    this.borderColor,
    this.borderOn,
    required this.bodyItem,
    this.darkMode,
    this.innerHorizontalPadding,
  });

  @override
  State<MihPackageToolBody> createState() => _MihPackageToolBodyState();
}

class _MihPackageToolBodyState extends State<MihPackageToolBody> {
  /// Internal padding value calculated based on the border state.
  late double _innerBodyPadding;

  /// Calculates horizontal padding based on [MediaQuery] and [widget.borderOn].
  double getHorizontalPaddingSize(Size screenSize) {
    if (screenSize.width > 800) {
      if (widget.borderOn != null && widget.borderOn!) {
        return widget.innerHorizontalPadding ?? 10;
      } else {
        return widget.innerHorizontalPadding ?? 0;
      }
    } else {
      // mobile
      if (widget.borderOn != null && widget.borderOn!) {
        return widget.innerHorizontalPadding ?? 10;
      } else {
        return widget.innerHorizontalPadding ?? 0;
      }
    }
  }

  /// Calculates vertical padding (bottom only) when a border is active.
  double getVerticalPaddingSize(Size screenSize) {
    // mobile
    if (widget.borderOn != null && widget.borderOn!) {
      return 10;
    } else {
      return 0;
    }
  }

  /// Generates the [BoxDecoration] for the container, handling border
  /// visibility and color.
  Decoration? getBoder() {
    if (widget.borderOn != null && widget.borderOn!) {
      _innerBodyPadding = 10.0;
      return BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: BorderRadius.circular(25.0),
        border: Border.all(
          color: widget.borderColor ??
              MihColors.secondary(darkMode: widget.darkMode),
          width: 3.0,
        ),
      );
    } else {
      _innerBodyPadding = 0.0;
      return BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: BorderRadius.circular(0),
        border: Border.all(color: widget.backgroundColor, width: 3.0),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.sizeOf(context);

    return Padding(
      padding: EdgeInsets.only(
        left: getHorizontalPaddingSize(screenSize),
        right: getHorizontalPaddingSize(screenSize),
        bottom: getVerticalPaddingSize(screenSize),
        top: 0,
      ),
      child: Container(
        height: screenSize.height,
        decoration: getBoder(),
        child: Padding(
          padding: EdgeInsets.all(_innerBodyPadding),
          child: widget.bodyItem,
        ),
      ),
    );
  }
}
