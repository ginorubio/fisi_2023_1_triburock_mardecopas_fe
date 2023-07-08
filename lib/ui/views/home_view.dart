import 'package:almacen_web_fe/ui/buttons/custom_flatButton.dart';
import 'package:almacen_web_fe/ui/shared/navbar.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        physics: ClampingScrollPhysics(),
        children: [
          Navbar(text: "Inicio"),

          Container(
            child: Image.network(
              'https://capsa2in1.com/wp-content/uploads/2022/05/4-scaled.jpg',
            fit: BoxFit.cover, // Ajusta la imagen al tamaño del contenedor
            ),
          )

        ],
      ),
    );
  }
}