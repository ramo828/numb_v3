import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:routetest/account/account.dart';
import 'package:routetest/backent/firebaseControl.dart';
import 'package:routetest/elements/loginElements.dart';
import 'package:routetest/myWidgest/myWidgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../elements/workElements.dart';

class register extends StatefulWidget {
  const register({super.key});
  static const routeName = "/register";
  @override
  State<register> createState() => _registerState();
}

final PageController controller = PageController();
String _user = "";
String _pass = "";
String _passTry = "";
String _name = "";
String _surname = "";
String _number = "";
String _referans = "";
late Accounts _account;

Color defaultColor = Colors.blue.shade300.withOpacity(0.8);
Color errorColor = Colors.redAccent.withOpacity(0.6);
bool notEqual = false;

class _registerState extends State<register> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const SizedBox(
            height: 10,
          ),
          CircleAvatar(
            radius: 130,
            backgroundColor: Colors.lightBlue.shade400.withOpacity(0.2),
            backgroundImage: const AssetImage("images/logo3.png"),
          ),
          MyContainer(
            width: 180,
            height: 660,
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
                    _user = value;
                  },
                  false,
                  false,
                  defaultColor,
                ),
                field(
                  'Şifrə',
                  const Icon(
                    Icons.key,
                    size: 40,
                  ),
                  (value) {
                    _pass = value;
                  },
                  true,
                  false,
                  defaultColor,
                ),
                field(
                  'Təkrar şifrə',
                  const Icon(
                    Icons.key,
                    size: 40,
                  ),
                  (value) {
                    _passTry = value;
                    setState(() {});
                    value == _pass ? notEqual = false : notEqual = true;
                  },
                  true,
                  false,
                  !notEqual ? defaultColor : errorColor,
                ),
                field(
                  'Ad',
                  const Icon(
                    Icons.person,
                    size: 40,
                  ),
                  (value) {
                    _name = value;
                  },
                  false,
                  false,
                  defaultColor,
                ),
                field(
                  'Soyad',
                  const Icon(
                    Icons.person,
                    size: 40,
                  ),
                  (value) {
                    _surname = value;
                  },
                  false,
                  false,
                  defaultColor,
                ),
                field(
                  'XXX-XX-XX',
                  const Icon(
                    Icons.phone,
                    size: 40,
                  ),
                  (value) {
                    _number = value;
                  },
                  false,
                  true,
                  defaultColor,
                ),
                field(
                  'Referans kod',
                  const Icon(
                    Icons.lock,
                    size: 40,
                  ),
                  (value) {
                    _referans = value;
                  },
                  false,
                  false,
                  defaultColor,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          MyContainer(
            height: 50,
            width: 170,
            boxColor: Colors.blue.shade200.withOpacity(0.7),
            shadowColor: Colors.grey.shade600,
            child: const Center(
              child: Text(
                "Qeydiyyat",
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
            ),
            onPress: () async {
              bool successStatus = false;
              var success = ilanBar(
                "Qeydiyyat uğurla başa çatdı.",
                "oldu",
                3000000,
                () {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                },
              );
              try {
                successStatus = await registerControl();
              } on Exception catch (e) {
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
              if (successStatus) {
                // ignore: use_build_context_synchronously
                ScaffoldMessenger.of(context).showSnackBar(success);
                Navigator.pushNamed(context, '/');
              }
            },
          ),
          const SizedBox(
            height: 5,
          ),
          const Align(
            alignment: Alignment.topLeft,
            child: Author(),
          ),
        ],
      ),
    );
  }

  Future<bool> registerControl() async {
    firebaseControls fireControl = firebaseControls();
    SharedPreferences sp = await SharedPreferences.getInstance();
    if (_pass == _passTry) {
      if (_pass.length < 8) {
        throw Exception("Şifrə ən az 8 simvoldan ibarət olmalıdır!");
      } else if (_user.length < 5) {
        throw Exception("Login ən az 5 simvoldan ibarət olmalıdır!");
      }

      if (_user.isNotEmpty &&
          _pass.isNotEmpty &&
          _passTry.isNotEmpty &&
          _name.isNotEmpty &&
          _surname.isNotEmpty &&
          _number.isNotEmpty &&
          _referans.isNotEmpty) {
        _account = Accounts(
            user: _user,
            pass: _pass,
            name: _name,
            surname: _surname,
            number: _number,
            referans: _referans);
        if (!await fireControl.controlReferalAdress(_referans))
          throw Exception("Referal adresi mövcud deyil");
        await sp.setString('referal', _referans);
        await add(_account);
        return true;
      } else {
        throw Exception("Qeydiyyat xanaları boş buraxıla bilməz!");
      }
    } else {
      throw Exception("Şifrələr eyni deyil!");
    }
  }

  Future<void> add(Accounts accounts) async {
    firebaseControls fireControl = firebaseControls();
    var data = await fireControl.existsUser(accounts.user) ?? true;
    if (data) {
      print("Error");
    } else {
      fireControl.createUser(accounts);
    }
  }
}
