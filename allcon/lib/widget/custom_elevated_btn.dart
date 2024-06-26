import 'package:allcon/utils/Colors.dart';
import 'package:flutter/material.dart';

class CustomElevatedBtn extends StatelessWidget {
  final String text;
  final Function funPageRoute;
  final Color textColor;
  final double textSize;
  final Color buttonColor;
  final IconData? icon;
  final Color? iconColor;

  const CustomElevatedBtn({
    super.key,
    required this.text,
    required this.funPageRoute,
    this.textColor = Colors.deepPurple,
    this.textSize = 16,
    this.buttonColor = lavenderColor,
    this.icon,
    this.iconColor = lavenderColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: buttonColor,
      ),
      onPressed: () {
        funPageRoute();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) Icon(icon, color: iconColor),
          if (icon != null) const SizedBox(width: 16),
          Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: textSize,
            ),
          ),
        ],
      ),
    );
  }
}
