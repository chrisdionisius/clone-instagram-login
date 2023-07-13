import 'package:flutter/material.dart';

class UsernameTextbox extends StatelessWidget {
  const UsernameTextbox({
    super.key,
    required this.width,
    required this.checkInputNotNull,
    required this.usernameController,
  });

  final double width;
  final TextEditingController usernameController;
  final VoidCallback checkInputNotNull;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('username_textbox_container'),
      width: width * .90,
      height: width * .14,
      decoration: const BoxDecoration(
        color: Color(0xffE8E8E8),
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      child: Padding(
        key: const Key('username_textbox_padding'),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Center(
          key: const Key('username_textbox_center'),
          child: TextField(
            key: const Key('username_textfield'),
            onChanged: (text) {
              checkInputNotNull();
            },
            controller: usernameController,
            style: const TextStyle(
              fontSize: 15,
            ),
            decoration: const InputDecoration.collapsed(
              hintText: 'Phone number , email or username',
            ),
          ),
        ),
      ),
    );
  }
}
