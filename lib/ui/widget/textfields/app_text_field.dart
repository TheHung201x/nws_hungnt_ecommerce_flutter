import 'package:ecommerce/common/app_colors.dart';
import 'package:ecommerce/common/app_text_styles.dart';
import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final ValueChanged<String>? onChanged;
  final String? labelText;
  final String? hintText;
  final FocusNode? focusNode;
  final AutovalidateMode? autoValidateMode;

  const AppTextField({
    Key? key,
    required this.textEditingController,
    this.onChanged,
    this.labelText = "",
    this.hintText,
    this.focusNode,
    this.autoValidateMode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220,
      child: TextFormField(
        readOnly: true,
        controller: textEditingController,
        focusNode: focusNode,
        style: AppTextStyle.blackS14,
        decoration: InputDecoration(
            hintText: hintText,
            labelStyle: AppTextStyle.blackS16Bold,
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.border),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.border),
            ),
            contentPadding: const EdgeInsets.only(bottom: 4, left: 14),
          isDense: true,
        ),
        keyboardType: TextInputType.emailAddress,
        onChanged: onChanged,
        autovalidateMode: autoValidateMode ?? AutovalidateMode.onUserInteraction,
        // validator: (value) {
        //   if (value == null || value.isEmpty) {
        //     return 'Please enter username';
        //   }
        //   return null;
        // },
      ),
    );
  }
}
