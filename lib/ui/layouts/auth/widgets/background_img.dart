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
          image: Image.network("https://e1.pxfuel.com/desktop-wallpaper/23/777/desktop-wallpaper-the-warehouse-kargo-warehouse.jpg", ).image,
          fit: BoxFit.cover
        )
    );
  }
}

