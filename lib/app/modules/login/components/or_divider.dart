import 'package:flutter/material.dart';

class ORDivider extends StatelessWidget {
  final double width;
  const ORDivider({super.key, required this.width});
  @override
  Widget build(BuildContext context) {
    return Row(
      key: const Key('or_divider_row'),
    );
  }
}
