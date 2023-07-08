import 'package:flutter/material.dart';

class WhiteCard extends StatelessWidget {

  final Widget child;
  final double? width;

  const WhiteCard({
    Key? key,
    required this.child,
    this.width,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      width: width != null ? width : double.infinity,
      margin: EdgeInsets.all(20),
      decoration: buildBoxDecoration(),
      child: child
    );
  }

  BoxDecoration buildBoxDecoration() => BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(5),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.05),
        blurRadius: 5
      )
    ]
  );
}