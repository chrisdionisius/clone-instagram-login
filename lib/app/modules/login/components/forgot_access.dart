import 'package:flutter/material.dart';

class ForgotAccess extends StatelessWidget {
  final double width;
  const ForgotAccess({super.key, required this.width});

  @override
  Widget build(BuildContext context) {
    return Row(
      key: const Key('forgot_access_row'),
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Forgot your login details? ',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.normal,
            color: Colors.black,
          ),
          key: Key('forgot_access_text'),
        ),
        GestureDetector(
          key: const Key('get_help_gesture_detector'),
          onTap: () {
            debugPrint('Get help');
          },
          child: const Text(
            'Get help',
            style: TextStyle(
              fontSize: 13,
              color: Color(0xff002588),
              fontWeight: FontWeight.bold,
            ),
            key: Key('get_help_text'),
          ),
        ),
      ],
    );
  }
}
