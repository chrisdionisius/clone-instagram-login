import 'package:flutter/material.dart';

class SignupSection extends StatelessWidget {
  final double width;

  const SignupSection({super.key, required this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: width,
            height: 1,
            color: const Color(0xffA2A2A2),
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Don't have an account? ",
                style: TextStyle(
                  fontSize: width * .040,
                ),
              ),
              GestureDetector(
                onTap: () {
                  debugPrint('Sign Up');
                },
                child: Text(
                  'Sign up',
                  style: TextStyle(
                    color: const Color(0xff00258B),
                    fontSize: width * .040,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
