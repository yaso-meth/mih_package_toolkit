import 'package:flutter/material.dart';
import 'package:mih_package_toolkit/src/mih_colors.dart';
import 'package:mih_package_toolkit/src/mih_icons.dart';

/// A stylized loading dialog featuring a pulsing MIH logo.
///
/// [Mihloadingcircle] is designed to be displayed using [showDialog]. It
/// provides a modal overlay that signals an ongoing background process.
///
/// Features:
/// * **Pulsing Animation**: The [MihIcons.mihLogo] scales between 100% and 50%
///   size every 500ms.
/// * **Themed Container**: A rounded dialog box that adapts to [darkMode].
/// * **Optional Message**: Displays a status message below the animating logo.
///
/// ### Example:
/// ```dart
/// showDialog(
///   context: context,
///   barrierDismissible: false,
///   builder: (context) => const Mihloadingcircle(message: "Loading Data..."),
/// );
/// ```
class Mihloadingcircle extends StatefulWidget {
  /// An optional text message displayed below the pulsing logo.
  final String? message;

  /// Whether to use Dark Mode styling. If null, [MihColors] defaults to dark.
  final bool? darkMode;
  const Mihloadingcircle({super.key, this.message, this.darkMode});

  @override
  State<Mihloadingcircle> createState() => _MihloadingcircleState();
}

class _MihloadingcircleState extends State<Mihloadingcircle>
    with SingleTickerProviderStateMixin {
  /// Manages the timing of the pulse effect.
  late AnimationController _controller;

  /// Defines the scaling range (200.0 to 100.0) for the logo.
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(
        milliseconds: 500,
      ), // Duration for one pulse (grow and shrink)
      vsync: this,
    );
    _animation =
        Tween<double>(
          begin: 200,
          end: 200 * 0.5, // Pulse to 50% of the initial size
        ).animate(
          CurvedAnimation(
            parent: _controller,
            curve: Curves.easeInOut, // Smooth start and end of the pulse
          ),
        );
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: IntrinsicWidth(
        child: IntrinsicHeight(
          child: Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: MihColors.primary(darkMode: widget.darkMode),
              borderRadius: BorderRadius.circular(25.0),
              border: Border.all(
                color: MihColors.primary(darkMode: widget.darkMode),
                width: 5.0,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 200,
                  height: 200,
                  child: AnimatedBuilder(
                    animation: _animation,
                    builder: (context, child) {
                      return Icon(
                        MihIcons.mihLogo,
                        size: _animation
                            .value, // The size changes based on the animation value
                        color: MihColors.secondary(darkMode: widget.darkMode),
                      );
                    },
                  ),
                ),
                if (widget.message != null)
                  Text(
                    widget.message!,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
