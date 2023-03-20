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
      width: width * .90,
      height: width * .14,
      decoration: const BoxDecoration(
        color: Color(0xffE8E8E8),
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Center(
          child: TextField(
            key: const Key('username_textfield'),
            onChanged: (text) {
              checkInputNotNull();
            },
            controller: usernameController,
            style: TextStyle(
              fontSize: width * .040,
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
