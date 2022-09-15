// ignore: camel_case_types
class func {
  String splitNumberData(String data) {
    // ignore: unnecessary_null_comparison
    if (data.isNotEmpty || data != null) {
      String pref = data.substring(0, 2);
      String a1 = data.substring(2, 5);
      String a2 = data.substring(5, 7);
      String a3 = data.substring(7, 9);

      return "0$pref-$a1-$a2-$a3";
    } else {
      throw ("Boş və ya null data göndərilə bilməz!");
    }
  }
}
