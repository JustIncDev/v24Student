library intl_phone_field;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './countries.dart';
import './phone_number.dart';

class IntlPhoneField extends StatefulWidget {
  final bool obscureText;
  final bool dialCodeSearch;
  final TextAlign textAlign;
  final TextAlignVertical? textAlignVertical;
  final VoidCallback? onTap;

  /// {@macro flutter.widgets.editableText.readOnly}
  final bool readOnly;
  final FormFieldSetter<PhoneNumber>? onSaved;

  /// {@macro flutter.widgets.editableText.onChanged}
  ///
  /// See also:
  ///
  ///  * [inputFormatters], which are called before [onChanged]
  ///    runs and can validate and change ("format") the input value.
  ///  * [onEditingComplete], [onSubmitted], [onSelectionChanged]:
  ///    which are more specialized input change notifications.
  final ValueChanged<PhoneNumber>? onChanged;
  final ValueChanged<PhoneNumber>? onCountryChanged;

  /// For validator to work, turn [autoValidateMode] to [AutoValidateMode.onUserInteraction]
  final FutureOr<String?> Function(String?)? validator;

  /// {@macro flutter.widgets.editableText.keyboardType}
  final TextInputType keyboardType;

  /// Controls the text being edited.
  ///
  /// If null, this widget will create its own [TextEditingController].
  final TextEditingController? controller;

  /// Defines the keyboard focus for this widget.
  ///
  /// The [focusNode] is a long-lived object that's typically managed by a
  /// [StatefulWidget] parent. See [FocusNode] for more information.
  ///
  /// To give the keyboard focus to this widget, provide a [focusNode] and then
  /// use the current [FocusScope] to request the focus:
  ///
  /// ```dart
  /// FocusScope.of(context).requestFocus(myFocusNode);
  /// ```
  ///
  /// This happens automatically when the widget is tapped.
  ///
  /// To be notified when the widget gains or loses the focus, add a listener
  /// to the [focusNode]:
  ///
  /// ```dart
  /// focusNode.addListener(() { print(myFocusNode.hasFocus); });
  /// ```
  ///
  /// If null, this widget will create its own [FocusNode].
  ///
  /// ## Keyboard
  ///
  /// Requesting the focus will typically cause the keyboard to be shown
  /// if it's not showing already.
  ///
  /// On Android, the user can hide the keyboard - without changing the focus -
  /// with the system back button. They can restore the keyboard's visibility
  /// by tapping on a text field.  The user might hide the keyboard and
  /// switch to a physical keyboard, or they might just need to get it
  /// out of the way for a moment, to expose something it's
  /// obscuring. In this case requesting the focus again will not
  /// cause the focus to change, and will not make the keyboard visible.
  ///
  /// This widget builds an [EditableText] and will ensure that the keyboard is
  /// showing when it is tapped by calling [EditableTextState.requestKeyboard()].
  final FocusNode? focusNode;

  /// {@macro flutter.widgets.editableText.onSubmitted}
  ///
  /// See also:
  ///
  ///  * [EditableText.onSubmitted] for an example of how to handle moving to
  ///    the next/previous field when using [TextInputAction.next] and
  ///    [TextInputAction.previous] for [textInputAction].
  final void Function(String)? onSubmitted;

  /// If false the widget is "disabled": it ignores taps, the [TextFormField]'s
  /// [decoration] is rendered in grey,
  /// [decoration]'s [InputDecoration.counterText] is set to `""`,
  /// and the drop down icon is hidden no matter [showDropdownIcon] value.
  ///
  /// If non-null this property overrides the [decoration]'s
  /// [Decoration.enabled] property.
  final bool enabled;

  /// The appearance of the keyboard.
  ///
  /// This setting is only honored on iOS devices.
  ///
  /// If unset, defaults to the brightness of [ThemeData.primaryColorBrightness].
  final Brightness keyboardAppearance;

  /// Initial Value for the field.
  /// This property can be used to pre-fill the field.
  final String? initialValue;

  /// 2 Letter ISO Code
  final String? initialCountryCode;

  /// List of 2 Letter ISO Codes of countries to show. Defaults to showing the inbuilt list of all countries.
  final List<String>? countries;

  /// The decoration to show around the text field.
  ///
  /// By default, draws a horizontal line under the text field but can be
  /// configured to show an icon, label, hint text, and error text.
  ///
  /// Specify null to remove the decoration entirely (including the
  /// extra padding introduced by the decoration to save space for the labels).
  final InputDecoration decoration;

  /// The style to use for the text being edited.
  ///
  /// This text style is also used as the base style for the [decoration].
  ///
  /// If null, defaults to the `subtitle1` text style from the current [Theme].
  final TextStyle? style;

