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
    );
  }
}
