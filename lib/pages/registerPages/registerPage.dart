import 'package:flutter/material.dart';
import 'package:routetest/backent/firebaseControl.dart';
import 'package:routetest/database/db.dart';
import 'package:routetest/database/model/user.dart';

import '../../elements/workElements.dart';

class register extends StatefulWidget {
  const register({super.key});
  static const routeName = "/register";
  @override
  State<register> createState() => _registerState();
}

final PageController controller = PageController();

late String _user;
late String _pass;

class _registerState extends State<register> {
  // final userDB _user = userDB();
  // myDataBase db = myDataBase();

  @override
  void initState() {
    // TODO: implement initState
    // try {
    //   db = myDataBase();
    //   db.open();
    // } catch (e) {
    //   print(e);
    // }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Card(
            child: Wrap(
              children: [
                Center(
                  child: SizedBox(
                    height: 50,
                    width: 200,
                    child: TextField(
                      decoration: const InputDecoration(
                        hintText: "Login",
                      ),
                      onChanged: (value) {
                        _user = value;
                      },
                    ),
                  ),
                ),
                Center(
                  child: SizedBox(
                    height: 50,
                    width: 200,
                    child: TextField(
                      decoration: const InputDecoration(
                        hintText: "Parol",
                      ),
                      onChanged: (value) {
                        _pass = value;
                      },
                    ),
                  ),
                ),
                OutlinedButton(
                  onPressed: () {
                    add(_user, _pass);
                  },
                  child: const Text("Qeydiyyat"),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void add(String login, String password) {
    try {
      firebaseControl fireControl = firebaseControl();
      fireControl.createUser(login, password);
    } catch (e) {
      var data = ilanBar(e.toString(), "Oldu", 1000000, () {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
      });
      ScaffoldMessenger.of(context).showSnackBar(data);
    }
  }
  // List<Map<String, Object?>> user = await db.getItem(0);
  // _user.id = 0;
  // final netice = await db.insert(_user);
  // print(user[0]['password']);
  // print(user.length);
  // print(netice);
}
