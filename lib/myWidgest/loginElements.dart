import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:routetest/pages/homePage.dart';
import '../pages/aboutPage.dart';
import '../pages/workPage.dart';
import 'myWidgets.dart';
import '../pages/registerPages/registerPage.dart';

class loginPage extends StatefulWidget {
  const loginPage({super.key});

  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  String login = "";
  String pass = "";
  String fillSep = " ";
  bool visiblePass = true;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 10,
          ),
          CircleAvatar(
            radius: 130,
            backgroundColor: Colors.lightBlue.shade400,
            backgroundImage: const AssetImage("images/black_cat.jpg"),
          ),
          //Container login and password
          MyContainer(
            height: 180,
            width: 600,
            boxColor: Colors.grey.shade400,
            shadowColor: Colors.grey.shade600,
            child: Column(
              children: [
                MyContainer(
                  shadowColor: Colors.grey.shade600,
                  height: 60,
                  width: 300,
                  boxColor: Colors.blue.shade300,
                  child: Center(
                    child: TextField(
                      textAlignVertical: TextAlignVertical.center,

                      //login

                      decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: const Icon(
                            Icons.person,
                            size: 40,
                          ),
                          prefix: const Text(" "),
                          hintText: 'İstifadəçi adı',
                          hintStyle: styleMe(30, Colors.grey.shade300)),
                      style: styleMe(30, Colors.blueGrey),
                      textAlign: TextAlign.start,
                      readOnly: false,
                      onChanged: (value) {
                        setState(() {
                          login = value;
                        });
                      },
                    ),
                  ),
                ),
                MyContainer(
                  shadowColor: Colors.grey.shade600,
                  height: 60,
                  width: 300,
                  boxColor: Colors.blue.shade300,
                  child: Center(
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
                          hintStyle: styleMe(30, Colors.grey.shade300)),
                      style: styleMe(30, Colors.blueGrey),
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
              ],
            ),
          ),
          loginButton(login: login, pass: pass),
          const SizedBox(
            height: 120,
          ),

          //button
          const Align(alignment: Alignment.topLeft, child: Author()),
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
    return MyContainer(
      height: 50,
      width: 170,
      boxColor: Colors.blue.shade200,
      shadowColor: Colors.grey.shade600,
      onPress: (() {
        if ((login == "Ramo828" && pass == "ramiz123")) {
          Navigator.pushNamed(context, homePage.routeName);
        } else {
          showDialog(
              context: context, builder: (context) => const myAlertBox());
        }
      }),
      child: Center(
        child: Text(
          "Daxil ol",
          style: styleMe(30, Colors.black54),
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
            Navigator.pushNamed(context, register.routeName);
          },
          child: ListTile(
            leading: Icon(
              color: iconColor,
              Icons.app_registration_outlined,
              size: 25,
            ),
            title: Text(
              textAlign: TextAlign.left,
              "Qeydiyyat",
              style: styleMe(16, Colors.white),
              selectionColor: Colors.red,
            ),
          ),
        ),
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
            title: Text(
              textAlign: TextAlign.left,
              "Haqqında",
              style: styleMe(16, Colors.white),
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
            title: Text(
              textAlign: TextAlign.left,
              "Çıxış",
              style: styleMe(16, Colors.white),
              selectionColor: Colors.red,
            ),
          ),
        ),
        OutlinedButton(
          onPressed: () {
            Navigator.pushNamed(context, Worker.routeName);
          },
          child: ListTile(
            leading: Icon(
              color: iconColor,
              Icons.exit_to_app,
              size: 25,
            ),
            title: Text(
              textAlign: TextAlign.left,
              "Test",
              style: styleMe(16, Colors.white),
              selectionColor: Colors.red,
            ),
          ),
        )
      ],
    );
  }
}

class myAlertBox extends StatelessWidget {
  final String message;
  final String title;
  // final Color backgroundColor;
  final Icon icon;

  final String buttonText;

  const myAlertBox(
      {super.key,
      this.message = "İstifadəçi adı və ya şifrə xətalıdır!",
      this.title = "",
      this.icon = const Icon(
        Icons.error,
        color: Colors.deepOrangeAccent,
        size: 140,
      ),
      this.buttonText = "Oldu"});

  @override
  Widget build(BuildContext context) => AlertDialog(
        title: Text(title),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(30.0),
          ),
        ),
        backgroundColor: const Color(0xff805ba4),
        iconPadding: const EdgeInsets.all(5),
        icon: icon,
        alignment: Alignment.center,
        content: Text(message,
            textAlign: TextAlign.center,
            style: styleMe(30, Colors.red.shade300)),
        actions: [
          Center(
            child: MyContainer(
              shadowColor: const Color(0xff492b66),
              boxColor: const Color(0xffb495d1),
              height: 60,
              width: 120,
              radius: 15,
              mesafe: 15,
              shadowRadius: 10,
              child: Center(
                child: Text(
                  buttonText,
                  style: styleMe(25, Colors.black54),
                ),
              ),
              onPress: () {
                Navigator.pop(context);
              },
            ),
          )
        ],
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
      child: Text(
        "Created by Ramiz Mammadli",
        style: TextStyle(
          fontSize: 22,
          fontFamily: "dizaynFont",
          color: colors[count],
        ),
      ),
      onHorizontalDragEnd: (details) {
        if (colors.length - 1 == count) count = 0;
        setState(() => count++);
      },
    );
  }
}
