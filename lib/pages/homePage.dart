// ignore: file_names

// ignore_for_file: unnecessary_null_comparison

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:routetest/backent/firebaseControl.dart';
import 'package:routetest/backent/io/fileProvider.dart';
import 'package:routetest/elements/homePageElements.dart';
import 'package:routetest/myWidgest/myWidgets.dart';
import 'package:routetest/elements/globalElements.dart';
import 'package:routetest/pages/activeNumbers/activePage.dart';
import 'package:routetest/pages/activeNumbers/work/workPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../elements/workElements.dart';

String _groupName = '';
int _groupLevel = 0;
bool _groupStatus = false;
// ignore: unused_element
int _groupID = 0;
String _narKey = "";
String _bakcellKey = "";
var userName = "";
var userPass = "";

FirebaseFirestore _firebase = FirebaseFirestore.instance;
firebaseControls fc = firebaseControls();
fileProvider fp = fileProvider();

var update = _firebase.collection('update').doc('update');
var users = _firebase.collection('users'); // Firebase collection

class homePage extends StatefulWidget {
  static const String routeName = "/homePage";

  const homePage({
    super.key,
  });

  @override
  // ignore: no_logic_in_create_state
  State<homePage> createState() {
    return _homePageState();
  }
}

globalElements ge = globalElements();

class _homePageState extends State<homePage> {
  @override
  void initState() {
    requestPermision();
    initNumberData();
    super.initState();
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
      body: const homeScreenBegin(),
    );
  }
}

class homeScreenBegin extends StatefulWidget {
  const homeScreenBegin({
    Key? key,
  }) : super(key: key);

  @override
  State<homeScreenBegin> createState() => _homeScreenBeginState();
}

class _homeScreenBeginState extends State<homeScreenBegin> {
  void groupData() {
    fc.groupData((value) {
      setState(() {
        _groupName = value.data()['groupName'];
        _groupStatus = value.data()['status'] ?? false;
        _groupLevel = value.data()['level'];
        _groupID = value.data()['id'];
      });
    });
  }

  void userControl() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    List<String> userControlData = sp.getStringList("controlUser") ?? [];

    Future.delayed(const Duration(seconds: 5), () async {
      try {
        if (await fc.loginControl(userControlData[0], userControlData[1])) {
        } else {
          logOut();
        }
      } catch (e) {
        var xeta = ilanBar(
          e.toString(),
          "oldu",
          3000000,
          () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        );

        ScaffoldMessenger.of(context).showSnackBar(xeta);
        Future.delayed(const Duration(seconds: 3), () {
          logOut();
        });
      }
    });
  }

  void groupKeyData() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    List<String>? settingData = sp.getStringList("setting");
    List<String> referansSetting = [];

    fc.groupsKeyData(
      (value) {
        _narKey = value['nar'];
        _bakcellKey = value['bakcell'];
      },
    );
    referansSetting.insert(0, _bakcellKey);
    referansSetting.insert(1, _narKey);
    referansSetting.insert(2, settingData![2]);
    referansSetting.insert(3, settingData[3]);
    sp.setStringList("setting", referansSetting);
  }

  @override
  Widget build(BuildContext context) {
    groupData();
    groupKeyData();
    userControl();
    return ListView(
      children: [
        const updateController(),
        Center(
          child: _groupStatus ? const active() : const passive(),
        )
      ],
    );
  }
}

class active extends StatefulWidget {
  const active({
    Key? key,
  }) : super(key: key);

  @override
  State<active> createState() => _activeState();
}

class _activeState extends State<active> {
  bool pane1 = false;
  bool pane2 = false;
  bool pane3 = false;

