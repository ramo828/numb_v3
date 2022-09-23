import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:routetest/account/account.dart';
import 'package:shared_preferences/shared_preferences.dart';

class firebaseControls {
  FirebaseFirestore firebase = FirebaseFirestore.instance;

  Future<bool> loginControl(String login, String password) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? getReferal = sp.getString("referal");
    if (getReferal == null) throw Exception("Referal doğru deyil");
    late bool status;
    try {
      var userDoc =
          firebase.collection("users").doc(getReferal).collection('groupUsers');
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
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? getReferal = sp.getString("referal");
    if (getReferal == null) throw Exception("Referal doğru deyil");
    bool status = false;
    var userDoc =
        firebase.collection("users").doc(getReferal).collection("groupUsers");
    var userData = await userDoc.get();
    var userLength = userData.docs.length;
    for (int i = 0; i < userLength; i++) {
      var userList = userData.docs[i].data();
      var equLogin = userList["user"];
      if (equLogin == null) return false;
      if (equLogin.toLowerCase() == login.toLowerCase()) {
        status = true;
        throw Exception("Bu login artıq istifadə edilir");
      } else {
        status = false;
      }
    }
    return status;
  }

  Future<void> createUser(Accounts accounts) async {
    String user = accounts.user;
    String pass = accounts.pass;
    String name = accounts.name;
    String surname = accounts.surname;
    String number = accounts.number;
    String referans = accounts.referans;

    SharedPreferences sp = await SharedPreferences.getInstance();
    String? getReferal = sp.getString("referal");
    if (getReferal == null) throw Exception("Referal doğru deyil");

    // CollectionReference users = firebase.collection('users');
    DocumentReference<Map<String, dynamic>> users = firebase
        .collection('users')
        .doc(getReferal)
        .collection('groupUsers')
        .doc(user);

    users.set({
      'user': user,
      'password': pass,
      'name': name,
      'surname': surname,
      'number': number,
      'referans': referans
    });
  }

  void setData() {
    Map<String, dynamic> data = {'name': 'Ramiz Mammadli2'};
    var myRef = firebase.collection("users"); //test collection icinden
    myRef.doc('raufagayev').update(data); //test documentini tap
    //ve mapdaki keye gore datani deyisdir
  }

  Future<int> regLimit() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? getReferal = sp.getString("referal");
    if (getReferal == null) throw Exception("Referal doğru deyil");
    var userDoc =
        firebase.collection("users").doc(getReferal).collection("groupUsers");
    var userData = await userDoc.get();
    var userLength = userData.docs.length;
    return userLength;
  }

  void setBearerKey(String operatorKey, String bearerKey) async {
    Map<String, dynamic> data = {operatorKey.toLowerCase(): bearerKey};
    var myRef = firebase.collection("globalKey"); //test collection icinden
    await myRef.doc('key').update(data); //test documentini tap
    //ve mapdaki keye gore datani deyisdir
  }

  Future<dynamic> getUserData(String user, String key) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? getReferal = sp.getString("referal");

    if (getReferal == null) throw Exception("Referal doğru deyil");
    try {
      var userColl = firebase
          .collection("users")
          .doc(getReferal)
          .collection("groupUsers")
          .doc(user);
      var userData = await userColl.get();
      return userData[key];
    } on StateError catch (e) {
      debugPrint("Istifadeci tapilmadi");
    }
  }

  Future<bool> controlReferalAdress(String referal) async {
    var referalStatus = firebase.collection("users").doc(referal);
    var ref = await referalStatus.get();
    var rfData = ref.data();
    if (rfData == null) {
      return false;
    } else {
      return true;
    }
  }

  Future<int> getReferalID(String referal) async {
    var referalStatus = firebase.collection("users").doc(referal);
    var ref = await referalStatus.get();
    var rfData = ref.data();
    if (rfData == null) {
      return -1;
    } else {
      return rfData['id'];
    }
  }

  Future<dynamic> getData(String referal, String keyMap) async {
    var referalStatus = firebase.collection("users").doc(referal);
    var ref = await referalStatus.get();
    var rfData = ref.data();
    if (rfData == null) {
      return -1;
    } else {
      return rfData['id'];
    }
  }
}
