import 'package:flutter/material.dart';

class GreyButton extends StatelessWidget {
  final Function onPressed;
  final Widget child;

  const GreyButton({super.key, required this.onPressed, required this.child});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      key: Key('${key}_elevated_button'),
      onPressed: () => {},
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(0, 30),
        backgroundColor: Colors.grey[800],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      child: child,
    );
  }
}
