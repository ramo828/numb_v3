import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:routetest/elements/loginElements.dart';

FirebaseFirestore firebase = FirebaseFirestore.instance;
var users = firebase.collection('users'); // Firebase collection

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
      ),
      body: Column(
        children: const [
          uPanel(),
        ],
      ),
    );
  }
}

class uPanel extends StatelessWidget {
  const uPanel({
    Key? key,
  }) : super(key: key);

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
                      )),
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
      stream: users.snapshots(),
    );
  }
}
