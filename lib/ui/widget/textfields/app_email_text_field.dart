import 'package:ecommerce/common/app_colors.dart';
import 'package:ecommerce/common/app_text_styles.dart';
import 'package:ecommerce/utils/utils.dart';
import 'package:flutter/material.dart';

class AppEmailTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final ValueChanged<String>? onChanged;
  final String? labelText;
  final String? hintText;
  final FocusNode? focusNode;
  final AutovalidateMode? autoValidateMode;

  const AppEmailTextField({
    Key? key,
    required this.textEditingController,
    this.onChanged,
    this.labelText = "Email",
    this.hintText,
    this.focusNode,
    this.autoValidateMode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextFormField(
        controller: textEditingController,
        focusNode: focusNode,
        style: AppTextStyle.blackS14,
        decoration: InputDecoration(
          label: Text(labelText!),
          labelStyle: AppTextStyle.blackS16Bold,
          hintText: hintText,
          hintStyle: AppTextStyle.greyS12,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.border),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.border),
          ),
          contentPadding: EdgeInsets.zero,
        ),
        keyboardType: TextInputType.emailAddress,
        onChanged: onChanged,
        autovalidateMode: autoValidateMode ?? AutovalidateMode.onUserInteraction,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter email';
          }
          if (!Utils.isEmail(value)) {
            return "Email invalid";
          }
          return null;
        },
      ),
    );
  }
}
