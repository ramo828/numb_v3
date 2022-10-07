import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:routetest/backent/firebaseControl.dart';
import 'package:routetest/pages/activeNumbers/activePage.dart';
import 'package:routetest/pages/panel/usersPanel.dart';
import 'package:routetest/pages/registerPage.dart';
import 'package:routetest/pages/activeNumbers/work/workNumberList.dart';
import 'package:routetest/pages/aboutPage.dart';
import 'package:routetest/pages/homePage.dart';
import 'package:routetest/pages/activeNumbers/work/workPage.dart';
import 'package:routetest/pages/settingsPage.dart';
import 'package:routetest/pages/activeNumbers/work/workSettings.dart';
import 'package:routetest/theme/themeData.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'elements/loginElements.dart';

ThemeData? theme;
bool themeStatus = true;
bool routeStatus = false;

firebaseControls firebaseControl = firebaseControls();

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ChangeNotifierProvider<themeWrite>(
      child: const YaziOrneyi(),
      create: (context) {
        return themeWrite();
      },
    ),
  );
}

void settingData() async {
  SharedPreferences sp = await SharedPreferences.getInstance();
  List<String> setting = [
    'Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJhZG1pbiIsImF1dGgiOiJNQUlOIiwiZXhwIjoxNjY2MTAzOTE2fQ.PsIDajJ5xIQz82PwDEZq28opZDpk_hCT-nUBsBtbr-GOYLq1XcoLmXMYEZYcuDBlxoiSJClB2BTAEUqmoLfvSQ',
    'keyNar',
    'Metros',
    '/sdcard/work/'
  ];
  sp.setStringList('setting', setting);
}

void oldUser() async {
  SharedPreferences sp = await SharedPreferences.getInstance();
  sp.setBool('new', false);
  settingData();
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
  final Future<FirebaseApp> _firebase = Firebase.initializeApp();

  void init() async {
    await getNewUser() ? oldUser() : debugPrint("Old user");
    SharedPreferences sp = await SharedPreferences.getInstance();
    bool getStatus = sp.getBool("logIN") ?? false;
    //
    if (getStatus) {
      setState(() {
        routeStatus = true;
      });
    } else {
      routeStatus = false;
    }
  }

  @override
  void initState() {
    Provider.of<themeWrite>(context, listen: false).themeInit();
    super.initState();
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
            case usersPanel.routeName:
              return MaterialPageRoute(
                builder: (context) => const usersPanel(),
              );
            case workSettings.routeName:
              return MaterialPageRoute(
                builder: (context) => const workSettings(),
              );
            case activePage.routeName:
              return MaterialPageRoute(
                builder: (context) => const activePage(),
              );
          }
          return null;
        },
        home: FutureBuilder(
          builder: (context, AsyncSnapshot ash) {
            if (ash.hasError) {
              return const Center(
                child: Text(
                  "Problem yarandi",
                ),
              );
            } else if (ash.hasData) {
              return Scaffold(
                body: routeStatus ? const homePage() : const loginTwo(),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
          future: _firebase,
        ));
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
        const SizedBox(height: 4),
      ],
    );
  }
}
