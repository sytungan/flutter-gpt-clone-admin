import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final String? hintText;
  final Color? cursorColor;
  final Widget? suffixIcon;
  final bool obscureText;
  final Color? suffixIconColor;
  final bool? enabled;
  final String? Function(String?)? onsaved;
  final String? Function(String?)? onchange;
  // final String obscureSize;
  final bool? autoCorrect;
  final Color? focusColor;
  final TextInputAction? textinputAction;
  final TextEditingController? textEditingController;
  final TextInputType? keyBoardType;
  final String? Function(String?)? validator;

  const AppTextField({
    super.key,
    this.hintText,
    this.suffixIcon,
    this.textinputAction,
    this.textEditingController,
    this.keyBoardType,
    this.validator,
    this.obscureText = false,
    this.suffixIconColor,
    this.focusColor,
    this.autoCorrect,
    this.cursorColor,
    this.onsaved,
    this.enabled,
    this.onchange,
    // this.obscureSize = '.',
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onchange,
      enabled: enabled,
      validator: validator,
      onSaved: onsaved,
      cursorColor: cursorColor,
      autocorrect: true,
      keyboardType: keyBoardType,
      textInputAction: textinputAction,
      controller: textEditingController,
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
