import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String? text;
  final void Function()? onPressed;

  const AppButton({super.key, this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.all(
          Radius.circular(18),
        ),
      ),
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          backgroundColor: MaterialStateProperty.all(const Color(0xff004D81)),
          minimumSize: MaterialStateProperty.all(
            Size(MediaQuery.of(context).size.width, 50),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text!,
          style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Color(0xffFFFFFF)),
        ),
      ),
    );
  }
}
