import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:routetest/account/account.dart';
import 'package:shared_preferences/shared_preferences.dart';

class firebaseControls {
  FirebaseFirestore firebase = FirebaseFirestore.instance;

  loginEqulizer() {}

  Future<bool> loginControl(String login, String password) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    late bool status;
    try {
      var referalList = await firebase.collection("users").get();
      var referalLength = referalList.docs.length;
      for (int j = 0; j < referalLength; j++) {
        print(referalList.docs[j]["referalName"]);
        var userDoc = firebase
            .collection("users")
            .doc(referalList.docs[j]["referalName"])
            .collection('groupUsers');
        var userData = await userDoc.get();
        var userLength = userData.docs.length;
        for (int i = 0; i < userLength; i++) {
          var userList = userData.docs[i].data();
          if (userList["user"] == login && userList["password"] == password) {
            sp.setString("referal", referalList.docs[j]["referalName"]);
            status = true;
            break;
          } else {}
        }
      }
      return status;
    } catch (e) {
      print(e);
      throw ("Login və ya şifrə yanlışdır!");
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

// bearer keyi guncellemek ucun
  void setBearerKey(String operatorKey, String bearerKey) async {
    var now = DateTime.now();
    Map<String, dynamic> data = {
      operatorKey.toLowerCase(): bearerKey,
      operatorKey == "nar" ? 'narTime' : 'bakcellTime': now
    };
    var myRef = firebase.collection("globalKey"); //test collection icinden
    await myRef.doc('key').update(data); //test documentini tap
    //ve mapdaki keye gore datani deyisdir
  }

//isstifadeci bilgilerini almaq ucun
  void userData(Function(dynamic value) fn) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? getReferal = sp.getString("referal");
    String? login = sp.getString("id");

    if (getReferal == null && login == null) {
      throw Exception("Referal doğru deyil");
    }
    try {
      firebase
          .collection("users")
          .doc(getReferal)
          .collection("groupUsers")
          .doc(login)
          .get()
          .then(fn);
    } catch (e) {
      Exception(e);
    }
  }

//group bilgilerini almaq ucun
  void groupData(Function(dynamic value) fn) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? getReferal = sp.getString("referal");

    if (getReferal == null) throw Exception("Referal doğru deyil");
    firebase.collection("users").doc(getReferal).get().then(fn);
  }

// Guncel key varsa onu guncellemek ucun
  void groupsKeyData(Function(dynamic value) fn) async {
    firebase.collection("globalKey").doc('key').get().then(fn);
  }

//referal adresinin movcudlugunu yoxlamaq ucun
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
}
