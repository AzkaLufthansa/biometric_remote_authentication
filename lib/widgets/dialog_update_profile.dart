import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/dimens.dart';
import 'text_field_basic.dart';

class DialogConfirmPassword extends StatelessWidget {
  final VoidCallback onSubmit;
  final GlobalKey<FormState> formKey;
  final bool isLoading;
  final TextEditingController controller;
  final FocusNode focusNode;
  
  const DialogConfirmPassword({
    super.key, 
    required this.onSubmit,
    required this.formKey,
    this.isLoading = false,
    required this.controller,
    required this.focusNode
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimen.radiusMedium),
      ),
      elevation: 0,
      backgroundColor: Colors.black54,
      child: _content(context),
    );
  }

  Widget _content(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              'Masukkan password Anda',
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          const SizedBox(height: AppDimen.marginPaddingMedium),

          // Content / Textfields
          Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Masukkan password Anda untuk melanjutkan!',
                  style: TextStyle(
                    fontSize: 11,
                    color: AppColor.lightGrey3
                  ),
                ),
                const SizedBox(height: AppDimen.marginPaddingMedium,),
                TextFieldBasic(
                  controller: controller,
                  focusNode: focusNode,
                  hintText: 'Password',
                  inputAction: TextInputAction.next,
                  required: true,
                  enabled: true,
                  obscureText: true,
                  // validator: (value) {
                  //   if (value.length < 6) {
                  //     return 'Password minimal harus 6 karakter';
                  //   }
                  //   return null;
                  // },
                ),
              ],
            ),
          ),

          const SizedBox(height: AppDimen.marginPaddingMedium),
          Row(
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(right: 4),
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: const BorderSide(color: AppColor.primary),
                      foregroundColor: AppColor.primary,
                    ),
                    child: const Text(
                      'Batal',
                      style: TextStyle(
                        color: AppColor.primary,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 4),
                  child: ElevatedButton(
                    onPressed: !isLoading ? onSubmit : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.primary,
                      foregroundColor: AppColor.white,
                    ),
                    child: const Text(
                      'Submit',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}