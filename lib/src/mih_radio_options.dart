import 'package:flutter/material.dart';

/// A customized group of radio buttons for selecting a single option from a list.
///
/// [MihRadioOptions] provides a stylized vertical list of radio buttons.
/// It is unique because it uses a [TextEditingController] to manage its state,
/// allowing it to behave like other text-based input fields in a form.
///
/// Features:
/// * **Auto-Selection**: If the controller is empty, it defaults to the first
///   option in [radioOptions] during initialization.
/// * **Reactive UI**: Uses an [AnimatedBuilder] to listen to the controller
///   and update the "selected" dot immediately when changed.
/// * **Labeling**: Includes a primary label and an automatic "(Optional)"
///   tag based on [requiredText].
/// * **Custom Theming**: Primary and secondary colors can be set via
///   [fillColor] and [secondaryFillColor].
///
/// ### Example:
/// ```dart
/// MihRadioOptions(
///   controller: genderController,
///   hintText: "Gender",
///   radioOptions: ["Male", "Female", "Other"],
///   fillColor: Colors.blue,
///   secondaryFillColor: Colors.grey,
///   requiredText: true,
/// )
/// ```
class MihRadioOptions extends StatefulWidget {
  /// The total width of the radio group container.
  final double? width;

  /// The controller that stores the string value of the selected option.
  final TextEditingController controller;

  /// The title text displayed above the options.
  final String hintText;

  /// The color used for the title and the selected radio state.
  final Color fillColor;

  /// The color used for the unselected radio state and borders.
  final Color secondaryFillColor;

  /// Whether the field is mandatory.
  ///
  /// If `false`, displays "(Optional)" next to the [hintText].
  final bool requiredText;

  /// The list of string labels for each radio option.
  final List<String> radioOptions;
  const MihRadioOptions({
    super.key,
    this.width,
    required this.controller,
    required this.hintText,
    required this.fillColor,
    required this.secondaryFillColor,
    required this.requiredText,
    required this.radioOptions,
  });

  @override
  State<MihRadioOptions> createState() => _MihRadioOptionsState();
}

class _MihRadioOptionsState extends State<MihRadioOptions> {
  // late String _currentSelection;

  @override
  void initState() {
    super.initState();
    if (widget.controller.text.isEmpty && widget.radioOptions.isNotEmpty) {
      widget.controller.text = widget.radioOptions[0];
    }
    // else{
    //               int index = widget.radioOptions
    //                   .indexWhere((element) => element == option);
    //               _currentSelection = widget.radioOptions[index];
    //               widget.controller.text = option;

    // }
    // _currentSelection = widget.radioOptions[0];
  }

  // The method to handle a change in selection.
  void _onChanged(String? value) {
    if (value != null) {
      widget.controller.text = value;
    }
  }

  Widget displayRadioOptions(String selection) {
    return Material(
      elevation: 4.0,
      borderRadius: BorderRadius.circular(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: widget.fillColor,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          children: widget.radioOptions.map((option) {
            return GestureDetector(
              onTap: () {
                _onChanged(option);
              },
              child: Row(
                children: [
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      option,
                      style: TextStyle(
                        color: widget.secondaryFillColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Radio<String>(
                    value: option,
                    groupValue: selection,
                    onChanged: _onChanged,
                    activeColor: widget.secondaryFillColor,
                    fillColor: WidgetStateProperty.resolveWith<Color?>((
                      Set<WidgetState> states,
                    ) {
                      if (states.contains(WidgetState.selected)) {
                        return widget.secondaryFillColor; // Color when selected
                      }
                      return widget.secondaryFillColor;
                    }),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.controller,
      builder: (context, child) {
        final currentSelection = widget.controller.text;
        return SizedBox(
          width: widget.width,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.hintText,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: widget.fillColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Visibility(
                    visible: !widget.requiredText,
                    child: Text(
                      "(Optional)",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: widget.fillColor,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              displayRadioOptions(currentSelection),
            ],
          ),
        );
      },
    );
  }
}
