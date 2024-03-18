import 'package:eurosom_admin/res/theme_color.dart';
import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final String? hintText;
  final Color? cursorColor;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final Color? suffixIconColor;
  final bool? enabled;
  final Function(String?)? onSaved;
  final Function(String)? onChange;
  final Function(String)? onFieldSubmitted;

  // final String obscureSize;
  final bool? autoCorrect;
  final Color? focusColor;
  final TextInputAction? textInputAction;
  final TextEditingController? controller;
  final TextInputType? keyBoardType;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final String? Function(String?)? validator;

  const AppTextField({
    super.key,
    this.hintText,
    this.suffixIcon,
    this.textInputAction,
    this.controller,
    this.keyBoardType,
    this.validator,
    this.obscureText = false,
    this.suffixIconColor,
    this.focusColor,
    this.autoCorrect,
    this.cursorColor,
    this.onSaved,
    this.enabled,
    this.onChange,
    this.style,
    this.hintStyle,
    this.prefixIcon,
    this.onFieldSubmitted,
    // this.obscureSize = '.',
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChange,
      enabled: enabled,
      validator: validator,
      onSaved: onSaved,
      cursorColor: cursorColor,
      autocorrect: true,
      keyboardType: keyBoardType,
      textInputAction: textInputAction,
      controller: controller,
      obscureText: obscureText,
      onFieldSubmitted: onFieldSubmitted,
      style: style ??
          const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        suffixIconColor: suffixIconColor,
        focusColor: focusColor,
        hintText: hintText,
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
          borderSide: BorderSide(
            width: 1,
            color: AppColor.themeColor,
          ),
        ),
        contentPadding: const EdgeInsets.all(14),
        hintStyle: hintStyle ??
            const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
          borderSide: BorderSide(
            color: Color(0xff8B8B8B),
          ),
        ),
      ),
    );
  }
}
