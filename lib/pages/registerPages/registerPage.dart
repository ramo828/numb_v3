import 'package:flutter/material.dart';
import 'package:routetest/myWidgest/workElements.dart';

class register extends StatefulWidget {
  const register({super.key});
  static const routeName = "/register";
  @override
  State<register> createState() => _registerState();
}

final PageController controller = PageController();

class _registerState extends State<register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Hello")),
      body: PageView(children: const [
        // Text("Salam"),
        Text("Necesen"),
        numberTextField(),
      ]),
    );
  }
}
