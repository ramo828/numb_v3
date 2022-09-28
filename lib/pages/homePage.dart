// ignore: file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:routetest/backent/firebaseControl.dart';
import 'package:routetest/backent/io/fileProvider.dart';
import 'package:routetest/elements/homePageElements.dart';
import 'package:routetest/myWidgest/myWidgets.dart';
import 'package:routetest/elements/globalElements.dart';

String _groupName = '';
int _groupLevel = 0;
bool _groupStatus = false;
int _groupID = 0;

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

  @override
  Widget build(BuildContext context) {
    groupData();
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

class active extends StatelessWidget {
  const active({
    Key? key,
  }) : super(key: key);

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
    return MyContainer(
      height: 110,
      width: 400,
      shadowColor: Colors.black,
      boxColor: Colors.grey.shade700.withOpacity(0.8),
      child: Wrap(
        children: [
          Center(
            child: Text(
              "Group: $_groupName\nİcazə: $groupLevel\nStatus: $groupStatus",
              style: TextStyle(fontSize: 28, color: Colors.blueGrey.shade100),
            ),
          ),
        ],
      ),
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
