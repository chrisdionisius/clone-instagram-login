import 'package:flutter/material.dart';

class FacebookLogin extends StatelessWidget {
  final double width;
  const FacebookLogin({super.key, required this.width});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/facebook.png',
          height: width * .060,
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          'Login with facebook',
          style: TextStyle(
            color: const Color(0xff1877f2),
            fontSize: width * .040,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}
