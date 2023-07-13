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
      width: width * .90,
      height: width * .14,
      decoration: const BoxDecoration(
        color: Color(0xffE8E8E8),
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: Padding(
        key: const Key('password_textbox_padding'),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Center(
          child: TextField(
            key: const Key('password_textfield'),
            onChanged: (text) {
              checkInputNotNull();
            },
            controller: passwordController,
            obscureText: true,
            style: const TextStyle(
              fontSize: 15,
            ),
            decoration: const InputDecoration.collapsed(
              hintText: 'Password',
            ),
          ),
        ),
      ),
    );
  }
}
