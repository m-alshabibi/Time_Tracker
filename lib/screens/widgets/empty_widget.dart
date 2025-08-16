import 'package:flutter/material.dart';

class TimeEntryEmptyWidget extends StatelessWidget {
  const TimeEntryEmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    const String titleMessage = "No Time Entry yet!";
    const String message = "Tap the + buttom to add your first entry";
    const Color primaryColor = Colors.grey;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 10,
      children: [
        Icon(Icons.hourglass_empty_rounded, size: 60, color: primaryColor),
        Text(titleMessage),
        Text(message, style: TextStyle(color: primaryColor)),
      ],
    );
  }
}
