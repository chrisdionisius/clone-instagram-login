import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final double width;
  final bool inputTextNotNull;
  final VoidCallback onPressed;

  const LoginButton(
      {super.key,
      required this.width,
      required this.inputTextNotNull,
      required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: inputTextNotNull
            ? const Color(0xff26A9FF)
            : const Color(0xff78C9FF),
      ),
      child: Text(
        'Log In',
        style: TextStyle(
          color: Colors.white,
          fontSize: width * .040,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
