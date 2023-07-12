import 'package:flutter/material.dart';

class SignupSection extends StatelessWidget {
  final double width;

  const SignupSection({super.key, required this.width});

  @override
  Widget build(BuildContext context) {
    return Column(
      key: const Key('signup_section_column'),
    );
  }
}
