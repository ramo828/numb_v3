import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:routetest/backent/firebaseControl.dart';
import 'package:routetest/elements/workElements.dart';
import 'package:routetest/pages/homePage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../pages/aboutPage.dart';
import '../myWidgest/myWidgets.dart';

class loginPage extends StatefulWidget {
  const loginPage({super.key});

  @override
  State<loginPage> createState() => _loginPageState();
}

firebaseControls firebaseControl = firebaseControls();

class _loginPageState extends State<loginPage> {
  String login = "";
  String pass = "";
  String fillSep = " ";
  bool visiblePass = true;

  @override
  Widget build(BuildContext context) {
    Color defaultColor = Colors.blue.shade300.withOpacity(0.8);

    return Center(
      child: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 10,
              ),
              CircleAvatar(
                radius: 130,
                backgroundColor: Colors.lightBlue.shade400.withOpacity(0.2),
                backgroundImage: const AssetImage("images/black_cat.jpg"),
              ),
              //Container login and password
              MyContainer(
                height: 180,
                width: 600,
                boxColor: Colors.grey.shade400.withOpacity(0.5),
                shadowColor: Colors.grey.shade600.withOpacity(0.1),
                child: Column(
                  children: [
                    field(
                      'Istifadəçi adı',
                      const Icon(
                        Icons.person,
                        size: 40,
                      ),
                      (value) {
                        login = value;
                      },
                      false,
                      false,
                      defaultColor,
                    ),
                    MyContainer(
                      shadowColor: Colors.grey.shade600,
                      height: 60,
                      width: 300,
                      boxColor: Colors.blue.shade300.withOpacity(0.8),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: TextField(
                            //password
                            obscureText: visiblePass,
                            enableSuggestions: false,
                            autocorrect: false,
                            decoration: InputDecoration(
                              prefixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    visiblePass
                                        ? visiblePass = false
                                        : visiblePass = true;
                                    visiblePass ? fillSep = " " : fillSep = " ";
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 7),
                                  child: Icon(
                                    visiblePass
                                        ? Icons.remove_red_eye
                                        : FontAwesomeIcons.eyeLowVision,
                                    size: visiblePass ? 40 : 30,
                                  ),
                                ),
                              ),
                              border: InputBorder.none,
                              prefix: Text(fillSep),
                              hintText: 'Şifrə',
                              hintStyle: const TextStyle(fontSize: 25),
                            ),
                            style: const TextStyle(
                              fontSize: 30,
                              color: Colors.black54,
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.w900,
                            ),
                            textAlign: TextAlign.start,
                            readOnly: false,
                            onChanged: (value) {
                              setState(() {
                                pass = value;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              loginButton(login: login, pass: pass),
              const SizedBox(
                height: 120,
              ),

              //button
              const Align(
                alignment: Alignment.topLeft,
                child: Author(),
              ),
              const SizedBox(
                height: 10,
              )
            ],
          ),
        ],
      ),
    );
  }
}

class loginButton extends StatelessWidget {
  const loginButton({
    Key? key,
    required this.login,
    required this.pass,
  }) : super(key: key);

  final String login;
  final String pass;

  @override
  Widget build(BuildContext context) {
    List<Widget> def = [
      Center(
        child: MyContainer(
          shadowColor: Colors.blueGrey.shade900,
          boxColor: Colors.blueGrey.shade500,
          height: 60,
          width: 120,
          radius: 15,
          mesafe: 15,
          shadowRadius: 10,
          child: const Center(
            child: Text(
              "Oldu",
            ),
          ),
          onPress: () {
            Navigator.pop(context);
          },
        ),
      )
    ];
    return MyContainer(
      height: 50,
      width: 170,
      boxColor: Colors.blue.shade200.withOpacity(0.7),
      shadowColor: Colors.grey.shade600,
      onLongPress: () {},
      onPress: (() async {
        try {
          if (await firebaseControl.loginControl(login, pass)) {
            SharedPreferences sp = await SharedPreferences.getInstance();
            await sp.setBool("logIN", true);
            await sp.setString("id", login);
            await sp.setStringList("controlUser", [login, pass]);

            Navigator.pushNamed(context, homePage.routeName);
          } else {}
        } catch (e) {
          var xeta = ilanBar(
            e.toString(),
            "oldu",
            1000000,
            () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            },
          );

          ScaffoldMessenger.of(context).showSnackBar(xeta);
        }
      }),
      child: const Center(
        child: Text(
          "Daxil ol",
          style: TextStyle(fontSize: 30),
        ),
      ),
    );
  }
}

