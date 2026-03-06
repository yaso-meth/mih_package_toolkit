import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mih_package_toolkit/src/mih_colors.dart';

/// The foundational text input component for the MIH Toolkit.
///
/// [MihTextFormField] is a comprehensive wrapper around [TextFormField]
/// that integrates seamlessly with [MihColors] and the package's
/// standard layout rules.
///
/// Features:
/// * **Validation Display**: Automatically renders a thick 3.0-width red
///   border when validation fails.
/// * **Adaptive Input**: Supports [passwordMode] (obfuscation),
///   [numberMode] (numeric keyboard), and [multiLineInput].
/// * **Themed Styling**: Features an [elevation] parameter for a card-like
///   shadow and custom [borderRadius] (defaults to 8.0).
/// * **Labeling**: Includes a header row that displays the [hintText]
///   and an "(Optional)" tag based on [requiredText].
///
/// ### Example:
/// ```dart
/// MihTextFormField(
///   controller: _emailController,
///   hintText: "Email Address",
///   requiredText: true,
///   fillColor: Colors.white,
///   inputColor: Colors.black,
///   validator: (value) => value!.contains('@') ? null : "Invalid Email",
/// )
/// ```
class MihTextFormField extends StatefulWidget {
  /// The total width of the input field container.
  final double? width;

  /// /// The total height of the input field container.
  final double? height;

  /// Whether to use Dark Mode styling for validation and borders.
  final bool? darkMode;

  /// The background color of the input field.
  final Color fillColor;

  /// The color of the text entered by the user.
  final Color inputColor;

  /// The controller managing the field's text content.
  final TextEditingController controller;

  /// Manually force an error state (thick red border).
  final bool? hasError;

  /// The label displayed above the input field.
  final String? hintText;

  /// Custom corner radius for the input box. Defaults to 8.0.
  final double? borderRadius;

  /// Allows for expandable, multi-line text entry.
  final bool? multiLineInput;

  /// Prevents the user from modifying the text.
  final bool? readOnly;

  /// Obfuscates text for sensitive inputs like passwords.
  final bool? passwordMode;

  /// Optimizes the keyboard for integer/numeric input.
  final bool? numberMode;

  /// Whether the field is mandatory. Displays "(Optional)" if false.
  final bool requiredText;

  /// Standard Flutter validator for form integration.
  final FormFieldValidator<String>? validator;

  ///  Provides hints to the system for autofilling (e.g., Email, SMS code).
  final List<String>? autofillHints;

  /// Built-in elevation/shadow depth for the input box.
  final double? elevation;

  /// Controls the alignment of the text within the input (e.g., center for PINs).
  final TextAlign? textIputAlignment;

  const MihTextFormField({
    super.key,
    this.width,
    this.height,
    required this.fillColor,
    required this.inputColor,
    required this.controller,
    this.hasError,
    required this.hintText,
    required this.requiredText,
    this.borderRadius,
    this.multiLineInput,
    this.readOnly,
    this.passwordMode,
    this.numberMode,
    this.validator,
    this.autofillHints,
    this.elevation,
    this.textIputAlignment,
    this.darkMode,
  });

  @override
  State<MihTextFormField> createState() => _MihTextFormFieldState();
}

