import 'package:flutter/material.dart';
import 'package:admin_app/consts/constants.dart';

import '../responsive.dart';



class ButtonsWidget extends StatelessWidget {
  const ButtonsWidget({
    Key? key,
    required this.onPressed,
    required this.text,
    required this.icon,
    required this.backgroundColor,
    this.color = Colors.white,
  }) : super(key: key);
  final VoidCallback onPressed;
  final String text;
  final IconData icon;
  final Color backgroundColor;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
        backgroundColor: backgroundColor,
        side: BorderSide(
          color: Colors.blueAccent,
          width: 2.0, // Độ dày của viền
        ),

        padding: EdgeInsets.symmetric(
          horizontal: defaultPadding * 1.5,
          vertical: defaultPadding / (Responsive.isDesktop(context) ? 1 : 2),
        ),
      ),
      onPressed: () {
        onPressed();
      },
      icon: Icon(icon, size: 20,),
      label: Text(text),
    );
  }
}
