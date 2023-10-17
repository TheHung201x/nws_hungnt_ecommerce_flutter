import 'package:ecommerce/common/app_colors.dart';
import 'package:ecommerce/common/app_text_styles.dart';
import 'package:ecommerce/ui/widget/textfields/app_email_text_field.dart';
import 'package:flutter/material.dart';

class AppUserNameTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final CheckIconValidateController checkIconController;
  final ValueChanged<String>? onChanged;
  final String? labelText;
  final String? hintText;
  final FocusNode? focusNode;
  final AutovalidateMode? autoValidateMode;
  final bool? hasCheck;

  const AppUserNameTextField({
    Key? key,
    required this.textEditingController,
    required this.checkIconController,
    this.onChanged,
    this.labelText = "Username",
    this.hintText,
    this.focusNode,
    this.autoValidateMode,
    this.hasCheck = false
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
            suffixIcon: ValueListenableBuilder(
              valueListenable: checkIconController,
              child: Container(),
              builder: (context, bool obscureText, child) {
                return hasCheck == true ? Icon(
                  obscureText
                      ? Icons.check_circle_rounded
                      : Icons.cancel,
                  color: AppColors.black,
                  size: 20,
                ) : const SizedBox.shrink();
              },
            )
        ),
        keyboardType: TextInputType.emailAddress,
        onChanged: onChanged,
        autovalidateMode: autoValidateMode ?? AutovalidateMode.onUserInteraction,
        validator: (value) {
          if (value == null || value.isEmpty) {
            checkIconController.value = false;
            return 'Please enter username';
          }
          checkIconController.value = true;
          return null;
        },
      ),
    );
  }
}
