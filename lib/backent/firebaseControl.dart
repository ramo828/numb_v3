import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:routetest/account/account.dart';

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
        if (userList["user"] == login && userList["password"] == password) {
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

  Future<bool> existsUser(String login) async {
    bool status = false;
    var userDoc = firebase.collection("users");
    var userData = await userDoc.get();
    var userLength = userData.docs.length;
    for (int i = 0; i < userLength; i++) {
      var userList = userData.docs[i].data();
      if (userList["user"] == login) {
        status = true;
        throw Exception("Bu login artıq istifadə edilir");
      } else {
        status = false;
      }
    }
    return status;
  }

  void createUser(Accounts accounts) {
    String user = accounts.user;
    String pass = accounts.pass;
    String name = accounts.name;
    String surname = accounts.surname;
    String number = accounts.number;
    String referans = accounts.referans;

    CollectionReference users = FirebaseFirestore.instance.collection('users');
    users.add({
      'user': user,
      'password': pass,
      'name': name,
      'surname': surname,
      'number': number,
      'referans': referans
    });
  }
}
