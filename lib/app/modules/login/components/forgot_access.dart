import 'package:flutter/material.dart';

class ForgotAccess extends StatelessWidget {
  final double width;
  const ForgotAccess({super.key, required this.width});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Forgot your login details? ',
          style: TextStyle(
            fontSize: width * .035,
          ),
        ),
        GestureDetector(
          onTap: () {
            debugPrint('Get help');
          },
          child: Text(
            'Get help',
            style: TextStyle(
              fontSize: width * .035,
              color: const Color(0xff002588),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
