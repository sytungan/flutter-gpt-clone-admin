import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final String? hintText;
  final Color? cursorColor;
  final Widget? suffixIcon;
  final bool obscureText;
  final Color? suffixIconColor;
  final bool? enabled;
  final String? Function(String?)? onSaved;
  final String? Function(String?)? onChange;
  // final String obscureSize;
  final bool? autoCorrect;
  final Color? focusColor;
  final TextInputAction? textInputAction;
  final TextEditingController? controller;
  final TextInputType? keyBoardType;
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
      decoration: InputDecoration(
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
            color: Colors.blue,
          ),
        ),
        contentPadding: const EdgeInsets.all(14),
        hintStyle: const TextStyle(
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
