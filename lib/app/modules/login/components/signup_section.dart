import 'package:flutter/material.dart';

class SignupSection extends StatelessWidget {
  final double width;

  const SignupSection({super.key, required this.width});

  @override
  Widget build(BuildContext context) {
    return Column(
      key: const Key('signup_section_column'),
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          key: const Key('signup_section_container'),
          width: width,
          height: 1,
          color: const Color(0xffA2A2A2),
        ),
        const SizedBox(height: 5),
        Row(
          key: const Key('signup_section'),
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Don't have an account? ",
              key: const Key('signup_section_text'),
              style: TextStyle(fontSize: width * .040),
            ),
            TextButton(
              key: const Key('signup_section_button'),
              child: Text(
                'Sign up',
                style: TextStyle(
                  color: const Color(0xff00258B),
                  fontSize: width * .040,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () => debugPrint('Sign Up'),
            ),
          ],
        ),
      ],
    );
  }
}
