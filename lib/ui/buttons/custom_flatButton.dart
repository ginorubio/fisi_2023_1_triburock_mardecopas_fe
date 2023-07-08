import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomFlatButton extends StatelessWidget {
  final Function onPressed;
  final String text;
  final Color color;
  final Color colorText;
  final bool isFilled;

  const CustomFlatButton(
      {Key? key,
      required this.onPressed,
      required this.text,
      this.color = Colors.blue,
      this.colorText = Colors.white,
      this.isFilled = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
       style: TextButton.styleFrom(
        foregroundColor: colorText,
        backgroundColor: color
      ),
      onPressed: () => onPressed(), 
      child: Padding(
        padding: EdgeInsets.symmetric( horizontal: 24, vertical: 12 ),
        child: Text( 
          text,
          style:  GoogleFonts.roboto(
          fontSize: 16
        ),
        ),
      )
      );
  }
}
