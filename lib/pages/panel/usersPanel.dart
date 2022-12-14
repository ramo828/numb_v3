import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:routetest/elements/loginElements.dart';
import 'package:routetest/myWidgest/myWidgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

FirebaseFirestore firebase = FirebaseFirestore.instance;
var users = firebase.collection('users'); // Firebase collection
String? referalID;

class usersPanel extends StatefulWidget {
  static const routeName = "/panel/users";
  const usersPanel({super.key});

  @override
  State<usersPanel> createState() => _usersPanelState();
}

class _usersPanelState extends State<usersPanel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Istifadəçi paneli"),
        centerTitle: true,
      ),
      body: Column(
        children: const [
          Center(
            child: MyContainer(
              height: 600,
              width: 350,
              child: uPanel(),
            ),
          ),
        ],
      ),
    );
  }
}

class uPanel extends StatefulWidget {
  const uPanel({
    Key? key,
  }) : super(key: key);

  @override
  State<uPanel> createState() => _uPanelState();
}

class _uPanelState extends State<uPanel> {
  Future<void> getReferalData() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    referalID = sp.getString("referal") ?? "bos";
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getReferalData();
    print("OK");
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      builder: (context, AsyncSnapshot ash) {
        if (ash.hasData) {
          List<DocumentSnapshot> usersList = ash.data.docs;
          return Expanded(
            child: ListView.builder(
              itemCount: usersList.length,
              itemBuilder: (context, index) {
                Map userMap = usersList[index].data() as Map;
                return Card(
                  child: ListTile(
                    title: Text(
                      userMap['user'],
                      textAlign: TextAlign.center,
                    ),
                    onTap: () {
                      print(index);
                      print(referalID);
                    },
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => myAlertBox(
                            icon: Icon(
                              Icons.info,
                              size: 50,
                              color: Colors.deepOrange.withOpacity(0.3),
                            ),
                            message: "Istifadəçi silinəcək. Əminsiniz?",
                            widgetList: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: OutlinedButton(
                                      onPressed: () async {
                                        await usersList[index]
                                            .reference
                                            .delete();
                                        Navigator.pop(context);
                                      },
                                      child: const Text(
                                        "Sil",
                                        style: TextStyle(
                                          fontSize: 25,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: OutlinedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text(
                                        "İmtina",
                                        style: TextStyle(
                                          fontSize: 25,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          useSafeArea: true,
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          );
        } else if (ash.hasError) {
          return const Text("Error");
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
      stream: users.doc(referalID).collection("groupUsers").snapshots(),
    );
  }
}
