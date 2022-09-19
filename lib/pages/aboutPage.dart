import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:routetest/elements/globalElements.dart';

FirebaseFirestore firebase = FirebaseFirestore.instance;
globalElements ge = globalElements();

class Haqqinda extends StatefulWidget {
  static const String routeName = "/about";

  const Haqqinda({super.key});

  @override
  State<Haqqinda> createState() => _HaqqindaState();
}

class _HaqqindaState extends State<Haqqinda> {
  @override
  Widget build(BuildContext context) {
    var about = firebase.collection('about').doc('about');

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Haqqında",
          style: TextStyle(fontSize: 35, fontFamily: 'DizaynFont'),
        ),
      ),
      // ignore: prefer_const_literals_to_create_immutables
      body: ListView(children: [
        StreamBuilder<DocumentSnapshot>(
          builder: (context, AsyncSnapshot asyncSnapshot) {
            if (asyncSnapshot.hasError) {
              return const Center(
                child: Text(
                  "Bilinməyən bir xəta baş verdi",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              );
            }
            if (asyncSnapshot.hasData) {
              var dataAbout = asyncSnapshot.data.data();
              return Padding(
                padding: EdgeInsets.all(dataAbout['padding'] as double),
                child: Center(
                  child: Column(
                    children: [
                      dataAbout['labelStatus'] as bool
                          ? Text(
                              "${dataAbout['label']}",
                              style: TextStyle(
                                color: ge.colorConvertToString(
                                  dataAbout['color'],
                                ),
                                fontSize: dataAbout['size'] as double,
                              ),
                            )
                          : Container(),
                      dataAbout['labelStatus'] as bool
                          ? SizedBox(
                              height: dataAbout['labelSpace'] as double,
                            )
                          : Container(),
                      Text(
                        "${dataAbout['msg']}",
                        style: TextStyle(
                          color: ge.colorConvertToString(
                            dataAbout['color'],
                          ),
                          fontSize: dataAbout['size'] as double,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
          stream: about.snapshots(),
        )
      ]),
    );
  }
}
