import 'package:flutter/material.dart';
import 'package:routetest/database/db.dart';
import 'package:routetest/database/model/user.dart';

class register extends StatefulWidget {
  const register({super.key});
  static const routeName = "/register";
  @override
  State<register> createState() => _registerState();
}

final PageController controller = PageController();

class _registerState extends State<register> {
  final userDB _user = userDB();
  myDataBase db = myDataBase();

  @override
  void initState() {
    // TODO: implement initState
    try {
      db = myDataBase();
      db.open();
    } catch (e) {
      print(e);
    }
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
                        _user.user = value;
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
                        _user.password = value;
                      },
                    ),
                  ),
                ),
                OutlinedButton(
                  onPressed: () {
                    add();
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

  Future<void> add() async {
    List<Map<String, Object?>> user = await db.getItem(0);
    _user.id = 0;
    final netice = await db.insert(_user);
    print(user[0]['password']);
    print(user.length);
    print(netice);
  }
}