  /// Disable view Min/Max Length check
  final bool disableLengthCheck;

  /// Won't work if [enabled] is set to `false`.
  final bool showDropdownIcon;

  final BoxDecoration dropdownDecoration;

  final TextStyle? dropdownTextStyle;

  /// {@macro flutter.widgets.editableText.inputFormatters}
  final List<TextInputFormatter>? inputFormatters;

  /// Placeholder Text to Display in Searchbar for searching countries
  final String searchText;

  /// Position of an icon [leading, trailing]
  final IconPosition iconPosition;

  /// Icon of the drop down button.
  ///
  /// Default is [Icon(Icons.arrow_drop_down)]
  final Widget dropDownIcon;

  /// Whether this text field should focus itself if nothing else is already focused.
  final bool autofocus;

  /// Autovalidate mode for text form field
  final AutovalidateMode? autovalidateMode;

  /// Whether to show or hide country flag.
  ///
  /// Default value is `true`.
  final bool showCountryFlag;

  /// Message to be displayed on autoValidate error
  ///
  /// Default value is `Invalid Mobile Number`.
  final String? invalidNumberMessage;
  final Color? cursorColor;

  /// The padding of the Flags Button.
  ///
  /// The amount of insets that are applied to the Flags Button.
  ///
  /// If unset, defaults to [const EdgeInsets.symmetric(vertical: 8)].
  final EdgeInsetsGeometry flagsButtonPadding;

  final TextInputAction? textInputAction;

  final TextStyle? countryNameStyle;

  final TextStyle? countryCodeStyle;

  IntlPhoneField({
    this.initialCountryCode,
    this.obscureText = false,
    this.textAlign = TextAlign.left,
    this.textAlignVertical,
    this.onTap,
    this.readOnly = false,
    this.initialValue,
    this.keyboardType = TextInputType.phone,
    this.controller,
    this.focusNode,
    this.decoration = const InputDecoration(),
    this.style,
    this.dropdownTextStyle,
    this.onSubmitted,
    this.validator,
    this.onChanged,
    this.countries,
    this.onCountryChanged,
    this.onSaved,
    this.showDropdownIcon = true,
    this.dropdownDecoration = const BoxDecoration(),
    this.inputFormatters,
    this.enabled = true,
    this.keyboardAppearance = Brightness.light,
    this.searchText = 'Search by Country Name',
    this.iconPosition = IconPosition.leading,
    this.dropDownIcon = const Icon(Icons.arrow_drop_down),
    this.autofocus = false,
    this.textInputAction,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.showCountryFlag = true,
    this.dialCodeSearch = true,
    this.cursorColor,
    this.disableLengthCheck = false,
    this.flagsButtonPadding = const EdgeInsets.symmetric(vertical: 8),
    this.invalidNumberMessage,
    this.countryNameStyle,
    this.countryCodeStyle,
  });

  @override
  _IntlPhoneFieldState createState() => _IntlPhoneFieldState();
}

class _IntlPhoneFieldState extends State<IntlPhoneField> {
  late List<Country> _countryList;
  late Country _selectedCountry;
  late List<Country> filteredCountries;
  late String number;
  late LayerLink _layerLink;
  OverlayEntry? _overlayEntry;
  bool hasChanged = false;

  final containerKey = GlobalKey();

  String? validationMessage;

  @override
  void initState() {
    super.initState();
    _countryList = widget.countries == null
        ? countries
        : countries.where((country) => widget.countries!.contains(country.code)).toList();
    filteredCountries = _countryList;
    number = widget.initialValue ?? '';
    if (widget.initialCountryCode == null && number.startsWith('+')) {
      number = number.substring(1);
      // parse initial value
      _selectedCountry = countries.firstWhere((country) => number.startsWith(country.dialCode),
          orElse: () => _countryList.first);
      number = number.substring(_selectedCountry.dialCode.length);
    } else {
      _selectedCountry = _countryList.firstWhere(
          (item) => item.code == (widget.initialCountryCode ?? 'US'),
          orElse: () => _countryList.first);
    }
    if (widget.autovalidateMode == AutovalidateMode.always) {
      var x = widget.validator?.call(widget.initialValue);
      if (x is String) {
        setState(() => validationMessage = x);
      } else {
        (x as Future).then((msg) => setState(() => validationMessage = msg));
      }
    }
    _layerLink = LayerLink();
  }

