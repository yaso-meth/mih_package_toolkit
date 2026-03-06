import 'package:flutter/material.dart';

/// A layout wrapper that standardizes the appearance and behavior of form fields.
///
/// The [MihForm] simplifies form creation by wrapping a list of [formFields]
/// in a [Form] widget and a centered [Column]. It is designed to work
/// seamlessly with other components in this toolkit like [MihTextField],
/// [MihDateField], and [MihDropdownField].
///
/// ### Example:
/// ```dart
/// final _formKey = GlobalKey<FormState>();
///
/// MihForm(
///   formKey: _formKey,
///   formFields: [
///     MihTextField(labelText: 'Name', ...),
///     MihButton(
///       child: Text('Submit'),
///       onPressed: () {
///         if (_formKey.currentState!.validate()) {
///           // Process data
///         }
///       },
///     ),
///   ],
/// )
/// ```
class MihForm extends StatefulWidget {
  /// The key used to identify and validate the internal [Form].
  ///
  /// Use this key to trigger `validate()`, `save()`, or `reset()`
  /// on the entire collection of fields.
  final GlobalKey<FormState> formKey;

  /// The list of widgets (typically MIH input fields) to display inside the form.
  ///
  /// These are arranged vertically in a [Column] with center cross-axis alignment.
  final List<Widget> formFields;
  const MihForm({super.key, required this.formKey, required this.formFields});

  @override
  State<MihForm> createState() => _MihFormState();
}

class _MihFormState extends State<MihForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: widget.formFields,
      ),
    );
  }
}
