

import 'package:almacen_web_fe/ui/inputs/custom_inputs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../design/custom_colors.dart';
class CustomInputs {

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



  static Widget customTextFieldForm(Function onChanged, String labelText, String hintText, {isPassword = false}) {
    return Row(
      children: [
        Text(labelText,
        style: TextStyle(color: CustomColor.primaryColor())
        ),
        Spacer(),
        Container(
        width: 200,
        height: 32,
        child: TextFormField(
          obscureText: isPassword ,
          onChanged: ( value ) => onChanged(value),
          decoration: CustomInputsDecoration.formInputDecoration(hint: hintText),
          style: TextStyle( color: CustomColor.primaryColor() ),
        ),
      ),
        
      ],  
    );
  }

  static Widget customTextFieldFormNumber(Function onChanged, String labelText, String hintText, {isPassword = false}) {
    return Row(
      children: [
        Text(labelText,
        style: TextStyle(color: CustomColor.primaryColor())
        ),
        Spacer(),
        Container(
        width: 200,
        height: 32,
        child: TextFormField(
          obscureText: isPassword ,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          onChanged: ( value ) => onChanged(value),
          decoration: CustomInputsDecoration.formInputDecoration(hint: hintText),
          style: TextStyle( color: CustomColor.primaryColor() ),
        ),
      ),
        
      ],  
    );
  }
static Widget customTextFieldFormDouble(Function onChanged, String labelText, String hintText, {isPassword = false}) {
    return Row(
      children: [
        Text(labelText,
        style: TextStyle(color: CustomColor.primaryColor())
        ),
        Spacer(),
        Container(
        width: 200,
        height: 32,
        child: TextFormField(
          obscureText: isPassword ,
          inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,4}'))],
          onChanged: ( value ) => onChanged(value),
          decoration: CustomInputsDecoration.formInputDecoration(hint: hintText),
          style: TextStyle( color: CustomColor.primaryColor() ),
        ),
      ),
        
      ],  
    );
  }

   static Widget customTextFieldFormDisabled(String labelText, String hintText) {
    return Row(
      children: [
        Text(labelText,
        style: TextStyle(color: CustomColor.primaryColor())
        ),
        Spacer(),
        Container(
        width: 200,
        height: 32,
        child: TextFormField(
          enabled: false,
         
          decoration: CustomInputsDecoration.formInputDecoration(hint: hintText),
          style: TextStyle( color: CustomColor.primaryColor() ),
        ),
      ),
        
      ],  
    );
  }

  static Widget customTextFieldFormSearch(Function onChanged, String hintText) {
      return Container(
          height: 40,
          width: 400,
          decoration: searchBuildBoxDecoration(),
          child: TextFormField(
            
            onChanged: ( value ) => onChanged(value),
            decoration: CustomInputsDecoration.searchInputDecoration(
              hint: hintText, 
              icon: Icons.search_rounded),
              style: TextStyle( color: Colors.white ),
          ),
        );
    }
    
  
  
  }

    BoxDecoration searchBuildBoxDecoration() => BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    color: Colors.grey.withOpacity(0.1)
    );

 