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
      key: Key('login_button_sizedbox'),
    );
  }
}
