import 'package:cloud_firestore/cloud_firestore.dart';

class firebaseControl {
  FirebaseFirestore firebase = FirebaseFirestore.instance;

  Future<bool> loginControl(String login, String password) async {
    late bool status;
    var userDoc = firebase.collection("users");
    var userData = await userDoc.get();
    var userLength = userData.docs.length;
    for (int i = 0; i < userLength; i++) {
      var userList = userData.docs[i].data();
      print(userList);
      print(i);
      if (userList["login"] == login && userList["password"] == password) {
        status = true;
        break;
      } else
        status = false;
    }
    return status;
  }

  void createUser(String login, String password) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    users.add({'login': login, 'password': password});
  }
}
