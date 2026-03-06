import 'package:flutter/material.dart';
import 'package:mih_package_toolkit/src/mih_colors.dart';
import 'package:mih_package_toolkit/src/mih_text_form_field.dart';

/// A numeric input component that allows users to increment or decrement values.
///
/// The [MihNumericStepper] provides a user-friendly way to select an integer
/// within an optional range. It consists of:
/// * **Decrement/Increment Buttons**: The minus button is themed with [MihColors.red]
///   and the plus button with [MihColors.green].
/// * **Read-only Display**: A central [MihTextFormField] that displays the current value.
/// * **Validation**: Built-in range checking against [minValue] and [maxValue].
///
/// ### Example:
/// ```dart
/// MihNumericStepper(
///   controller: myController,
///   hintText: "Quantity",
///   minValue: 1,
///   maxValue: 10,
///   requiredText: true,
///   validationOn: true,
///   fillColor: Colors.blue,
///   inputColor: Colors.white,
/// )
/// ```
class MihNumericStepper extends StatefulWidget {
  /// The controller managing the string value of the number.
  final TextEditingController controller;

  /// The primary color used for the label text.
  final Color fillColor;

  /// The color of the icons inside the increment/decrement buttons.
  final Color inputColor;

  /// The label text displayed above the stepper.
  final String hintText;

  /// Whether the field is marked as required.
  final bool requiredText;

  /// The total width of the stepper widget.
  final double? width;

  /// The minimum allowed value. Defaults to 0 if null.
  final int? minValue;

  /// The maximum allowed value. If null, there is no upper bound.
  final int? maxValue;

  /// Whether to trigger validation logic for range and empty states.
  final bool validationOn;

  /// Whether to use Dark Mode styling for the step buttons.
  final bool? darkMode;
  const MihNumericStepper({
    super.key,
    required this.controller,
    required this.fillColor,
    required this.inputColor,
    required this.hintText,
    required this.requiredText,
    this.width,
    this.minValue,
    this.maxValue,
    required this.validationOn,
    this.darkMode,
  });

  @override
  State<MihNumericStepper> createState() => _MihNumericStepperState();
}

class _MihNumericStepperState extends State<MihNumericStepper> {
  /// Internal integer representation of the value in [widget.controller].
  late int _currentValue;
  late bool error;

  /// Validates if the [number] string is a valid integer within the
  /// [minValue] and [maxValue] bounds.
  String? validateNumber(String? number, int? minValue, int? maxValue) {
    String? errorMessage = "";
    if (number == null || number.isEmpty) {
      errorMessage += "This field is required";
      return errorMessage;
    }
    int? value = int.tryParse(number);
    if (value == null) {
      errorMessage += "Please enter a valid number";
      return errorMessage;
    }
    if (value < (minValue ?? 0)) {
      errorMessage += "Value must be >= ${minValue ?? 0}";
    }
    if (maxValue != null && value > maxValue) {
      if (errorMessage.isNotEmpty) errorMessage += "\n";
      errorMessage += "Value must be <= $maxValue";
    }
    return errorMessage.isEmpty ? null : errorMessage;
  }

  @override
  void dispose() {
    widget.controller.removeListener(_syncCurrentValue);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _currentValue =
        int.tryParse(widget.controller.text) ?? widget.minValue ?? 0;
    widget.controller.text = _currentValue.toString();
    int.tryParse(widget.controller.text) ?? widget.minValue ?? 0;
    widget.controller.addListener(_syncCurrentValue);
  }

  /// Synchronizes the internal [_currentValue] whenever the [widget.controller]
  /// changes (e.g., via external logic).
  void _syncCurrentValue() {
    final newValue =
        int.tryParse(widget.controller.text) ?? widget.minValue ?? 0;
    if (newValue != _currentValue) {
      setState(() {
        _currentValue = newValue;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: Column(
        children: [
          Row(
            children: [
              Text(
                widget.hintText,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: widget.fillColor,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                children: [
                  Container(
                    // color: Colors.white,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        25,
                      ), // Optional: rounds the corners
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromARGB(
                            60,
                            0,
                            0,
                            0,
                          ), // 0.2 opacity = 51 in alpha (255 * 0.2)
                          spreadRadius: -2,
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 2.0, left: 5.0),
                      child: SizedBox(
                        width: 40,
                        child: IconButton.filled(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all<Color>(
                              MihColors.red(darkMode: widget.darkMode),
                            ),
                          ),
                          color: widget.inputColor,
                          iconSize: 20,
                          onPressed: () {
                            if (_currentValue >= (widget.minValue ?? 0)) {
                              setState(() {
                                widget.controller.text = (_currentValue - 1)
                                    .toString();
                                _currentValue = int.tryParse(
                                  widget.controller.text,
                                )!;
                              });
                            }
                          },
                          icon: const Icon(Icons.remove),
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible:
                        _currentValue < (widget.minValue ?? 0) ||
                        (widget.maxValue != null &&
                            _currentValue > widget.maxValue!),
                    child: const SizedBox(height: 21),
                  ),
                ],
              ),
              const SizedBox(width: 15),
              Expanded(
                child: MihTextFormField(
                  darkMode: widget.darkMode,
                  fillColor: widget.fillColor,
                  inputColor: widget.inputColor,
                  controller: widget.controller,
                  hintText: null,
                  requiredText: widget.requiredText,
                  readOnly: true,
                  numberMode: true,
                  textIputAlignment: TextAlign.center,
                  validator: (value) {
                    if (widget.validationOn) {
                      return validateNumber(
                        value,
                        widget.minValue,
                        widget.maxValue,
                      );
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(width: 10),
              Column(
                children: [
                  Container(
                    // color: Colors.white,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        25,
                      ), // Optional: rounds the corners
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromARGB(
                            60,
                            0,
                            0,
                            0,
                          ), // 0.2 opacity = 51 in alpha (255 * 0.2)
                          spreadRadius: -2,
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 2.0, left: 5.0),
                      child: SizedBox(
                        width: 40,
                        child: IconButton.filled(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all<Color>(
                              MihColors.green(darkMode: widget.darkMode),
                            ),
                          ),
                          color: widget.inputColor,
                          iconSize: 20,
                          onPressed: () {
                            if (widget.maxValue == null ||
                                _currentValue <= widget.maxValue!) {
                              setState(() {
                                widget.controller.text = (_currentValue + 1)
                                    .toString();
                                _currentValue = int.tryParse(
                                  widget.controller.text,
                                )!;
                              });
                            }
                          },
                          icon: const Icon(Icons.add),
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible:
                        _currentValue < (widget.minValue ?? 0) ||
                        (widget.maxValue != null &&
                            _currentValue > widget.maxValue!),
                    child: const SizedBox(height: 21),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
