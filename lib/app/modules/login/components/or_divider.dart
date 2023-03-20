import 'package:flutter/material.dart';

class ORDivider extends StatelessWidget {
  final double width;
  const ORDivider({super.key, required this.width});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 1,
          width: width * .40,
          color: const Color(0xffA2A2A2),
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          'OR',
          style: TextStyle(
            fontSize: width * .040,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Container(
          height: 1,
          width: width * .40,
          color: const Color(0xffA2A2A2),
        ),
      ],
    );
  }
}
