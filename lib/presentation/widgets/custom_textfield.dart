import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onco_connect/common/constants/layout_constant.dart';
import 'package:onco_connect/common/utils/country_info_utils.dart';
import 'package:onco_connect/presentation/theme/color_theme/custom_color_theme.dart';
import 'package:onco_connect/presentation/theme/text_theme/custom_text_theme.dart';
import 'package:onco_connect/presentation/widgets/spacers.dart';

enum InputType {
  name,
  email,
  password,
  phone,
}

class CustomTextField extends StatefulWidget {
  final String hintText;
  final InputType? inputType;
  final String? Function(String?)? validator;
  final List<CountryInfo>? countryInfoList;
  final CountryInfo? selectedCountryInfo;
  final ValueChanged<String>? onChanged;

  CustomTextField({
    super.key,
    required this.hintText,
    this.inputType,
    this.validator,
    CountryCode? selectedCountryCode,
    this.onChanged,
  })  : countryInfoList = (inputType == InputType.phone)
            ? CountryInfoUtils.countryInfoList
            : null,
        selectedCountryInfo = (inputType == InputType.phone)
            ? (selectedCountryCode != null)
                ? CountryInfoUtils.fromCountryCode(selectedCountryCode)
                : CountryInfoUtils.fromCountryCode(CountryCode.ind)
            : null;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late TextEditingController controller;
  CountryInfo? _selectedCountryInfo;

  @override
  void initState() {
    controller = TextEditingController();
    _selectedCountryInfo = widget.selectedCountryInfo;
    super.initState();
  }

  void _onChanged(String text) {
    if (widget.onChanged != null) {
      if (_selectedCountryInfo != null) {
        widget.onChanged!.call("${_selectedCountryInfo!.phoneCode} $text");
      } else {
        widget.onChanged!.call(text);
      }
    }
  }

  void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(LayoutConstants.dimen_16),
            ),
            title: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Select Country Code',
                  style: Theme.of(context).extension<CustomTextTheme>()!.bodyLb,
                ),
                const RVSpacer()
              ],
            ),
            insetPadding: const EdgeInsets.symmetric(
                horizontal: LayoutConstants.dimen_32,
                vertical: LayoutConstants.dimen_32),
            contentPadding:
                const EdgeInsetsDirectional.all(LayoutConstants.dimen_0),
            content: SingleChildScrollView(
              child: Column(
                children: widget.countryInfoList!.map((info) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        _selectedCountryInfo = info;
                      });
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: Get.width,
                      padding: const EdgeInsets.symmetric(
                        horizontal: LayoutConstants.dimen_14,
                        vertical: LayoutConstants.dimen_14,
                      ),
                      child: Row(
                        children: [
                          Text(info.country,
                              style: Theme.of(context)
                                  .extension<CustomTextTheme>()!
                                  .bodyMr),
                          const Spacer(),
                          Text(info.phoneCode,
                              style: Theme.of(context)
                                  .extension<CustomTextTheme>()!
                                  .bodyLr),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _textFieldDecoration(
        context,
        showBorder: true,
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (widget.inputType == InputType.phone) ...[
              InkWell(
                onTap: () {
                  show(context);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: LayoutConstants.dimen_16,
                    vertical: LayoutConstants.dimen_4,
                  ),
                  decoration: _textFieldDecoration(context,
                      showBorder: false,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(LayoutConstants.dimen_8),
                        bottomLeft: Radius.circular(
                          LayoutConstants.dimen_8,
                        ),
                      ),
                      color: Theme.of(context)
                          .extension<CustomColorTheme>()!
                          .primaryLight),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        _selectedCountryInfo!.phoneCode,
                        style: Theme.of(context)
                            .extension<CustomTextTheme>()!
                            .bodyMr!
                            .copyWith(
                              color: Theme.of(context)
                                  .extension<CustomColorTheme>()!
                                  .primaryColor,
                            ),
                      ),
                      Icon(
                        Icons.arrow_drop_down,
                        color: Theme.of(context)
                            .extension<CustomColorTheme>()!
                            .primaryColor,
                      ),
                    ],
                  ),
                ),
              )
            ],
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: LayoutConstants.dimen_16,
                  vertical: LayoutConstants.dimen_4,
                ),
                child: TextFormField(
                  controller: controller,
                  onChanged: _onChanged,
                  keyboardType: _getKeyboardType(),
                  obscureText: widget.inputType == InputType.password,
                  validator: _getValidator(),
                  textInputAction: TextInputAction.done,
                  autocorrect: false,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  cursorColor: Theme.of(context)
                      .extension<CustomColorTheme>()!
                      .cursorColor,
                  decoration: InputDecoration(
                    filled: false,
                    hintText: widget.hintText,
                    hintStyle: Theme.of(context)
                        .extension<CustomTextTheme>()!
                        .bodyMrHint,
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ShapeDecoration _textFieldDecoration(
    BuildContext context, {
    required bool showBorder,
    BorderRadius? borderRadius,
    Color? color,
  }) {
    return ShapeDecoration(
      color: color,
      shape: RoundedRectangleBorder(
        side: showBorder
            ? BorderSide(
                color: Theme.of(context)
                    .extension<CustomColorTheme>()!
                    .auxiliaryColor!,
              )
            : BorderSide.none,
        borderRadius:
            borderRadius ?? BorderRadius.circular(LayoutConstants.dimen_8),
      ),
    );
  }

  TextInputType _getKeyboardType() {
    switch (widget.inputType) {
      case InputType.name:
        return TextInputType.text;
      case InputType.email:
        return TextInputType.emailAddress;
      case InputType.password:
        return TextInputType.visiblePassword;
      case InputType.phone:
        return TextInputType.phone;
      default:
        return TextInputType.name;
    }
  }

  String? Function(String?)? _getValidator() {
    switch (widget.inputType) {
      case InputType.name:
        return (value) {
          if (value!.isEmpty) {
            return 'Please enter your name';
          }
          return null;
        };
      case InputType.email:
        return (value) {
          if (value!.isEmpty) {
            return 'Please enter your email';
          } else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$')
              .hasMatch(value)) {
            return 'Please enter a valid email address';
          }
          return null;
        };
      case InputType.password:
        return (value) {
          if (value!.isEmpty) {
            return 'Please enter your password';
          }
          return null;
        };
      case InputType.phone:
        return (value) {
          if (value!.isEmpty) {
            return 'Please enter your phone number';
          }
          // TODO: more validation
          return null;
        };
      default:
        return null;
    }
  }
}
