import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// A highly customizable search bar with reactive icon states.
///
/// [MihSearchBar] provides a polished search interface that handles
/// common search UX patterns automatically, such as:
/// * **Dynamic Prefixing**: Can swap between [prefixIcon] and [prefixAltIcon]
///   when the user starts typing.
/// * **Automatic Clear Button**: Displays a clear (X) icon only when
///   the [controller] is not empty.
/// * **Tool Extensibility**: Allows for additional widgets (like filter or
///   voice icons) to be added to the end of the bar via [suffixTools].
/// * **Focus Management**: Requires a [searchFocusNode] to handle keyboard
///   interactions and state changes correctly.
///
/// ### Example:
/// ```dart
/// MihSearchBar(
///   controller: _searchController,
///   searchFocusNode: _myFocusNode,
///   hintText: "Search products...",
///   prefixIcon: Icons.search,
///   prefixAltIcon: Icons.arrow_back, // Swaps when typing
///   fillColor: Colors.white,
///   hintColor: Colors.grey,
///   onPrefixIconTap: () => Navigator.pop(context),
///   suffixTools: [
///     IconButton(icon: Icon(Icons.mic), onPressed: () {}),
///   ],
/// )
/// ```
class MihSearchBar extends StatefulWidget {
  /// The controller managing the search query text.
  final TextEditingController controller;

  /// The placeholder text shown when the field is empty.
  final String hintText;

  /// The primary icon shown at the start of the bar.
  final IconData prefixIcon;

  /// An optional icon that replaces [prefixIcon] when text is entered.
  final IconData? prefixAltIcon;

  /// A list of additional widgets to display before the clear icon.
  final List<Widget>? suffixTools;

  /// Total width of the search bar.
  final double? width;

  /// Total height of the search bar.
  final double? height;

  /// The background color of the search bar.
  final Color fillColor;

  /// The color of the hint text and default icons.
  final Color hintColor;

  /// Callback for when the prefix icon (e.g., back arrow) is tapped.
  final void Function()? onPrefixIconTap;

  /// Custom callback for the clear icon. If null, defaults to `controller.clear()`.
  final void Function()? onClearIconTap;

  /// The shadow depth of the search bar.
  final double? elevation;

  /// The focus node used to control keyboard focus and listener state.
  final FocusNode searchFocusNode;

  const MihSearchBar({
    super.key,
    required this.controller,
    required this.hintText,
    required this.prefixIcon,
    this.prefixAltIcon,
    this.suffixTools,
    this.width,
    this.height,
    required this.fillColor,
    required this.hintColor,
    required this.onPrefixIconTap,
    this.onClearIconTap,
    this.elevation,
    required this.searchFocusNode,
  });

  @override
  State<MihSearchBar> createState() => _MihSearchBarState();
}

class _MihSearchBarState extends State<MihSearchBar> {
  bool _showClearIcon = false;

  Widget getPrefixIcon() {
    if (_showClearIcon) {
      // If the clear icon is shown and an alternative prefix icon is provided, use it
      return widget.prefixAltIcon != null
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Icon(
                widget.prefixAltIcon,
                color: widget.hintColor,
                size: 35,
              ),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Icon(Icons.search, color: widget.hintColor, size: 35),
            ); // Default to search icon if no alt icon
    } else {
      // Return the primary prefix icon or the alternative if provided
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Icon(Icons.search, color: widget.hintColor, size: 35),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    // 1. Add the listener to the controller
    widget.controller.addListener(_updateClearIconVisibility);
    // 2. Initialize the clear icon visibility based on the current text
    _updateClearIconVisibility();
  }

  @override
  void dispose() {
    widget.controller.removeListener(_updateClearIconVisibility);
    super.dispose();
  }

  void _updateClearIconVisibility() {
    if (!mounted) {
      return;
    }
    final bool shouldShow = widget.controller.text.isNotEmpty;
    // Only call setState if the visibility state actually changes
    if (_showClearIcon != shouldShow) {
      setState(() {
        _showClearIcon = shouldShow;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: widget.elevation ?? 4.0, // Use provided elevation or default
      borderRadius: BorderRadius.circular(30.0),
      color: widget.fillColor,
      child: AnimatedContainer(
        // Keep AnimatedContainer for width/height transitions
        alignment: Alignment.centerLeft,
        width: widget.width,
        height: widget.height ?? 50,
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(30.0)),
        child: Theme(
          data: Theme.of(context).copyWith(
            textSelectionTheme: TextSelectionThemeData(
              selectionColor: widget.hintColor.withValues(alpha: 0.3),
              selectionHandleColor: widget.hintColor,
            ),
          ),
          child: TextField(
            textAlignVertical: TextAlignVertical.center,
            controller: widget.controller, // Assign the controller
            focusNode: widget.searchFocusNode,
            autocorrect: true,
            spellCheckConfiguration:
                !kIsWeb && (Platform.isAndroid || Platform.isIOS)
                ? SpellCheckConfiguration()
                : null,
            onSubmitted: (value) {
              widget.onPrefixIconTap
                  ?.call(); // Call the prefix icon tap handler
            },
            style: TextStyle(
              color: widget.hintColor,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
            cursorColor: widget.hintColor,
            decoration: InputDecoration(
              isDense: true,
              hintText: widget.hintText,
              hintStyle: TextStyle(
                color: widget.hintColor,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 15.0,
              ),
              prefixIcon: GestureDetector(
                onTap: widget.onPrefixIconTap,
                child: getPrefixIcon(),
              ),
              suffixIcon: Row(
                // Use a Row for multiple suffix icons
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Optional suffix tools
                  if (widget.suffixTools != null) ...widget.suffixTools!,
                  // Clear Icon (conditionally visible)
                  if (_showClearIcon) // Only show if input is not empty
                    IconButton(
                      iconSize: 35,
                      icon: Icon(
                        Icons.clear,
                        color: widget.hintColor,
                      ), // Clear icon
                      onPressed:
                          widget.onClearIconTap ??
                          () {
                            widget.controller.clear();
                            // No need for setState here, _updateClearIconVisibility will handle it
                          },
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
