// ignore: file_names
import 'package:flutter/material.dart';

class MyContainer extends StatelessWidget {
  final double radius;
  final double mesafe;
  final Widget child;
  final Color shadowColor;
  final Color boxColor;
  final double spreadRadius;
  final double shadowRadius;
  final double width;
  final double height;

  final void Function()? onPress;
  // ignore: use_key_in_widget_constructors
  const MyContainer(
      {this.radius = 15.0,
      this.mesafe = 15.0,
      this.width = 0,
      this.height = 0,
      this.shadowColor = Colors.white,
      this.boxColor = Colors.white,
      this.spreadRadius = 5,
      this.shadowRadius = 15,
      this.child = const Icon(
        Icons.add,
        size: 100,
        color: Colors.black54,
      ),
      this.onPress});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        // width: MediaQuery.of(context).size.width * 0.5 - 200,
        width: width,
        height: height,
        // height: MediaQuery.of(context).size.height * 0.5 - 130,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          color: boxColor,
          boxShadow: [
            BoxShadow(
              color: shadowColor.withOpacity(0.5),
              spreadRadius: spreadRadius,
              blurRadius: shadowRadius,
              offset: const Offset(0, 3), // changes position of shadow
            )
          ],
        ),
        margin: EdgeInsets.all(mesafe),
        child: child,
      ),
    );
  }
}
