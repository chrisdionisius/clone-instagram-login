import 'package:flutter/material.dart';

class FacebookLogin extends StatelessWidget {
  final double width;
  const FacebookLogin({super.key, required this.width});
  @override
  Widget build(BuildContext context) {
    return Row(
      key: const Key('facebook_login_row'),
    );
  }
}
