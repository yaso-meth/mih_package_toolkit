import 'package:flutter/material.dart';
import 'package:mih_package_toolkit/src/mih_colors.dart';

/// A specialized input field for selecting and displaying time.
///
/// [MihTimeField] provides a read-only text input that, when tapped,
/// opens the system time picker. It ensures a consistent user experience
/// by forcing a **24-hour format** and updating an external [controller].
///
/// Features:
/// * **System Picker Integration**: Wraps [showTimePicker] with a custom
///   [MediaQuery] to enforce 24-hour time regardless of device settings.
/// * **Consistent UI**: Shares the same design language as [MihTextFormField],
///   including [elevation], [borderRadius], and labeling logic.
/// * **Form Validation**: Fully compatible with [Form] widgets via the
///   [validator] property and internal [FormField] state tracking.
/// * **Visual Feedback**: Displays a thick red border and error text
///   automatically upon failed validation.
///
/// ### Example:
/// ```dart
/// MihTimeField(
///   controller: startTimeController,
///   labelText: "Shift Start",
///   required: true,
///   elevation: 2.0,
///   validator: (value) => value == null ? "Please pick a time" : null,
/// )
/// ```
class MihTimeField extends StatefulWidget {
  /// The primary color of the date picker
  final Color? primaryColor;

  /// The secondary color of the date picker
  final Color? secondayColor;

  /// The controller that stores and displays the selected time string (HH:mm).
  final TextEditingController controller;

  /// The label displayed above the time input.
  final String labelText;

  /// Whether the field is mandatory. Displays "(Optional)" if false.
  final bool required;

  /// The width of the input field container.
  final double? width;

  /// The height of the input field container.
  final double? height;

  /// The corner radius of the input field. Defaults to 8.0.
  final double? borderRadius;

  /// The shadow depth for the input box.
  final double? elevation;

  /// Whether to use Dark Mode styling for borders and error text.
  final bool? darkMode;

  /// Standard Flutter validator for form integration.
  final FormFieldValidator<String>? validator;

  const MihTimeField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.required,
    this.primaryColor,
    this.secondayColor,
    this.width,
    this.height,
    this.borderRadius,
    this.elevation,
    this.darkMode,
    this.validator,
  });

  @override
  State<MihTimeField> createState() => _MihTimeFieldState();
}

class _MihTimeFieldState extends State<MihTimeField> {
  FormFieldState<String>? _formFieldState;

  Future<void> _selectTime(BuildContext context) async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: widget.controller.text.isNotEmpty
          ? TimeOfDay(
              hour: int.tryParse(widget.controller.text.split(":")[0]) ?? 0,
              minute: int.tryParse(widget.controller.text.split(":")[1]) ?? 0,
            )
          : TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.fromSeed(
              seedColor: widget.primaryColor ??
                  MihColors.primary(darkMode: widget.darkMode),
              primary: widget.secondayColor ??
                  MihColors.secondary(darkMode: widget.darkMode),
              onPrimary: widget.primaryColor ??
                  MihColors.primary(darkMode: widget.darkMode),
              surface: widget.secondayColor ??
                  MihColors.secondary(darkMode: widget.darkMode),
              onSurface: widget.primaryColor ??
                  MihColors.primary(darkMode: widget.darkMode),
            ),
            timePickerTheme: TimePickerThemeData(
              // The main dialog background
              backgroundColor: widget.primaryColor ??
                  MihColors.primary(darkMode: widget.darkMode),
              // The background of the clock dial
              dialBackgroundColor: widget.secondayColor ??
                  MihColors.secondary(darkMode: widget.darkMode),
              // The color of the clock hand
              dialHandColor: widget.primaryColor ??
                  MihColors.primary(darkMode: widget.darkMode),
              // The background color of the hour/minute input boxes
              hourMinuteColor: widget.secondayColor ??
                  MihColors.secondary(darkMode: widget.darkMode),
              // The text color inside the hour/minute input boxes
              hourMinuteTextColor: widget.primaryColor ??
                  MihColors.primary(darkMode: widget.darkMode),
              // The color of the keyboard/clock toggle icon
              entryModeIconColor: widget.secondayColor ??
                  MihColors.secondary(darkMode: widget.darkMode),
              // Styles for AM/PM toggle (if not using 24h format)
              dayPeriodColor: widget.secondayColor ??
                  MihColors.secondary(darkMode: widget.darkMode),
              dayPeriodTextColor: widget.primaryColor ??
                  MihColors.primary(darkMode: widget.darkMode),
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: widget.secondayColor ??
                    MihColors.secondary(darkMode: widget.darkMode),
              ),
            ),
          ),
          // Wrap your MediaQuery inside the child of the Theme
          child: MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child!,
          ),
        );
      },
    );
    if (picked != null) {
      final hours = picked.hour.toString().padLeft(2, '0');
      final minutes = picked.minute.toString().padLeft(2, '0');
      widget.controller.text = "$hours:$minutes";
      _formFieldState?.didChange(widget.controller.text);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: widget.width,
        height: widget.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.labelText,
                  style: TextStyle(
                    color: MihColors.secondary(darkMode: widget.darkMode),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (!widget.required)
                  Text(
                    "(Optional)",
                    style: TextStyle(
                      color: MihColors.secondary(darkMode: widget.darkMode),
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 4),
            FormField<String>(
              initialValue: widget.controller.text,
              validator: widget.validator,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              builder: (field) {
                _formFieldState = field;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Material(
                      elevation: widget.elevation ?? 4.0,
                      borderRadius: BorderRadius.circular(
                        widget.borderRadius ?? 8.0,
                      ),
                      child: TextFormField(
                        controller: widget.controller,
                        readOnly: true,
                        onTap: () => _selectTime(context),
                        style: TextStyle(
                          color: MihColors.primary(darkMode: widget.darkMode),
                          fontWeight: FontWeight.w500,
                        ),
                        decoration: InputDecoration(
                          suffixIcon: Icon(
                            Icons.access_time,
                            color: MihColors.primary(darkMode: widget.darkMode),
                          ),
                          errorStyle: const TextStyle(height: 0, fontSize: 0),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10.0,
                            vertical: 8.0,
                          ),
                          filled: true,
                          fillColor: MihColors.secondary(
                            darkMode: widget.darkMode,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              widget.borderRadius ?? 8.0,
                            ),
                            borderSide: field.hasError
                                ? BorderSide(
                                    color: MihColors.red(
                                      darkMode: widget.darkMode,
                                    ),
                                    width: 2.0,
                                  )
                                : BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              widget.borderRadius ?? 8.0,
                            ),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              widget.borderRadius ?? 8.0,
                            ),
                            borderSide: BorderSide(
                              color: field.hasError
                                  ? MihColors.red(darkMode: widget.darkMode)
                                  : MihColors.secondary(
                                      darkMode: widget.darkMode,
                                    ),
                              width: 3.0,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              widget.borderRadius ?? 8.0,
                            ),
                            borderSide: BorderSide(
                              color: MihColors.red(darkMode: widget.darkMode),
                              width: 3.0,
                            ),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              widget.borderRadius ?? 8.0,
                            ),
                            borderSide: BorderSide(
                              color: MihColors.red(darkMode: widget.darkMode),
                              width: 3.0,
                            ),
                          ),
                        ),
                        onChanged: (value) {
                          field.didChange(value);
                        },
                      ),
                    ),
                    if (field.hasError)
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, top: 4.0),
                        child: Text(
                          field.errorText ?? '',
                          style: TextStyle(
                            fontSize: 12,
                            color: MihColors.red(darkMode: widget.darkMode),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
