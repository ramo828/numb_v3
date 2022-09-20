import 'package:flutter/material.dart';

class globalElements {
  final appVersion = "numb v3.0";

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
      case 'grey':
        return Colors.grey;
      case 'blueGrey':
        return Colors.blueGrey;
      case 'teal':
        return Colors.teal;
      case 'brown':
        return Colors.brown;
      case 'lime':
        return Colors.lime;
      case 'pinkAccent':
        return Colors.pinkAccent;
      default:
        return Colors.black;
    }
  }
}
