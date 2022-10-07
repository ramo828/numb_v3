import 'package:flutter/material.dart';
import 'package:routetest/backent/firebaseControl.dart';
import 'package:routetest/elements/loginElements.dart';
import 'package:routetest/myWidgest/myWidgets.dart';
import 'package:routetest/pages/activeNumbers/work/workPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../elements/workElements.dart';

List<String>? settings = [];
List<String>? newSettings = [];
firebaseControls fc = firebaseControls();

String _bakcellKey = "";
String _narKey = "";
// ignore: prefer_typing_uninitialized_variables
var _narTime;
DateTime? _narReal;
DateTime? _bakcellReal;

// ignore: prefer_typing_uninitialized_variables
var _bakcellTime;

String _contactName = "";
String _path = "";

void initSet() async {
  settings = await initSettingData();
}

class workSettings extends StatefulWidget {
  const workSettings({super.key});
  static const routeName = "/workSettings";
  @override
  State<workSettings> createState() => _workSettingsState();
}

class _workSettingsState extends State<workSettings> {
  @override
  void initState() {
    setState(() {
      initSet();
    });
    // TODO: implement initState
    super.initState();
  }

  void getKeyUpdatedTime() {
    fc.groupsKeyData(
      (value) {
        dispose() {
          _narKey = "";
          _bakcellKey = "";
          _bakcellReal = null;
          _contactName = "";
          _bakcellTime = null;
          _narTime = "";
          _narReal = null;
        }

        if (mounted) {
          setState(() {
            _narTime = value.data()['narTime'];
            _bakcellTime = value.data()['bakcellTime'];
            _narReal = _narTime.toDate();
            _bakcellReal = _bakcellTime.toDate();
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    initSettingData();
    getKeyUpdatedTime();
    print(settings);
    var textStyle = const TextStyle(color: Colors.black);
    var labelStyle = const TextStyle(color: Colors.black, fontSize: 10);
    var timeStyle = const TextStyle(color: Colors.red, fontSize: 10);

    var fieldColor = Colors.grey.withOpacity(0.1);
    var cardColor = Colors.black12;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "WorkSettings",
        ),
      ),
      body: Center(
        child: ListView(
          children: [
            MyContainer(
              shadowColor: Colors.black,
              mesafe: 5,
              height: 640,
              width: 350,
              boxColor: Colors.grey.shade400,
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        labelField(timeStyle, "$_bakcellReal", 14),
                        labelField(labelStyle, "Bakcell key", 14),
                        Card(
                          shadowColor: Colors.blueGrey.shade300,
                          color: cardColor,
                          child: field(
                            settings![0] != null ? 'Key var' : 'Key bosdur',
                            const Icon(Icons.key),
                            (value) {
                              _bakcellKey = value;
                            },
                            false,
                            false,
                            fieldColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      labelField(timeStyle, "$_narReal", 30),
                      labelField(labelStyle, "Nar key", 30),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Card(
                          shadowColor: Colors.blueGrey.shade300,
                          color: cardColor,
                          child: field(
                            settings![1] != null ? 'Key var' : 'Key bosdur',
                            const Icon(Icons.key),
                            (value) {
                              _narKey = value;
                            },
                            false,
                            false,
                            fieldColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      labelField(labelStyle, "Kontakt adı", 30),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Card(
                          shadowColor: Colors.blueGrey.shade300,
                          color: cardColor,
                          child: field(
                            settings![2],
                            const Icon(Icons.contact_mail),
                            (value) {
                              _contactName = value;
                            },
                            false,
                            false,
                            fieldColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      labelField(labelStyle, "Faylın yolu", 30),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Card(
                          shadowColor: Colors.blueGrey.shade300,
                          color: cardColor,
                          child: field(
                            settings![3],
                            const Icon(Icons.folder),
                            (value) {
                              _path = value;
                            },
                            false,
                            false,
                            fieldColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            MyContainer(
                shadowColor: Colors.black,
                height: 40,
                width: 200,
                child: Center(
                  child: Text(
                    "Yadda saxla",
                    style: textStyle,
                  ),
                ),
                onPress: () async {
                  setState(() {});
                  SharedPreferences sp = await SharedPreferences.getInstance();

                  newSettings?.clear();
                  if (_bakcellKey.isNotEmpty) {
                    fc.setBearerKey("bakcell", _bakcellKey);
                    newSettings?.insert(0, _bakcellKey);
                  } else {
                    newSettings?.insert(0, settings![0]);
                  }
                  if (_narKey.isNotEmpty) {
                    fc.setBearerKey("nar", _narKey);

                    newSettings?.insert(1, _narKey);
                  } else {
                    newSettings?.insert(1, settings![1]);
                  }
                  if (_contactName.isNotEmpty) {
                    newSettings?.insert(2, _contactName);
                  } else {
                    newSettings?.insert(2, settings![2]);
                  }
                  if (_path.isNotEmpty) {
                    newSettings?.insert(3, _path);
                  } else {
                    newSettings?.insert(3, settings![3]);
                  }
                  print(newSettings);
                  sp.setStringList("setting", newSettings!);

                  ScaffoldMessenger.of(context).showSnackBar(
                    ilanBar(
                      "Ayarlar yükləndi",
                      "Oldu",
                      500000,
                      () {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      },
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }

  Padding labelField(TextStyle labelStyle, String text, double space) {
    return Padding(
      padding: EdgeInsets.only(left: space),
      child: Card(
        color: Colors.grey.shade400,
        child: Text(
          text,
          style: labelStyle,
        ),
      ),
    );
  }
}
