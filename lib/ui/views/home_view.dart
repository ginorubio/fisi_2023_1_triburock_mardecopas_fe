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
          Text('Home View' ),

          SizedBox( height: 10 ),

          Container(
            child: Text("Home View child"),
          )

        ],
      ),
    );
  }
}