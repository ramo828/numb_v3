import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:routetest/database/db.dart';
import 'package:routetest/database/model/user.dart';
import 'package:routetest/myWidgest/myWidgets.dart';
import 'package:routetest/pages/panel/usersPanel.dart';
import 'package:routetest/pages/workPage.dart';
import 'package:routetest/elements/globalElements.dart';
// ignore: depend_on_referenced_packages
import 'package:url_launcher_platform_interface/url_launcher_platform_interface.dart';

class homePage extends StatefulWidget {
  static const String routeName = "/homePage";
  final String? mesaj;
  const homePage({super.key, this.mesaj});

  @override
  State<homePage> createState() => _homePageState();
}

FirebaseFirestore firebase = FirebaseFirestore.instance;
var update = firebase.collection('update').doc('update');

myDataBase db = myDataBase();
userDB user = userDB();
String login = "";
String pass = "";

globalElements ge = globalElements();

class _homePageState extends State<homePage> {
  @override
  void initState() {
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
      body: Column(
        children: const [
          updateController(),
        ],
      ),
    );
  }
}

class updateController extends StatelessWidget {
  const updateController({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      builder: (context, AsyncSnapshot ash) {
        if (ash.hasData) {
          var updateData = ash.data.data();
          if (updateData['updateStatus'] as bool &&
                  updateData["updateVersion"] != ge.appVersion ||
              updateData['onlyNews'] as bool) {
            return MyContainer(
              boxColor: ge.colorConvertToString(
                updateData['containerColor'],
              ),
              height: updateData['containerHeight'] as double,
              width: updateData['containerWidth'] as double,
              child: ListView(
                padding: const EdgeInsets.all(10),
                physics: const ScrollPhysics(
                  parent: BouncingScrollPhysics(),
                ),
                addSemanticIndexes: true,
                addRepaintBoundaries: true,
                primary: true,
                children: [
                  updateData['labelStatus'] as bool
                      ? Center(
                          child: Text(
                            updateData['labelText'],
                            style: TextStyle(
                              fontSize: updateData['labelSize'] as double,
                              color: ge.colorConvertToString(
                                  updateData['labelColor']),
                            ),
                          ),
                        )
                      : Container(),
                  SizedBox(
                    height: updateData['labelSpace'],
                  ),
                  updateData['versionStatus'] as bool
                      ? Center(
                          child: Text(
                            updateData['updateVersion'],
                            style: TextStyle(
                              fontSize: updateData['versionSize'] as double,
                              color: ge.colorConvertToString(
                                  updateData['versionColor']),
                            ),
                          ),
                        )
                      : Container(),
                  Center(
                    child: Text(
                      updateData['updateNews'],
                      style: TextStyle(
                        fontSize: updateData['textSize'] as double,
                        color: ge.colorConvertToString(updateData['textColor']),
                      ),
                    ),
                  ),
                  !updateData['onlyNews']
                      ? OutlinedButton(
                          onPressed: () {
                            _launchInBrowser(updateData['updateLink']);
                          },
                          child: Text(
                            updateData['buttonText'],
                            style: TextStyle(
                              fontSize: updateData['buttonSize'] as double,
                              color: ge.colorConvertToString(
                                  updateData['buttonColor']),
                            ),
                          ),
                        )
                      : Container(),
                ],
              ),
            );
          } else {
            return Container();
          }
        } else if (ash.hasError) {
          return const Center(
            child: Text("Bilinməyən xəta baş verdi"),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
      stream: update.snapshots(),
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
            onTap: () => Navigator.pushNamed(context, usersPanel.routeName),
            child: const ListTile(
              leading: Icon(
                Icons.person_add,
                size: 25,
              ),
              title: Text(
                textAlign: TextAlign.left,
                "İstifadəçi paneli",
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

Future<void> _launchInBrowser(String url) async {
  final UrlLauncherPlatform launcher = UrlLauncherPlatform.instance;

  if (!await launcher.launch(
    url,
    useSafariVC: false,
    useWebView: false,
    enableJavaScript: false,
    enableDomStorage: false,
    universalLinksOnly: false,
    headers: <String, String>{},
  )) {
    throw 'Could not launch $url';
  }
}
