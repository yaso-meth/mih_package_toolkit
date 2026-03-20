import 'package:flutter/material.dart';
import 'package:mih_package_toolkit/src/mih_colors.dart';

/// A customized date selection field that integrates with [showDatePicker].
///
/// The [MihDateField] provides a stylized wrapper around a read-only [TextFormField].
/// When tapped, it opens the system date picker and formats the result into
/// the provided [controller].
///
/// It features:
/// * Built-in validation support via [validator].
/// * Automatic labeling with an optional "(Optional)" suffix.
/// * Theme-aware styling that syncs with [MihColors].
/// * Custom elevation and border radius.
class MihDateField extends StatefulWidget {
  /// The primary color of the date picker
  final Color? primaryColor;

  /// The secondary color of the date picker
  final Color? secondayColor;

  /// The controller that handles the text being edited.
  ///
  /// The date will be stored in `YYYY-MM-DD` format.
  final TextEditingController controller;

  /// The text to display above the input field.
  final String labelText;

  /// Whether this field is mandatory.
  ///
  /// If `false`, a "(Optional)" tag will be displayed next to the [labelText].
  final bool required;

  /// The width of the entire widget.
  final double? width;

  /// The height of the entire widget.
  final double? height;

  /// The radius of the input field corners. Defaults to 8.0.
  final double? borderRadius;

  /// The elevation of the input field material. Defaults to 4.0.
  final double? elevation;

  /// Whether to use Dark Mode styling. If null, [MihColors] defaults to dark.
  final bool? darkMode;

  /// An optional method that validates an input.
  ///
  /// Returns an error string to display if the input is invalid, or null otherwise.
  final FormFieldValidator<String>? validator;
  const MihDateField({
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
  State<MihDateField> createState() => _MihDateFieldState();
}

class _MihDateFieldState extends State<MihDateField> {
  /// Used to manually trigger state changes for the internal [FormField]
  /// when the date picker updates the [TextEditingController].
  FormFieldState<String>? _formFieldState;

  /// Internal method to trigger the Material [showDatePicker].
  ///
  /// It attempts to parse the current text in the controller to set the
  /// [initialDate], defaulting to [DateTime.now] if empty or invalid.
  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: widget.controller.text.isNotEmpty
          ? DateTime.tryParse(widget.controller.text) ?? DateTime.now()
          : DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2200),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.fromSeed(
              seedColor: widget.primaryColor ?? MihColors.primary(),
              primary: widget.secondayColor ??
                  MihColors.secondary(), // Header & Selected Day
              onPrimary: widget.primaryColor ??
                  MihColors.primary(), // Text on top of primary
              surface:
                  widget.secondayColor ?? MihColors.secondary(), // Background
              onSurface:
                  widget.secondayColor ?? MihColors.secondary(), // Text/Dates
            ),
            datePickerTheme: DatePickerThemeData(
              backgroundColor: widget.primaryColor ?? MihColors.primary(),
              headerBackgroundColor:
                  widget.secondayColor ?? MihColors.secondary(),
              headerForegroundColor: widget.primaryColor ?? MihColors.primary(),
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: widget.secondayColor ??
                    MihColors.secondary(), // Action buttons (OK/Cancel)
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      widget.controller.text = picked.toString().split(" ")[0];
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
                        onTap: () => _selectDate(context),
                        style: TextStyle(
                          color: MihColors.primary(darkMode: widget.darkMode),
                          fontWeight: FontWeight.w500,
                        ),
                        decoration: InputDecoration(
                          suffixIcon: Icon(
                            Icons.calendar_today,
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
