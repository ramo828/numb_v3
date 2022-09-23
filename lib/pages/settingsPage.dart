import 'package:flutter/material.dart';

class Ayarlar extends StatelessWidget {
  const Ayarlar({super.key});

  static const String routeName = "/settings";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Ayarlar"),
      ),
    );
  }
}
