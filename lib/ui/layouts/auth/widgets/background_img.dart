import 'package:flutter/material.dart';

class BackgroundAlmacen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: buildBoxDecoration(),
      child: Container(
        constraints: BoxConstraints( maxWidth: 400 ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child:Text("")
          ),
        ),
      ),
    );
  }

  BoxDecoration buildBoxDecoration() {
    return BoxDecoration(
        image: DecorationImage(
          image: AssetImage('warehouse-bg.jpg'),
          fit: BoxFit.cover
        )
    );
  }
}

