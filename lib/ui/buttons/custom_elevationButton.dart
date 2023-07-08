import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomElevationButton extends StatelessWidget {

  final Function onPressed;
  final String text;
  final Color color;
  final Color colorText;
  final IconData icon;

  const CustomElevationButton({
    Key? key,
    required this.onPressed,
    required this.text,
    required this.icon,
    this.color = Colors.blue,
    this.colorText = Colors.white ,
    
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {


    return TextButton.icon(
        icon: Icon(icon
        ),
        style: TextButton.styleFrom(
          foregroundColor: colorText,
          backgroundColor: color
        ),
        onPressed: () => onPressed(), 
        label: Text(text,
          style: GoogleFonts.roboto(
            fontSize: 16
          ),
        ),
      );
  }
}