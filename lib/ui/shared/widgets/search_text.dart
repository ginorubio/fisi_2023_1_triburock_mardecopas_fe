import 'package:almacen_web_fe/ui/inputs/custom_inputs.dart';
import 'package:flutter/material.dart';


class SearchText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 400,
      decoration: buildBoxDecoration(),
      child: TextField(
        style: TextStyle(color: Colors.white),
        decoration: CustomInputsDecoration.searchInputDecoration(
          hint: 'Buscar', 
          icon: Icons.search_outlined
        ),
      ),
    );
  }

  BoxDecoration buildBoxDecoration() => BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    color: Colors.grey.withOpacity(0.1)
  );
}