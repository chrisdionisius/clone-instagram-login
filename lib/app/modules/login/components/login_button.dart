import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final double width;
  final bool inputTextNotNull;
  final VoidCallback onPressed;

  const LoginButton({
    super.key,
    required this.width,
    required this.inputTextNotNull,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      key: const Key('login_button_sized_box'),
      width: width * .90,
      height: width * .14,
      child: ElevatedButton(
        key: const Key('login_button_elevated_button'),
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: inputTextNotNull
              ? const Color(0xff26A9FF)
              : const Color(0xff78C9FF),
        ),
        child: Text(
          key: const Key('login_button_text'),
          'Log In',
          style: TextStyle(
            color: Colors.white,
            fontSize: width * .040,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
