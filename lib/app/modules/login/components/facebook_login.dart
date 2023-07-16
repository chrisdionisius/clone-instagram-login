import 'package:flutter/material.dart';

class FacebookLogin extends StatelessWidget {
  final double width;
  const FacebookLogin({super.key, required this.width});
  @override
  Widget build(BuildContext context) {
    return Row(
      key: const Key('facebook_login'),
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/facebook.png',
          height: width * .060,
          key: const Key('facebook_logo'),
        ),
        const SizedBox(width: 5),
        Text(
          'Login with facebook',
          key: const Key('facebook_login_text'),
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
