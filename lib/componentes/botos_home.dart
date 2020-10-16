import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyCustomButton extends StatelessWidget {
  var text = "";

  MyCustomButton({
    @required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 250,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Color(0x80000000),
            blurRadius: 10.0,
            offset: Offset(0.0, 0.0),
          ),
        ],
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
              fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }
}
