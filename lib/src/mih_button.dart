import 'package:flutter/material.dart';

/// A custom stylized button component from the MIH Toolkit.
///
/// The [MihButton] provides a consistent look and feel with built-in
/// support for elevations, custom border radii, and automatic color
/// shading for hover and splash effects.
///
/// It automatically handles its disabled state by reducing opacity and
/// removing elevation when [onPressed] is null.
///
/// ### Example:
/// ```dart
/// MihButton(
///   buttonColor: Colors.blue,
///   onPressed: () => print('Button Tapped'),
///   child: Text('Click Me'),
/// )
/// ```
class MihButton extends StatelessWidget {
  /// The callback that is called when the button is tapped or otherwise activated.
  ///
  /// If this is null, the button will be disabled.
  final void Function()? onPressed;

  /// The callback that is called when the button is long-pressed.
  final void Function()? onLongPressed;

  /// The background color of the button.
  final Color buttonColor;

  /// The horizontal extent of the button.
  ///
  /// If null, the button will wrap its content with default padding.
  final double? width;

  /// The vertical extent of the button.
  final double? height;

  /// The radius of the button's corners. Defaults to 25.0.
  final double? borderRadius;

  /// The z-coordinate at which to place this button relative to its parent.
  ///
  /// Defaults to 4.0 when enabled, and 0.0 when disabled.
  final double? elevation;

  /// The widget below this widget in the tree. Typically a [Text] or [Icon].
  final Widget child;

  const MihButton({
    super.key,
    required this.onPressed,
    this.onLongPressed,
    required this.buttonColor,
    this.width,
    this.height,
    this.borderRadius,
    this.elevation,
    required this.child,
  });

  /// Internal helper to calculate a darker shade of the [buttonColor]
  /// for ripples and hover states.
  Color _darkerColor(Color color, [double amount = .1]) {
    final hsl = HSLColor.fromColor(color);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
    return hslDark.toColor();
  }

  @override
  Widget build(BuildContext context) {
    final Color effectiveButtonColor = onPressed == null
        ? buttonColor.withValues(alpha: 0.6)
        : buttonColor;
    final Color rippleColor = _darkerColor(effectiveButtonColor, 0.1);
    final double radius = borderRadius ?? 25.0;
    final double effectiveElevation = onPressed == null
        ? 0.0
        : (elevation ?? 4.0);
    return MouseRegion(
      cursor: onPressed == null
          ? SystemMouseCursors.basic
          : SystemMouseCursors.click,
      child: Material(
        color: effectiveButtonColor,
        borderRadius: BorderRadius.circular(radius),
        elevation: effectiveElevation,
        shadowColor: Colors.black,
        child: InkWell(
          borderRadius: BorderRadius.circular(radius),
          splashColor: rippleColor,
          highlightColor: rippleColor.withValues(alpha: 0.2),
          hoverColor: rippleColor.withValues(alpha: 0.3),
          onTap: onPressed,
          onLongPress: onLongPressed,
          child: Container(
            width: width,
            height: height,
            padding: (width == null || height == null)
                ? const EdgeInsets.symmetric(horizontal: 24, vertical: 12)
                : null,
            alignment: Alignment.center,
            child: child,
          ),
        ),
      ),
    );
  }
}
