
import 'package:almacen_web_fe/ui/design/custom_colors.dart';
import 'package:flutter/material.dart';

class CustomBoxDecoration{

   static BoxDecoration navBoxDecoration() => BoxDecoration(
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