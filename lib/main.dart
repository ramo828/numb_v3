import 'package:flutter/material.dart';
import 'package:routetest/database/db.dart';
import 'package:routetest/pages/registerPages/registerPage.dart';
import 'package:routetest/pages/workNumberList.dart';
import 'package:routetest/pages/aboutPage.dart';
import 'package:routetest/pages/homePage.dart';
import 'package:routetest/pages/workPage.dart';
import 'package:routetest/settingsPage.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'elements/loginElements.dart';

String? myData = "";
late myDataBase db;

void main(List<String> args) {
  runApp(
    const YaziOrneyi(),
  );
}

class YaziOrneyi extends StatefulWidget {
  const YaziOrneyi({super.key});

  @override
  State<YaziOrneyi> createState() => _YaziOrneyiState();
}

class _YaziOrneyiState extends State<YaziOrneyi> {
  @override
  void initState() {
    try {
      db = myDataBase();
      db.open();
    } catch (e) {
      print(e);
    }
    print("Initilazed");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    PageController controller = PageController();
    return MaterialApp(
      theme: ThemeData.dark(),
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
          case Ayarlar.routeName:
            return MaterialPageRoute(
              builder: (context) => const Ayarlar(),
            );
        }
        return null;
      },
      // theme: themeWrite().myTheme,
      home: Scaffold(
        drawer: const drawer(),
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Numb v3",
            style: TextStyle(
              fontFamily: 'esasFont',
              fontSize: 40,
            ),
          ),
        ),
        body: const loginTwo(),
      ),
    );
  }
}

class drawer extends StatelessWidget {
  const drawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 10,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      semanticLabel: "Menyu",
      width: 220,
      child: myList(),
    );
  }
}

class loginTwo extends StatefulWidget {
  const loginTwo({super.key});

  @override
  State<loginTwo> createState() => _loginTwoState();
}

class _loginTwoState extends State<loginTwo> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: PageView(
            controller: controller,
            onPageChanged: (value) {
              setState(() {});
            },
            children: const [
              loginPage(),
              register(),
            ],
          ),
        ),
        SmoothPageIndicator(
          controller: controller,
          count: 2,
          axisDirection: Axis.horizontal,
          effect: const SlideEffect(
            spacing: 10,
            activeDotColor: Colors.grey,
            dotHeight: 15,
            dotColor: Colors.blueGrey,
            dotWidth: 15,
          ),
        ),
        const SizedBox(height: 5),
      ],
    );
  }
}
