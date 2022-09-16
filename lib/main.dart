import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:routetest/account/account.dart';
import 'package:routetest/database/db.dart';
import 'package:routetest/pages/registerPages/registerPage.dart';
import 'package:routetest/pages/workNumberList.dart';
import 'package:routetest/pages/aboutPage.dart';
import 'package:routetest/pages/homePage.dart';
import 'package:routetest/pages/workPage.dart';
import 'package:routetest/pages/settingsPage.dart';
import 'package:routetest/theme/themeData.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'elements/loginElements.dart';

late myDataBase db;
late Account a;
ThemeData? theme;
String userName = "";
String userPass = "";
bool themeStatus = true;

void main(List<String> args) {
  runApp(
    ChangeNotifierProvider<themeWrite>(
      child: const YaziOrneyi(),
      create: (context) {
        return themeWrite();
      },
    ),
  );
}

void oldUser() async {
  SharedPreferences sp = await SharedPreferences.getInstance();
  sp.setBool('new', false);
}

//Ilk defe programlari yekleyenler ucun
Future<bool> getNewUser() async {
  SharedPreferences sp = await SharedPreferences.getInstance();
  return sp.getBool('new') ?? true;
}

class YaziOrneyi extends StatefulWidget {
  const YaziOrneyi({super.key});

  @override
  State<YaziOrneyi> createState() => _YaziOrneyiState();
}

class _YaziOrneyiState extends State<YaziOrneyi> {
  void dbInit() {
    try {
      db = myDataBase();
      db.open();
    } catch (e) {
      debugPrint(e.toString());
    }
    debugPrint("Initilazed");
  }

  void init() async {
    userName = await db.getUser('user');
    userPass = await db.getUser('password');
    await getNewUser() ? oldUser() : debugPrint("Old user");
  }

  @override
  void initState() {
    Provider.of<themeWrite>(context, listen: false).themeInit();

    super.initState();
    dbInit();
    init();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    PageController controller = PageController();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Provider.of<themeWrite>(context).theme,
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
      home: Scaffold(
        drawer: const drawer(),
        appBar: appBar(),
        body: const loginTwo(),
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      actions: [
        GestureDetector(
          child: !Provider.of<themeWrite>(context, listen: false).getThemeMode
              ? const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    FontAwesomeIcons.moon,
                    size: 30,
                  ),
                )
              : const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    FontAwesomeIcons.sun,
                    size: 30,
                  ),
                ),
          onTap: () {
            setState(() {
              Provider.of<themeWrite>(context, listen: false).toggle();
            });
          },
        ),
      ],
      centerTitle: true,
      title: const Text(
        "Numb v3",
        style: TextStyle(
          fontFamily: 'esasFont',
          fontSize: 40,
        ),
      ),
    );
  }
}

// ignore: camel_case_types
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

// ignore: camel_case_types
class loginTwo extends StatefulWidget {
  const loginTwo({super.key});

  @override
  State<loginTwo> createState() => _loginTwoState();
}

// ignore: camel_case_types
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
