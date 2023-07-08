import 'package:almacen_web_fe/providers/sidebar_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Navbar extends StatelessWidget {
  final String text;

  const Navbar({
    Key? key, 
    required this.text
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;


  
    return Container(
      width: double.infinity,    
      height: 120,
      decoration: buildBoxDecoration(),
      child: Row(
        children: [
          
    
            IconButton(
              icon: Icon( Icons.menu_outlined ), 
              onPressed: () => SideBarProvider()
            ),
          
          SizedBox( width: 5 ),
          Text(
            this.text,
            style: GoogleFonts.roboto(
              fontSize: 16,
              fontWeight: FontWeight.w200,
              color: Colors.white
            ),
            ),
          Spacer(),


          SizedBox( width: 10 ),


        ],
      ),
    );
  }

  BoxDecoration buildBoxDecoration() => BoxDecoration(
     gradient: LinearGradient(
      colors: [
        Color( 0xff092044 ),
        Color( 0xff092042 ),
      ]
    ),
    boxShadow: [
      BoxShadow(
        color: Colors.black12,
        blurRadius: 5
      )
    ]
  );
}