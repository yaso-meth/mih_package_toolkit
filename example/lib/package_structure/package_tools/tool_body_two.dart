import 'package:flutter/material.dart';
import 'package:mih_package_toolkit/mih_package_toolkit.dart';

class ToolBodyTwo extends StatefulWidget {
  const ToolBodyTwo({super.key});

  @override
  State<ToolBodyTwo> createState() => _ToolBodyTwoState();
}

class _ToolBodyTwoState extends State<ToolBodyTwo> {
  final _formKey = GlobalKey<FormState>();
  final FocusNode searchFocusNode = FocusNode();
  final _searchController = TextEditingController();
  final _textController = TextEditingController();
  final _dropdownController = TextEditingController();
  final _numericStepperController = TextEditingController();
  final _radioController = TextEditingController();
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MihPackageToolBody(
      backgroundColor: MihColors.primary(),
      bodyItem: MihSingleChildScroll(
        child: MihForm(
          formKey: _formKey,
          formFields: [
            Text(
              "This tool body is to showcase mih iput fields with validation",
              style: TextStyle(fontSize: 24, color: MihColors.secondary()),
            ),
            SizedBox(height: 20),
            MihSearchBar(
              width: 300,
              controller: _searchController,
              hintText: "Search...",
              prefixIcon: Icons.search,
              fillColor: MihColors.secondary(),
              hintColor: MihColors.primary(),
              onPrefixIconTap: () {
                debugPrint(
                  "Search initiated with query: ${_searchController.text}",
                );
              },
              searchFocusNode: searchFocusNode,
            ),
            SizedBox(height: 20),
            MihTextFormField(
              fillColor: MihColors.secondary(),
              inputColor: MihColors.primary(),
              width: 300,
              controller: _textController,
              hintText: "Text Input",
              requiredText: true,
            ),
            const SizedBox(height: 20),
            MihDropdownField(
              width: 300,
              controller: _dropdownController,
              hintText: "Dropdown Input",
              dropdownOptions: [
                "Option 1",
                "Option 2",
                "Option 3",
                "Option 4",
                "Option 5",
                "Option 6",
              ],
              requiredText: true,
              editable: true,
              enableSearch: true,
            ),
            const SizedBox(height: 20),
            MihNumericStepper(
              width: 300,
              controller: _numericStepperController,
              fillColor: MihColors.secondary(),
              inputColor: MihColors.primary(),
              hintText: "Numeric Stepper",
              requiredText: true,
              validationOn: true,
            ),
            const SizedBox(height: 20),
            MihRadioOptions(
              width: 300,
              controller: _radioController,
              hintText: "Radio Options",
              fillColor: MihColors.secondary(),
              secondaryFillColor: MihColors.primary(),
              requiredText: true,
              radioOptions: ["Option 1", "Option 2", "Option 3"],
            ),
            const SizedBox(height: 20),
            MihToggle(
              width: 300,
              hintText: "Toggle",
              initialPostion: false,
              fillColor: MihColors.secondary(),
              secondaryFillColor: MihColors.primary(),
              onChange: (value) {
                debugPrint("Toggle changed: $value");
              },
            ),
            const SizedBox(height: 20),
            MihDateField(
              width: 300,
              controller: _dateController,
              labelText: "Date Field",
              required: true,
            ),
            const SizedBox(height: 20),
            MihTimeField(
              width: 300,
              controller: _timeController,
              labelText: "Time Field",
              required: true,
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
