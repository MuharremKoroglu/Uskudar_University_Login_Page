import 'package:flutter/material.dart';
import 'constants.dart';

class ButtonWidget extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  final double width;

  ButtonWidget(
      {required this.buttonText, required this.onPressed, required this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          primary: kmainButonColor,
        ),
        child: Text(
          buttonText,
          style: kbutonTextStyle,
        ),
      ),
    );
  }
}
