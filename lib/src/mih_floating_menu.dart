import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:mih_package_toolkit/src/mih_colors.dart';

/// A customized floating action button that expands into a menu of sub-actions.
///
/// The [MihFloatingMenu] uses a "Speed Dial" pattern to present multiple
/// actions to the user in a space-efficient manner. It features:
/// * **Automatic Color Transition**: Changes from [MihColors.green] to
/// [MihColors.red] when toggled open.
/// * **Flexible Iconography**: Supports both static [IconData] and [AnimatedIconData].
/// * **Themed Overlay**: Applies a semi-transparent dark overlay to the
/// background when active to focus user attention on the menu.
///
/// ### Example:
/// ```dart
/// MihFloatingMenu(
///   icon: Icons.add,
///   children: [
///     SpeedDialChild(
///       child: Icon(Icons.share),
///       label: 'Share',
///       onTap: () => print('Share tapped'),
///     ),
///   ],
/// )
/// ```
class MihFloatingMenu extends StatefulWidget {
  /// The static icon to display when the menu is closed.
  ///
  /// If [animatedIcon] is provided, this property is typically ignored.
  final IconData? icon;

  /// The size of the floating action button. Defaults to 56.0.
  final double? iconSize;

  /// An optional animated icon (e.g., menu to close) to use for the button.
  final AnimatedIconData? animatedIcon;

  /// The direction in which the menu children will expand.
  ///
  /// Defaults to [SpeedDialDirection.up].
  final SpeedDialDirection? direction;

  /// Whether to use Dark Mode styling for the component colors.
  final bool? darkMode;

  /// The list of [SpeedDialChild] widgets to display when the menu is expanded.
  final List<SpeedDialChild> children;
  const MihFloatingMenu({
    super.key,
    this.icon,
    this.iconSize,
    this.animatedIcon,
    this.direction,
    this.darkMode,
    required this.children,
  });

  @override
  State<MihFloatingMenu> createState() => _MihFloatingMenuState();
}

class _MihFloatingMenuState extends State<MihFloatingMenu> {
  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      key: GlobalKey(),
      icon: widget.icon,
      buttonSize: Size(widget.iconSize ?? 56.0, widget.iconSize ?? 56.0),
      animatedIcon: widget.animatedIcon,
      direction: widget.direction ?? SpeedDialDirection.up,
      activeIcon: Icons.close,
      backgroundColor: MihColors.green(darkMode: widget.darkMode),
      activeBackgroundColor: MihColors.red(darkMode: widget.darkMode),
      foregroundColor: MihColors.primary(darkMode: widget.darkMode),
      overlayColor: Colors.black,
      overlayOpacity: 0.5,
      children: widget.children,
      onOpen: () => debugPrint('OPENING DIAL'),
      onClose: () => debugPrint('DIAL CLOSED'),
    );
  }
}
