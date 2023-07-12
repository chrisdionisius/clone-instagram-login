import 'package:flutter/material.dart';

class ForgotAccess extends StatelessWidget {
  final double width;
  const ForgotAccess({super.key, required this.width});

  @override
  Widget build(BuildContext context) {
    return Row(
      key: const Key('forgot_access_row'),
    );
  }
}