  var startButtonStyle = TextStyle(
    fontSize: 30,
    color: Colors.blueGrey.withOpacity(0.9),
  );
  @override
  Widget build(BuildContext context) {
    String groupLevel = _groupLevel == 0
        ? "İcazəniz yoxdur"
        : _groupLevel == 1
            ? "Sadə"
            : _groupLevel == 2
                ? "Xüsusi"
                : _groupLevel == 3
                    ? "VİP"
                    : "Developer";
    String groupStatus = _groupStatus ? "Aktiv" : "Passiv";
    return Column(
      children: [
        MyContainer(
          height: 110,
          width: 400,
          shadowColor: Colors.blueGrey,
          boxColor: Colors.blueGrey.shade200,
          child: Wrap(
            children: [
              Center(
                child: Text(
                  "Group: $_groupName\nİcazə: $groupLevel\nStatus: $groupStatus",
                  style: const TextStyle(fontSize: 28, color: Colors.blueGrey),
                ),
              ),
            ],
          ),
        ),
        _groupStatus
            ? SizedBox(
                width: 350,
                child: ExpansionPanelList(
                  animationDuration: const Duration(milliseconds: 600),
                  expansionCallback: (int index, bool isExpanded) {
                    setState(() {
                      if (index == 0) {
                        isExpanded ? pane1 = false : pane1 = true;
                      } else if (index == 1) {
                        isExpanded ? pane2 = false : pane2 = true;
                      }
                    });
                  },
                  children: [
                    ExpansionPanel(
                      backgroundColor: Colors.blueGrey.shade200,
                      canTapOnHeader: true,
                      headerBuilder: (BuildContext context, bool isExpanded) {
                        return Center(
                          child: ListTile(
                            leading: const Icon(FontAwesomeIcons.pen),
                            title: Padding(
                              padding: const EdgeInsets.only(left: 40),
                              child: Text(
                                'Siyahı hazırla',
                                style: textInfo,
                              ),
                            ),
                          ),
                        );
                      },
                      body: ListTile(
                        subtitle: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              """Bu özəlliklə sistemda satışda olan nömrələri TXT,VCF, CSV və google CSV olaraq cihaz yaddaşına qeyd edə bilər.""",
                              style: textInfo,
                            ),
                          ),
                        ),
                        title: Center(
                          child: GestureDetector(
                            onTap: (() =>
                                Navigator.pushNamed(context, Worker.routeName)),
                            child: MyContainer(
                              boxColor: Colors.blue.shade200,
                              shadowColor: Colors.blue,
                              height: 50,
                              width: 100,
                              child: Center(
                                child: Text(
                                  "Başla",
                                  style: startButtonStyle,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      isExpanded: pane1,
                    ),
                    ExpansionPanel(
                      backgroundColor: Colors.blueGrey.shade200,
                      canTapOnHeader: true,
                      headerBuilder: (BuildContext context, bool isExpanded) {
                        return Center(
                          child: ListTile(
                            leading: const Icon(Icons.whatsapp),
                            title: Padding(
                              padding: const EdgeInsets.only(left: 40),
                              child: Text(
                                'Aktiv nömrələri tap',
                                style: textInfo,
                              ),
                            ),
                          ),
                        );
                      },
                      body: ListTile(
                        subtitle: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              """Bu özəlliklə sistemda aktiv şəkildə istifadə olunan nömrələri TXT,VCF, CSV və google CSV olaraq cihaz yaddaşına qeyd edə bilər.
                                """,
                              style: textInfo,
                            ),
                          ),
                        ),
                        title: Center(
                          child: GestureDetector(
                            onTap: (() => Navigator.pushNamed(
                                context, activePage.routeName)),
                            child: MyContainer(
                              boxColor: Colors.blue.shade200,
                              shadowColor: Colors.blue,
                              height: 50,
                              width: 100,
                              child: Center(
                                child: Text(
                                  "Başla",
                                  style: startButtonStyle,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      isExpanded: pane2,
                    ),
                  ],
                ),
              )
            : Container(),
      ],
    );
  }
}

Future<void> requestPermision() async {
  var status = await Permission.storage.status;
  var status1 = await Permission.manageExternalStorage.status;

  if (!status.isGranted) {
    await Permission.storage.request();
  } else if (!status1.isGranted) {
    await Permission.manageExternalStorage.request();
  } else {}
}
