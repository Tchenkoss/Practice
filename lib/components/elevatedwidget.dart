import 'package:flutter/material.dart';

class ElevatedButtonWidget extends StatelessWidget {
  late VoidCallback buttonPressed;
  Widget child;

  ElevatedButtonWidget(
      {super.key, required this.buttonPressed, required this.child});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      width: 400,
      child: ElevatedButton(
          onPressed: buttonPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
          ),
          child: child),
    );
  }
}