class _MihTextFormFieldState extends State<MihTextFormField> {
  late bool _obscureText;
  FormFieldState<String>? _formFieldState;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.passwordMode ?? false;
    widget.controller.addListener(_onControllerTextChanged);
  }

  @override
  void didUpdateWidget(covariant MihTextFormField oldWidget) {
    super.didUpdateWidget(oldWidget);
    // If the controller itself changes, remove listener from old and add to new
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller.removeListener(_onControllerTextChanged);
      widget.controller.addListener(_onControllerTextChanged);
      // Immediately update form field state if controller changed and has value
      _formFieldState?.didChange(widget.controller.text);
    }
  }

  void _onControllerTextChanged() {
    // Only update the FormField's value if it's not already the same
    // and if the formFieldState is available.
    if (_formFieldState != null &&
        _formFieldState!.value != widget.controller.text) {
      _formFieldState!.didChange(widget.controller.text);
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onControllerTextChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMultiline = widget.multiLineInput == true;
    return Center(
      child: SizedBox(
        width: widget.width,
        // height: widget.height,
        height: isMultiline ? null : widget.height,
        child: Theme(
          data: Theme.of(context).copyWith(
            textSelectionTheme: TextSelectionThemeData(
              selectionColor: widget.inputColor.withValues(alpha: 0.3),
              selectionHandleColor: widget.inputColor,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Visibility(
                visible: widget.hintText != null,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.hintText ?? "",
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
              ),
              const SizedBox(height: 4),
              FormField<String>(
                initialValue: widget.controller.text,
                validator: widget.validator,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                builder: (field) {
                  _formFieldState = field;
                  return Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start, // <-- Add this line
                    children: [
                      Material(
                        elevation: widget.elevation ?? 4.0,
                        borderRadius: BorderRadius.circular(
                          widget.borderRadius ?? 8.0,
                        ),
                        child: SizedBox(
                          height: widget.height != null
                              ? widget.height! - 30
                              : null,
                          child: TextFormField(
                            controller: widget.controller,
                            cursorColor: widget.inputColor,
                            autofillHints: widget.autofillHints,
                            autocorrect: true,
                            // spellCheckConfiguration: (kIsWeb ||
                            //         widget.passwordMode == true ||
                            //         widget.numberMode == true)
                            //     ? null
                            //     : SpellCheckConfiguration(),
                            spellCheckConfiguration:
                                !kIsWeb &&
                                    (Platform.isAndroid || Platform.isIOS)
                                ? SpellCheckConfiguration()
                                : null,
                            textAlign:
                                widget.textIputAlignment ?? TextAlign.start,
                            textAlignVertical: widget.multiLineInput == true
                                ? TextAlignVertical.top
                                : TextAlignVertical.center,
                            obscureText: widget.passwordMode == true
                                ? _obscureText
                                : false,
                            expands: widget.passwordMode == true
                                ? false
                                : (widget.multiLineInput ?? false),
                            maxLines: widget.passwordMode == true ? 1 : null,
                            readOnly: widget.readOnly ?? false,
                            keyboardType: widget.numberMode == true
                                ? const TextInputType.numberWithOptions(
                                    decimal: true,
                                  )
                                : null,
                            inputFormatters: widget.numberMode == true
                                ? [
                                    FilteringTextInputFormatter.allow(
                                      RegExp(r'^\d*\.?\d*'),
                                    ),
                                  ]
                                : null,
                            style: TextStyle(
                              color: widget.inputColor,
                              fontWeight: FontWeight.w500,
                            ),
                            decoration: InputDecoration(
                              suffixIcon: widget.passwordMode == true
                                  ? FocusScope(
                                      canRequestFocus: false,
                                      child: IconButton(
                                        icon: Icon(
                                          _obscureText
                                              ? Icons.visibility_off
                                              : Icons.visibility,
                                          color: widget.inputColor,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _obscureText = !_obscureText;
                                          });
                                        },
                                      ),
                                    )
                                  : null,
                              errorStyle: const TextStyle(
                                height: 0,
                                fontSize: 0,
                              ), // <-- Add this line
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 10.0,
                                vertical: 8.0,
                              ),
                              filled: true,
                              fillColor: widget.fillColor,
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
                                      : widget.inputColor,
                                  width: 3.0,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  widget.borderRadius ?? 8.0,
                                ),
                                borderSide: BorderSide(
                                  color: MihColors.red(
                                    darkMode: widget.darkMode,
                                  ),
                                  width: 3.0,
                                ),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  widget.borderRadius ?? 8.0,
                                ),
                                borderSide: BorderSide(
                                  color: MihColors.red(
                                    darkMode: widget.darkMode,
                                  ),
                                  width: 3.0,
                                ),
                              ),
                            ),
                            onChanged: (value) {
                              field.didChange(value);
                            },
                          ),
                        ),
                      ),
                      if (field.hasError)
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 8.0,
                                top: 4.0,
                              ),
                              child: Text(
                                field.errorText ?? '',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: MihColors.red(
                                    darkMode: widget.darkMode,
                                  ),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
