import 'package:ecommerce/common/app_colors.dart';
import 'package:ecommerce/common/app_text_styles.dart';
import 'package:ecommerce/utils/utils.dart';
import 'package:flutter/material.dart';

class ObscureTextController extends ValueNotifier<bool> {
  ObscureTextController({bool obscureText = true}) : super(obscureText);

  bool get date => value;

  set date(bool obscureText) {
    value = obscureText;
  }
}

class AppPasswordTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final ObscureTextController obscureTextController;
  final ValueChanged<String>? onChanged;
  final String? labelText;
  final String? hintText;
  final FocusNode? focusNode;
  final AutovalidateMode? autoValidateMode;
  final bool? hasObscure;

  const AppPasswordTextField(
      {Key? key,
      required this.textEditingController,
      required this.obscureTextController,
      this.onChanged,
      this.labelText = "Password",
      this.hintText,
      this.focusNode,
      this.autoValidateMode,
      this.hasObscure = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return hasObscure == true
        ? Stack(
            children: [
              ValueListenableBuilder(
                valueListenable: obscureTextController,
                child: Container(),
                builder: (context, bool obscureText, child) {
                  return TextFormField(
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
                      suffixIcon: ValueListenableBuilder(
                        valueListenable: obscureTextController,
                        child: Container(),
                        builder: (context, bool obscureText, child) {
                          return IconButton(
                            splashRadius: 24,
                            onPressed: () {
                              Future.delayed(Duration.zero, () {
                                focusNode?.unfocus();
                              });
                              obscureTextController.value = !obscureText;
                            },
                            icon: Icon(
                              obscureText
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: AppColors.black,
                            ),
                          );
                        },
                      ),
                      contentPadding: EdgeInsets.zero,
                    ),
                    keyboardType: TextInputType.visiblePassword,
                    onChanged: onChanged,
                    obscureText: obscureTextController.value,
                    autovalidateMode:
                        autoValidateMode ?? AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter password';
                      }
                      if (!Utils.isPassword(value)) {
                        return "Password requires at least 8 characters, one uppercase letter, one lowercase letter, one digit, and one special character.";
                      }
                      return null;
                    },
                  );
                },
              ),
            ],
          )
        : TextFormField(
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
            keyboardType: TextInputType.visiblePassword,
            onChanged: onChanged,
            obscureText: true,
            autovalidateMode:
                autoValidateMode ?? AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter password';
              }
              return null;
            },
          );
  }
}
