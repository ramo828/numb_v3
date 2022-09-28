import 'dart:io';

class fileProvider {
//

  Future makeFile(String file) async {
    // var faylYolu = await getExternalPath;
    var faylYolu = "/sdcard/work/";
    return File(faylYolu + file);
  }

  Future fileWrite(String text, String file) async {
    var myFile = await makeFile(file);
    return myFile.writeAsString(text);
    // , mode: FileMode.append
  }

  Future<String> readFile(String file) async {
    try {
      var myFile = await makeFile(file);

      String rFile = await myFile.readAsStringSync();
      return rFile;
    } catch (exception) {
      throw Exception(exception);
    }
  }
}
