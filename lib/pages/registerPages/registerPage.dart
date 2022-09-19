import 'package:flutter/material.dart';
import 'package:routetest/backent/firebaseControl.dart';

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
    _user = '';
    _pass = '';
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
                    try {
                      add(_user, _pass);
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
    firebaseControls fireControl = firebaseControls();
    fireControl.createUser(login, password);
  }
}
