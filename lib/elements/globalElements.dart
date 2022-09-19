import 'package:flutter/material.dart';

class globalElements {
  Color colorConvertToString(String color) {
    switch (color) {
      case 'red':
        return Colors.red;
      case 'pink':
        return Colors.pink;
      case 'purple':
        return Colors.purple;
      case 'orange':
        return Colors.orange;
      case 'blue':
        return Colors.blue;
      case 'cyan':
        return Colors.cyan;
      case 'green':
        return Colors.green;
      case 'yellow':
        return Colors.yellow;
      case 'black':
        return Colors.black;
      case 'amber':
        return Colors.amber;
      case 'white':
        return Colors.white;
      case 'indigo':
        return Colors.indigo;
      default:
        return Colors.black;
    }
  }
}
