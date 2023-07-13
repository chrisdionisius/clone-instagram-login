import 'package:flutter/material.dart';

class ORDivider extends StatelessWidget {
  final double width;
  const ORDivider({super.key, required this.width});
  @override
  Widget build(BuildContext context) {
    return Row(
      key: const Key('or_divider_row'),
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          key: const Key('or_divider_container_left'),
          height: 1,
          width: width * .40,
          color: const Color(0xffA2A2A2),
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          key: const Key('or_divider_text'),
          'OR',
          style: TextStyle(
            fontSize: width * .040,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Container(
          key: const Key('or_divider_container_right'),
          height: 1,
          width: width * .40,
          color: const Color(0xffA2A2A2),
        ),
      ],
    );
  }
}
