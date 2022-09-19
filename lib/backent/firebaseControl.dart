import 'package:cloud_firestore/cloud_firestore.dart';

class firebaseControls {
  FirebaseFirestore firebase = FirebaseFirestore.instance;

  Future<bool> loginControl(String login, String password) async {
    late bool status;
    try {
      var userDoc = firebase.collection("users");
      var userData = await userDoc.get();
      var userLength = userData.docs.length;
      for (int i = 0; i < userLength; i++) {
        var userList = userData.docs[i].data();
        if (userList["login"] == login && userList["password"] == password) {
          status = true;
          break;
        } else {
          status = false;
        }
      }
      return status;
    } catch (e) {
      throw ("Login və ya şifrə boş buraxıla bilməaz!");
    }
  }

  void createUser(String login, String password) {
    if (login.isNotEmpty && password.isNotEmpty) {
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');
      users.add({'login': login, 'password': password});
    } else {
      throw ("Login və ya şifrə boş buraxıla bilməz!");
    }
  }
}
