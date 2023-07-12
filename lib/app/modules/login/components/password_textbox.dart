import 'package:flutter/material.dart';

class PasswordTextbox extends StatelessWidget {
  const PasswordTextbox({
    super.key,
    required this.width,
    required this.checkInputNotNull,
    required this.passwordController,
  });

  final double width;
  final TextEditingController passwordController;
  final VoidCallback checkInputNotNull;
  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('password_textbox_container'),
    );
  }
}
