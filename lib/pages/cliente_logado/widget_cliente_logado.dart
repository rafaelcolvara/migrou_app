import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DetectoHome extends StatelessWidget {
  Function ontapDown;
  Function ontap;
  Function ontapUp;
  double scale;
  Widget filho;
  DetectoHome({
    @required this.ontapDown,
    @required this.ontap,
    @required this.ontapUp,
    @required this.scale,
    @required this.filho,
  });
  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTapDown: ontapDown,
        onTap: ontap,
        onTapUp: ontapUp,
        child: Transform.scale(
          scale: scale,
          child: filho,
        ),
      ),
    );
  }
}
