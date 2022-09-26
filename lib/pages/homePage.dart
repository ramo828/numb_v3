
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:routetest/backent/firebaseControl.dart';
import 'package:routetest/myWidgest/myWidgets.dart';
import 'package:routetest/pages/aboutPage.dart';
import 'package:routetest/pages/panel/usersPanel.dart';
import 'package:routetest/pages/settingsPage.dart';
import 'package:routetest/pages/workPage.dart';
import 'package:routetest/elements/globalElements.dart';
import 'package:routetest/theme/themeData.dart';
import 'package:shared_preferences/shared_preferences.dart';
// ignore: depend_on_referenced_packages
import 'package:url_launcher_platform_interface/url_launcher_platform_interface.dart';

String _name = '';
String _surname = '';
String _groupName = '';
int _groupLevel = 0;
bool _groupStatus = false;
int _groupID = 0;

FirebaseFirestore _firebase = FirebaseFirestore.instance;
firebaseControls fc = firebaseControls();
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
  void userData() {
    fc.userData(
      (value) {
        setState(() {
          var allData = value.data();
          if (allData != null) {
            _name = allData['name'];
            _surname = allData['surname'];
          }
        });
      },
    );
  }

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
    userData();
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

class passive extends StatelessWidget {
  const passive({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text("Status aktiv deyil");
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
      height: 100,
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
          MyContainer(
            boxColor: Colors.grey.shade700,
            shadowColor: Colors.black,
            height: 300,
            width: 400,
            child: Wrap(
              spacing: 2,
              alignment: WrapAlignment.center,
              direction: Axis.vertical,
              children: const [],
            ),
          )
        ],
      ),
    );
  }
}

TextStyle textGroup = const TextStyle(
  fontSize: 20,
  color: Colors.blueAccent,
);

class updateController extends StatelessWidget {
  const updateController({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StreamBuilder<DocumentSnapshot>(
          builder: (context, AsyncSnapshot ash) {
            if (ash.hasData) {
              var updateData = ash.data.data();
              if (updateData['updateStatus'] as bool &&
                      updateData["updateVersion"] != ge.appVersion ||
                  updateData['onlyNews'] as bool) {
                return updateNotifier(updateData: updateData);
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
        ),
        //
      ],
    );
  }
}

class updateNotifier extends StatelessWidget {
  const updateNotifier({
    Key? key,
    required this.updateData,
  }) : super(key: key);

  final updateData;

  @override
  Widget build(BuildContext context) {
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
                      color: ge.colorConvertToString(updateData['labelColor']),
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
                      color:
                          ge.colorConvertToString(updateData['versionColor']),
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
                      color: ge.colorConvertToString(updateData['buttonColor']),
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}

class myDrawer extends StatefulWidget {
  const myDrawer({
    Key? key,
  }) : super(key: key);

  @override
  State<myDrawer> createState() => _myDrawerState();
}

class _myDrawerState extends State<myDrawer> {
  bool nightAndLightModeStatus = true;
  firebaseControls fc = firebaseControls();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<themeWrite>(
      create: (context) {
        return themeWrite();
      },
      child: Drawer(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        semanticLabel: "Menyu",
        width: 220,
        child: ListView(
          children: [
            Row(
              children: [
                nightMode(context),
              ],
            ),
            MyContainer(
              boxColor: Colors.grey.shade800.withOpacity(0.1),
              shadowColor: Colors.grey,
              height: 77,
              width: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                            backgroundColor: Colors.deepPurple.withOpacity(0.3),
                            child: const Icon(Icons.person_outline_sharp)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "$_name\n$_surname\n($_groupName)",
                          style: TextStyle(
                              fontSize: 17, color: Colors.blue.shade200),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
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
              onTap: () => Navigator.pushNamed(context, Haqqinda.routeName),
              child: const ListTile(
                leading: Icon(
                  Icons.info,
                  size: 25,
                ),
                title: Text(
                  textAlign: TextAlign.left,
                  "Haqqında",
                ),
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, Ayarlar.routeName),
              child: const ListTile(
                leading: Icon(
                  Icons.settings,
                  size: 25,
                ),
                title: Text(
                  textAlign: TextAlign.left,
                  "Ayarlar",
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                logOut();
                Navigator.pushNamed(context, "/");
                // exit(1);
              },
              child: const ListTile(
                leading: Icon(
                  Icons.exit_to_app,
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
      ),
    );
  }

  Padding nightMode(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: Alignment.centerRight,
        child: IconButton(
          onPressed: () {
            setState(() {
              nightAndLightModeStatus == true
                  ? nightAndLightModeStatus = false
                  : nightAndLightModeStatus = true;
            });
            Provider.of<themeWrite>(context, listen: false).toggle();
          },
          icon: Icon(
            nightAndLightModeStatus
                ? FontAwesomeIcons.sun
                : FontAwesomeIcons.moon,
            size: 40,
            color: nightAndLightModeStatus ? Colors.orange : Colors.blue,
          ),
        ),
      ),
    );
  }
}

Future<void> logOut() async {
  SharedPreferences sp = await SharedPreferences.getInstance();
  sp.setBool('logIN', false);
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
