import 'package:flutter/material.dart';
import 'package:routetest/myWidgest/myWidgets.dart';
import 'package:routetest/pages/workPage.dart';

class homePage extends StatefulWidget {
  static const String routeName = "/homePage";
  final String? mesaj;
  const homePage({super.key, this.mesaj});

  @override
  State<homePage> createState() => _homePageState(mesaj);
}

class _homePageState extends State<homePage> {
  final String? mesaj;
  Color iconColor = const Color(0xff536dfe);

  _homePageState(this.mesaj);

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.grey.shade400,
        appBar: AppBar(
          backgroundColor: Colors.grey.shade600,
          centerTitle: true,
          title: Text(
            "Ana Səhifə",
            style: styleMe(15, Colors.black54),
          ),
        ),
        drawer: Drawer(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          semanticLabel: "Menyu",
          backgroundColor: Colors.grey.shade400,
          width: 220,
          child: GestureDetector(
            onTap: () => Navigator.pushNamed(context, Worker.routeName),
            child: ListView(
              children: [
                ListTile(
                  leading: Icon(
                    color: iconColor,
                    Icons.exit_to_app,
                    size: 25,
                  ),
                  title: Text(
                    textAlign: TextAlign.left,
                    "Siyahı Hazırla",
                    style: styleMe(19, Colors.white),
                    selectionColor: Colors.red,
                  ),
                )
              ],
            ),
          ),
        ),
      );
}