  void _showCountryList() async {
    filteredCountries = _countryList;
    var overlayState = Overlay.of(context);
    var renderBox = containerKey.currentContext?.findRenderObject() as RenderBox;

    _overlayEntry = OverlayEntry(builder: (context) {
      return Positioned(
        width: renderBox.size.width,
        height: MediaQuery.of(context).size.height * 0.25,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0.0, renderBox.size.height + 6.0),
          child: Material(
            elevation: 4.0,
            shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(
                color: const Color(0xFF9FADF0),
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: const Color(0xFF9FADF0)),
              ),
              child: Expanded(
                child: ListView.builder(
                  itemCount: filteredCountries.length,
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  itemBuilder: (ctx, index) => Column(
                    children: [
                      InkWell(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Text(
                                      '+${filteredCountries[index].dialCode}',
                                      style: widget.countryCodeStyle,
                                    ),
                                    const SizedBox(width: 10.0),
                                    Expanded(
                                      child: Text(
                                        filteredCountries[index].name,
                                        style: widget.countryNameStyle,
                                        overflow: TextOverflow.fade,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Image.asset(
                                'assets/flags/${filteredCountries[index].code.toLowerCase()}.png',
                                package: 'intl_phone_field',
                                width: 20,
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          _selectedCountry = filteredCountries[index];
                          widget.onCountryChanged?.call(
                            PhoneNumber(
                              countryISOCode: _selectedCountry.code,
                              countryCode: '+${_selectedCountry.dialCode}',
                              countryName: _selectedCountry.name,
                              number: '',
                            ),
                          );
                          _overlayEntry?.remove();
                          if (this.mounted) setState(() {});
                        },
                      ),
                      if (index != filteredCountries.length - 1) const Divider(thickness: 1),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
    overlayState?.insert(_overlayEntry!);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      key: containerKey,
      children: [
        _buildFlagsButton(),
        const SizedBox(width: 10.0),
        Expanded(
          child: TextField(
            readOnly: widget.readOnly,
            obscureText: widget.obscureText,
            textAlign: widget.textAlign,
            textAlignVertical: widget.textAlignVertical,
            cursorColor: widget.cursorColor,
            onTap: widget.onTap,
            controller: widget.controller,
            focusNode: widget.focusNode,
            decoration: widget.decoration,
            style: widget.style,
            onChanged: (value) async {
              hasChanged = true;
              final phoneNumber = PhoneNumber(
                countryISOCode: _selectedCountry.code,
                countryCode: '+${_selectedCountry.dialCode}',
                countryName: _selectedCountry.name,
                number: value,
              );
              // validate here to take care of async validation
              var msg;
              if (widget.autovalidateMode != AutovalidateMode.disabled) {
                msg = widget.disableLengthCheck ||
                        value.length >= _selectedCountry.minLength &&
                            value.length <= _selectedCountry.maxLength
                    ? null
                    : (widget.invalidNumberMessage ?? 'Invalid Mobile Number');
                msg ??= await widget.validator?.call(phoneNumber.completeNumber);
                setState(() => validationMessage = msg);
              }
              widget.onChanged?.call(phoneNumber);
            },
            maxLength: widget.disableLengthCheck ? null : _selectedCountry.maxLength,
            keyboardType: widget.keyboardType,
            inputFormatters: widget.inputFormatters,
            enabled: widget.enabled,
            keyboardAppearance: widget.keyboardAppearance,
            autofocus: widget.autofocus,
            textInputAction: widget.textInputAction,
          ),
        ),
      ],
    );
  }

  Widget _buildFlagsButton() {
    return CompositedTransformTarget(
      link: _layerLink,
      child: DecoratedBox(
        decoration: widget.dropdownDecoration,
        child: InkWell(
          borderRadius: widget.dropdownDecoration.borderRadius as BorderRadius?,
          child: Padding(
            padding: widget.flagsButtonPadding,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                if (widget.enabled &&
                    widget.showDropdownIcon &&
                    widget.iconPosition == IconPosition.leading) ...[
                  widget.dropDownIcon,
                  const SizedBox(width: 4),
                ],
                if (widget.showCountryFlag) ...[
                  Image.asset(
                    'assets/flags/${_selectedCountry.code.toLowerCase()}.png',
                    package: 'intl_phone_field',
                    width: 32,
                  ),
                ],
                FittedBox(
                  child: Text(
                    '+${_selectedCountry.dialCode}',
                    style: widget.dropdownTextStyle,
                  ),
                ),
                if (widget.enabled &&
                    widget.showDropdownIcon &&
                    widget.iconPosition == IconPosition.trailing) ...[
                  const SizedBox(width: 12),
                  widget.dropDownIcon,
                ],
              ],
            ),
          ),
          onTap: () => _showCountryList(),
        ),
      ),
    );
  }

  bool isNumeric(String s) => s.isNotEmpty && double.tryParse(s) != null;
}

enum IconPosition {
  leading,
  trailing,
}
