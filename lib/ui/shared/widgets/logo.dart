import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final sizeGlobal = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only( top: 45 ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon( Icons.warehouse, color: Color(0xff7A6BF5) ),
          SizedBox( width: 10 ),
          (sizeGlobal.width > 700 ) 
          ?
          Text(
            'Almacenera Mercantil',
            style: GoogleFonts.roboto(
              fontSize: 16,
              fontWeight: FontWeight.w200,
              color: Colors.white
            ),
          )
          :
          Text("")
        ],
      ),
    );
  }
}