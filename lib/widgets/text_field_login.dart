import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/dimens.dart';

class TextFieldLogin extends StatelessWidget {
  final FocusNode focusNode;
  final TextEditingController controller;
  final String label;
  final TextInputAction textInputAction;
  final String hintText;
  final void Function(String)? onFieldSubmitted;
  final String icon;
  final bool isPassword;
  final bool obscureText;
  final void Function()? togglePassword;

  const TextFieldLogin({
    super.key, 
    required this.focusNode, 
    required this.controller, 
    required this.label, 
    required this.textInputAction, 
    required this.hintText, 
    this.onFieldSubmitted,
    this.icon = 'assets/images/icon/ic_username.png', 
    this.isPassword = false,
    this.obscureText = false,
    this.togglePassword
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!focusNode.hasFocus) {
          FocusScope.of(context).requestFocus(focusNode);
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppDimen.marginPaddingLarge),
        child: Container(
          padding: const EdgeInsets.all(AppDimen.marginPaddingMedium), 
          decoration: BoxDecoration(
            color: AppColor.lightGrey, 
            borderRadius: BorderRadius.circular(AppDimen.radiusLarge)
          ),
          child: Row(
            children: [
              Image.asset(
                icon, 
                width: 27,
              ),
      
              const SizedBox(width: 16), 
      
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, 
                  children: [
                    Text(
                      label,
                      style: const TextStyle(
                        color: AppColor.lightGrey3,
                        fontSize: 12
                      ),
                    ),
                    
                    const SizedBox(height: 8), 
                    
                    TextFormField(
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13
                      ),
                      onFieldSubmitted: onFieldSubmitted,
                      controller: controller,
                      textInputAction: textInputAction,
                      focusNode: focusNode,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                        hintText: hintText,
                        hintStyle: const TextStyle(
                          fontSize: 13
                        ),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                      ),
                      obscureText: obscureText,
                    ),
                  ],
                ),
              ),

              if (isPassword)
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: obscureText
                      ? const Icon(Icons.visibility_off, color: AppColor.grey, size: 20,)
                      : const Icon(Icons.visibility, color: AppColor.black2, size: 20),
                    onPressed: togglePassword
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}