// ignore: camel_case_types, must_be_immutable
class myList extends StatelessWidget {
  Color iconColor = const Color(0xff536dfe);
  myList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      addAutomaticKeepAlives: true,
      children: [
        OutlinedButton(
          onPressed: () {
            Navigator.pushNamed(context, Haqqinda.routeName);
          },
          child: ListTile(
            leading: Icon(
              color: iconColor,
              Icons.info_outline_rounded,
              size: 25,
            ),
            title: const Text(
              textAlign: TextAlign.left,
              "Haqqında",
              selectionColor: Colors.red,
            ),
          ),
        ),
        OutlinedButton(
          onPressed: () {
            exit(0);
          },
          child: ListTile(
            leading: Icon(
              color: iconColor,
              Icons.exit_to_app,
              size: 25,
            ),
            title: const Text(
              textAlign: TextAlign.left,
              "Çıxış",
              selectionColor: Colors.red,
            ),
          ),
        ),
      ],
    );
  }
}

class myAlertBox extends StatelessWidget {
  final String message;
  final String title;
  // final Color backgroundColor;
  final Icon icon;
  final List<Widget>? widgetList;

  const myAlertBox({
    super.key,
    this.message = "İstifadəçi adı və ya şifrə xətalıdır!",
    this.title = "",
    this.icon = const Icon(
      Icons.error,
    ),
    this.widgetList,
  });

/*

*/

  @override
  Widget build(BuildContext context) => AlertDialog(
        title: Text(title),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(30.0),
          ),
        ),
        backgroundColor: Colors.blueGrey.withOpacity(0.5),
        iconPadding: const EdgeInsets.all(5),
        icon: icon,
        alignment: Alignment.center,
        content: Text(
          message,
          style: TextStyle(fontSize: 30, color: Colors.amber.shade600),
          textAlign: TextAlign.center,
        ),
        actions: widgetList,
      );
}

class Author extends StatefulWidget {
  const Author({super.key});

  @override
  State<Author> createState() => _AuthorState();
}

class _AuthorState extends State<Author> {
  @override
  int count = 0;
  List<Color> colors = <Color>[
    Colors.amber.shade100,
    Colors.amber.shade200,
    Colors.amber.shade300,
    Colors.amber.shade400,
    Colors.amber.shade500,
    Colors.amber.shade600,
    Colors.amber.shade700,
    Colors.amber.shade800,
    Colors.amber.shade900,
    Colors.red.shade100,
    Colors.red.shade200,
    Colors.red.shade300,
    Colors.red.shade400,
    Colors.red.shade500,
    Colors.red.shade600,
    Colors.red.shade700,
    Colors.red.shade800,
    Colors.red.shade900,
    Colors.pink.shade100,
    Colors.pink.shade200,
    Colors.pink.shade300,
    Colors.pink.shade400,
    Colors.pink.shade500,
    Colors.pink.shade600,
    Colors.pink.shade700,
    Colors.pink.shade800,
    Colors.pink.shade900,
    Colors.purple.shade100,
    Colors.purple.shade200,
    Colors.purple.shade300,
    Colors.purple.shade400,
    Colors.purple.shade500,
    Colors.purple.shade600,
    Colors.purple.shade700,
    Colors.purple.shade800,
    Colors.purple.shade900,
    Colors.purpleAccent.shade100,
    Colors.purpleAccent.shade200,
    Colors.purpleAccent.shade400,
    Colors.purpleAccent.shade700,
    Colors.blue.shade100,
    Colors.blue.shade200,
    Colors.blue.shade300,
    Colors.blue.shade400,
    Colors.blue.shade500,
    Colors.blue.shade600,
    Colors.blue.shade700,
    Colors.blue.shade800,
    Colors.blue.shade900,
  ];
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.all(27.0),
        child: Text(
          "Created by Ramiz Mammadli",
          style: TextStyle(
            fontSize: 25,
            fontFamily: "dizaynFont",
            color: colors[count],
          ),
        ),
      ),
      onHorizontalDragEnd: (details) {
        if (colors.length - 1 == count) count = 0;
        setState(() => count++);
      },
    );
  }
}

var maskFormatter = MaskTextInputFormatter(
    mask: '(###)-###-##-##',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy);

MyContainer field(
  String title,
  Icon icon,
  Function(
    String value,
  )
      variable,
  bool pass,
  bool numbFormat,
  Color color,
) {
  return MyContainer(
    shadowColor: Colors.grey.shade600,
    height: 60,
    width: 300,
    boxColor: color,
    child: Center(
      child: TextField(
        inputFormatters: numbFormat
            ? [
                maskFormatter,
              ]
            : [],
        textAlignVertical: TextAlignVertical.center,
        obscureText: pass,
        decoration: InputDecoration(
          // label: Text("label"),
          border: InputBorder.none,
          prefixIcon: Padding(padding: const EdgeInsets.all(6.0), child: icon),
          prefix: const Text(" "),
          hintText: title,
          hintStyle: const TextStyle(
            fontSize: 25,
          ),
        ),
        style: const TextStyle(
          fontSize: 30,
          color: Colors.black54,
          decoration: TextDecoration.none,
          fontWeight: FontWeight.w900,
        ),
        textAlign: TextAlign.start,
        readOnly: false,
        onChanged: variable,
      ),
    ),
  );
}
