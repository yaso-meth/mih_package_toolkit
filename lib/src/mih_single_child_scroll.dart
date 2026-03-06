import 'package:flutter/material.dart';

/// A standardized scrollable container for the MIH Toolkit.
///
/// [MihSingleChildScroll] wraps a single widget in a [SingleChildScrollView]
/// and provides integrated support for [SafeArea] and custom [ScrollConfiguration].
///
/// Features:
/// * **Safe Area Insets**: Automatically protects content from overlapping
///   with system UI elements (like notches or home indicators).
/// * **Toggleable Scrollbars**: Control scrollbar visibility via the
///   [scrollbarOn] property across all platforms.
/// * **Consistent Bottom Padding**: Applies a minimum 5px bottom margin
///   to ensure content doesn't sit flush against the bottom of the screen.
///
/// ### Example:
/// ```dart
/// MihSingleChildScroll(
///   scrollbarOn: true,
///   child: Column(
///     children: [
///       Text("Long list of items..."),
///       // ... more widgets
///     ],
///   ),
/// )
/// ```
class MihSingleChildScroll extends StatefulWidget {
  /// The widget to be made scrollable.
  final Widget child;

  /// Whether to force the display of scrollbars.
  ///
  /// Defaults to `false` if null. When enabled, it applies a
  /// [ScrollConfiguration] to the child subtree.
  final bool? scrollbarOn;
  const MihSingleChildScroll({
    super.key,
    required this.child,
    this.scrollbarOn,
  });

  @override
  State<MihSingleChildScroll> createState() => _MihSingleChildScrollState();
}

class _MihSingleChildScrollState extends State<MihSingleChildScroll> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      minimum: EdgeInsets.only(bottom: 5),
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(
          context,
        ).copyWith(scrollbars: widget.scrollbarOn ?? false),
        child: SingleChildScrollView(child: widget.child),
      ),
    );
  }
}
