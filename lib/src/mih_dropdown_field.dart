import 'package:flutter/material.dart';
import 'package:mih_package_toolkit/src/mih_colors.dart';

/// A robust, searchable dropdown menu component for the MIH Toolkit.
///
/// The [MihDropdownField] wraps the Material 3 [DropdownMenu] to provide
/// enhanced functionality including:
/// * **Search & Filter**: Enabled via [enableSearch].
/// * **Clear Action**: A built-in trash icon to quickly reset the field.
/// * **Validation**: Full integration with Flutter's [Form] validation.
/// * **Dynamic Labeling**: Displays a label and an automatic "(Optional)" tag.
/// * **Custom Theming**: Deeply integrated with [MihColors] for consistent UI.
class MihDropdownField extends StatefulWidget {
  /// The total width of the dropdown and its accompanying clear icon.
  final double? width;

  /// The controller that manages the currently selected text.
  final TextEditingController controller;

  /// The label text displayed above the dropdown field.
  final String hintText;

  /// Whether this field is required.
  ///
  /// If `false`, displays "(Optional)" next to the [hintText].
  final bool requiredText;

  /// The list of string options to display in the dropdown menu.
  final List<String> dropdownOptions;

  /// Whether the field is enabled for user interaction.
  final bool editable;

  /// Whether to enable the search bar and filtering within the dropdown.
  final bool enableSearch;

  /// Whether to use Dark Mode styling. Defaults to [MihColors] dark variant if null.
  final bool? darkMode;

  /// An optional method that validates the selection.
  final FormFieldValidator<String>? validator;

  /// Called when a value is selected from the menu.
  final Function(String?)? onSelected;

  const MihDropdownField({
    super.key,
    this.width,
    required this.controller,
    required this.hintText,
    required this.dropdownOptions,
    required this.requiredText,
    required this.editable,
    required this.enableSearch,
    this.darkMode,
    this.validator,
    this.onSelected,
  });

  @override
  State<MihDropdownField> createState() => _MihDropdownFieldState();
}

class _MihDropdownFieldState extends State<MihDropdownField> {
  /// The internal list of entries generated from [widget.dropdownOptions].
  late List<DropdownMenuEntry<String>> menu;

  /// Maps the string options into [DropdownMenuEntry] objects
  /// with themed text styles.
  List<DropdownMenuEntry<String>> buildMenuOptions(List<String> options) {
    List<DropdownMenuEntry<String>> menuList = [];
    for (final i in options) {
      menuList.add(
        DropdownMenuEntry(
          value: i,
          label: i,
          style: ButtonStyle(
            foregroundColor: WidgetStatePropertyAll(
              MihColors.primary(darkMode: widget.darkMode),
            ),
          ),
        ),
      );
    }
    return menuList;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    menu = buildMenuOptions(widget.dropdownOptions);
  }

  @override
  void initState() {
    super.initState();
    menu = widget.dropdownOptions
        .map((e) => DropdownMenuEntry(value: e, label: e))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.hintText,
                style: TextStyle(
                  color: MihColors.secondary(darkMode: widget.darkMode),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (!widget.requiredText)
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
            validator: widget.validator,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            initialValue: widget.controller.text,
            builder: (field) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Theme(
                          data: Theme.of(context).copyWith(
                            scrollbarTheme: ScrollbarThemeData(
                              thumbColor: WidgetStatePropertyAll(
                                MihColors.primary(darkMode: widget.darkMode),
                              ),
                              thickness: const WidgetStatePropertyAll(6),
                              radius: const Radius.circular(10),
                              thumbVisibility: const WidgetStatePropertyAll(
                                true,
                              ), // Always show when scrolling
                            ),
                            textSelectionTheme: TextSelectionThemeData(
                              cursorColor: MihColors.primary(
                                darkMode: widget.darkMode,
                              ),
                              selectionColor: MihColors.primary(
                                darkMode: widget.darkMode,
                              ).withValues(alpha: 0.3),
                              selectionHandleColor: MihColors.primary(
                                darkMode: widget.darkMode,
                              ),
                            ),
                          ),
                          child: DropdownMenu(
                            controller: widget.controller,
                            dropdownMenuEntries: menu,
                            enableSearch: widget.enableSearch,
                            enableFilter: widget.enableSearch,
                            enabled: widget.editable,
                            textInputAction: widget.enableSearch
                                ? TextInputAction.search
                                : TextInputAction.none,
                            requestFocusOnTap: widget.enableSearch,
                            menuHeight: 400,
                            expandedInsets: EdgeInsets.zero,
                            textStyle: TextStyle(
                              color: MihColors.primary(
                                darkMode: widget.darkMode,
                              ),
                              fontWeight: FontWeight.w500,
                            ),
                            trailingIcon: Icon(
                              Icons.arrow_drop_down,
                              color: MihColors.primary(
                                darkMode: widget.darkMode,
                              ),
                            ),
                            selectedTrailingIcon: Icon(
                              Icons.arrow_drop_up,
                              color: MihColors.primary(
                                darkMode: widget.darkMode,
                              ),
                            ),
                            // leadingIcon:
                            // IconButton(
                            //   onPressed: () {
                            //     widget.controller.clear();
                            //     field.didChange('');
                            //   },
                            //   icon: Icon(
                            //     Icons.delete_outline_rounded,
                            //     color: MihColors.primary(
                            //         MzansiInnovationHub.of(context)!.theme.mode ==
                            //             "Dark"),
                            //   ),
                            // ),
                            onSelected: (String? selectedValue) {
                              field.didChange(selectedValue);
                              widget.onSelected?.call(selectedValue);
                            },
                            menuStyle: MenuStyle(
                              backgroundColor: WidgetStatePropertyAll(
                                MihColors.secondary(darkMode: widget.darkMode),
                              ),
                              side: WidgetStatePropertyAll(
                                BorderSide(
                                  color: MihColors.primary(
                                    darkMode: widget.darkMode,
                                  ),
                                  width: 1.0,
                                ),
                              ),
                              shape: WidgetStatePropertyAll(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    10,
                                  ), // Increase for more roundness
                                ),
                              ),
                            ),
                            inputDecorationTheme: InputDecorationTheme(
                              errorStyle: const TextStyle(
                                height: 0,
                                fontSize: 0,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 10.0,
                                vertical: 8.0,
                              ),
                              filled: true,
                              fillColor: MihColors.secondary(
                                darkMode: widget.darkMode,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
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
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide(
                                  color: MihColors.red(
                                    darkMode: widget.darkMode,
                                  ),
                                  width: 3.0,
                                ),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide(
                                  color: MihColors.red(
                                    darkMode: widget.darkMode,
                                  ),
                                  width: 3.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () {
                          widget.controller.clear();
                          field.didChange('');
                        },
                        child: Icon(
                          size: 35,
                          Icons.delete_rounded,
                          color: MihColors.red(darkMode: widget.darkMode),
                        ),
                      ),
                    ],
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
    );
  }
}
