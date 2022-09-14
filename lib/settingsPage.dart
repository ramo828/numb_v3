import 'package:flutter/material.dart';

List<DropdownMenuItem<dynamic>>? themes = [
  const DropdownMenuItem(
    value: "Light",
    child: Text("Light"),
  ),
  const DropdownMenuItem(
    value: "Dark",
    child: Text("Dark"),
  ),
];

String _value = "Light";

class Ayarlar extends StatelessWidget {
  const Ayarlar({super.key});

  static const String routeName = "/settings";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ayarlar"),
      ),
      body: Center(
        child: Column(
          children: [
            DropdownButton(
              hint: Center(
                child: Text(_value),
              ),
              items: themes,
              onChanged: (value) => _value = value,
            ),
            OutlinedButton(
                child: const Text("Click"),
                onPressed: () {
                  print("Test");
                }),
            OutlinedButton(
              onPressed: () {},
              child: const Text("Yoxla"),
            ),
          ],
        ),
      ),
    );
  }
}
