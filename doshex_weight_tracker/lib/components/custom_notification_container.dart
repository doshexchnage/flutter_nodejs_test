import 'package:flutter/material.dart';

class CustomNotificationContainer extends StatelessWidget {
  final String? notificationText;
  final Color? backgroundColour;
  final Color? textColour;

  CustomNotificationContainer({
    required this.notificationText,
    required this.backgroundColour,
     required this.textColour,
  });

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: backgroundColour,
      ),
      margin: EdgeInsets.fromLTRB(
        _width * 0.05,
        _width * 0.05,
        _width * 0.05,
        0,
      ),
      width: _width,
      padding: EdgeInsets.all(_width * 0.05),
      child: Text(
        notificationText!,
        style: TextStyle(
          color: textColour,
          fontSize: _width * 0.045,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}