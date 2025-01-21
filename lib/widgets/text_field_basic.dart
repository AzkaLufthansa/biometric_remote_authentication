import 'package:flutter/material.dart';

import '../utils/colors.dart';

class TextFieldBasic extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final String hintText;
  final bool autoFocus;
  final TextInputAction? inputAction;
  final Function(String)? onFieldSubmitted;
  final bool required;
  final String? Function(String)? validator;
  final bool enabled;
  final bool obscureText;
  final TextInputType? keyboardType;
  
  const TextFieldBasic({
    super.key, 
    required this.controller, 
    required this.focusNode, 
    required this.hintText,
    this.autoFocus = true,
    this.inputAction,
    this.onFieldSubmitted,
    this.required = true,
    this.validator,
    this.enabled = true,
    this.obscureText = false,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      autofocus: autoFocus,
      style: const TextStyle(
        fontSize: 13,
      ),
      onFieldSubmitted: onFieldSubmitted,
      textInputAction: inputAction,
      enabled: enabled,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        isDense: true,
        hintText: hintText,
        hintStyle: const TextStyle(
          fontSize: 13,
          color: AppColor.lightGrey3
        ),
      ),
      validator: (value) {
        if (value != null) {
          // Required Validator
          if (required) {
            if (value.isEmpty) {
              return 'Harap isi bidang ini';
            }
          }

          // Custom Validator From Callback
          if (validator != null) {
            return validator!(value);
          }
        }

        return null;
      },
    );
  }
}