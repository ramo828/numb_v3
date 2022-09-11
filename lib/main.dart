import 'package:flutter/material.dart';
import 'package:routetest/pages/registerPages/registerPage.dart';
import 'package:routetest/pages/workNumberList.dart';
import 'package:routetest/pages/aboutPage.dart';
import 'package:routetest/pages/homePage.dart';
import 'package:routetest/pages/workPage.dart';
import 'myWidgest/loginElements.dart';

void main(List<String> args) {
  runApp(const YaziOrneyi());
}

class YaziOrneyi extends StatelessWidget {
  const YaziOrneyi({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case homePage.routeName:
            return MaterialPageRoute(
              builder: (context) => const homePage(),
            );
          case Haqqinda.routeName:
            return MaterialPageRoute(
              builder: (context) => const Haqqinda(),
            );
          case Worker.routeName:
            return MaterialPageRoute(
              builder: (context) => const Worker(),
            );
          case numberList.routeName:
            return MaterialPageRoute(
              builder: (context) => const numberList(),
            );
          case register.routeName:
            return MaterialPageRoute(
              builder: (context) => const register(),
            );
        }
        return null;
      },
      theme: ThemeData(fontFamily: 'esasFont'),
      home: Scaffold(
        drawer: Drawer(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          semanticLabel: "Menyu",
          backgroundColor: Colors.grey.shade400,
          width: 220,
          child: myList(),
        ),
        backgroundColor: Colors.grey.shade400,
        appBar: AppBar(
          backgroundColor: Colors.grey.shade500,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(5.0),
            ),
          ),
          centerTitle: true,
          title: const Text(
            "NUMB V3",
            style: TextStyle(
              fontFamily: 'dizaynFont',
              fontSize: 35,
            ),
          ),
        ),
        body: const SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: loginPage(),
        ),
      ),
    );
  }
}
