import 'package:flutter/material.dart';
import 'package:routetest/database/db.dart';
import 'package:routetest/database/model/user.dart';
import 'package:routetest/pages/workPage.dart';

class homePage extends StatefulWidget {
  static const String routeName = "/homePage";
  final String? mesaj;
  const homePage({super.key, this.mesaj});

  @override
  State<homePage> createState() => _homePageState();
}

myDataBase db = myDataBase();
userDB user = userDB();
String login = "";
String pass = "";

class _homePageState extends State<homePage> {
  Future<void> getUser() async {
    // ignore: non_constant_identifier_names
    List<Map<String, Object?>> user = await db.getItem(0);
    login = user[0]['user'].toString();
    pass = user[0]['password'].toString();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    var textStyle = const TextStyle(
      color: Colors.orange,
      fontSize: 30,
    );
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Ana Səhifə",
        ),
      ),
      drawer: const myDrawer(),
      body: Card(
        color: Colors.blueAccent.shade100.withOpacity(0.5),
        child: Wrap(
          children: [
            Center(
              child: Text(
                login,
                style: textStyle,
              ),
            ),
            Center(
              child: Text(
                pass,
                style: textStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class myDrawer extends StatelessWidget {
  const myDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      semanticLabel: "Menyu",
      width: 220,
      child: ListView(
        children: [
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, Worker.routeName),
            child: const ListTile(
              leading: Icon(
                Icons.list,
                size: 25,
              ),
              title: Text(
                textAlign: TextAlign.left,
                "Siyahı Hazırla",
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              db.clearDB();
              Navigator.pushNamed(context, '/');
            },
            child: const ListTile(
              leading: Icon(
                Icons.list,
                size: 25,
              ),
              title: Text(
                textAlign: TextAlign.left,
                "Çıxış",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
