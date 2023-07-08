import 'package:almacen_web_fe/ui/design/custom_colors.dart';
import 'package:flutter/material.dart';


class CustomInputsDecoration {

  static InputDecoration loginInputDecoration({
    required String hint,
    required String label,
    required IconData icon,
  }){
    return InputDecoration(
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white.withOpacity(0.3))
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white.withOpacity(0.3))
      ),
      hintText: hint,
      labelText: label,
      prefixIcon: Icon( icon, color: Colors.grey ),
      labelStyle: TextStyle( color: Colors.grey ),
      hintStyle: TextStyle( color: Colors.grey ),
    );
  }



  static InputDecoration searchInputDecoration({
    required String hint,
    required IconData icon
  }) {
    return InputDecoration(
        border: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white)
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white)
      ),
      hintText: hint,
      prefixIcon: Icon( icon, color: Colors.white ),
      labelStyle: TextStyle( color: Colors.white ),
      hintStyle: TextStyle( color: Colors.white )
    );
  }


  static InputDecoration formInputDecoration({
    required String hint,
  }) {
    return InputDecoration(
        border: OutlineInputBorder(
        borderSide: BorderSide(color: CustomColor.primaryColor())
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: CustomColor.primaryColor())
      ),
      focusedErrorBorder:  OutlineInputBorder(
        borderSide: BorderSide(color: CustomColor.primaryColor())
      ),
      hintText: hint,
      hintStyle: TextStyle( color: Colors.grey )
    );
  }
  

}