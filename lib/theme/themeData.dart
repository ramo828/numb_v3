import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

ThemeData default1 = ThemeData(
  // brightness: Brightness.dark,
  scaffoldBackgroundColor: Colors.grey.shade400,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.grey.shade500,
    surfaceTintColor: Colors.amber,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(5.0),
      ),
    ),
  ),
  materialTapTargetSize: MaterialTapTargetSize.padded,
  drawerTheme: DrawerThemeData(
    backgroundColor: Colors.grey.shade600.withOpacity(0.7),
    scrimColor: Colors.grey.shade200.withOpacity(0.5),
  ),
  listTileTheme: ListTileThemeData(
    textColor: Colors.amber,
    style: ListTileStyle.drawer,
    iconColor: Colors.blue.shade400,
    minLeadingWidth: 0,
    minVerticalPadding: 0,
  ),
  textTheme: TextTheme(
    bodyText1: TextStyle(
      fontSize: 21.0,
      // fontFamily: 'esasFont',
      color: Colors.grey.shade300,
    ),
    bodyText2: const TextStyle(
      fontSize: 25.0,
      // fontFamily: 'esasFont',
      color: Colors.white,
    ),
  ),
  hintColor: Colors.white,
  // fontFamily: 'esasFont',
  dataTableTheme: DataTableThemeData(
    headingTextStyle: TextStyle(
      // fontFamily: 'esasFont',
      fontSize: 20,
      color: Colors.purple.shade500,
    ),
  ),
  snackBarTheme: SnackBarThemeData(
    backgroundColor: Colors.black.withOpacity(0.5),
    actionTextColor: Colors.white,
    contentTextStyle: const TextStyle(
      color: Colors.white,
      // fontFamily: 'esasFont',
      fontSize: 20,
    ),
  ),
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    circularTrackColor: Colors.pink,
    refreshBackgroundColor: Colors.purple,
    linearTrackColor: Colors.deepPurple,
    color: Colors.amber,
  ),
);

ThemeData dark = ThemeData.dark();

// ignore: unused_element
class themeWrite with ChangeNotifier {
  bool _dark = true;
  bool _darkDef = true;

  void themeInit() async {
    _darkDef = await getMode;
    debugPrint("Dark : ${_darkDef}");
    notifyListeners();
  }

  void toggle() async {
    await getMode ? _dark = false : _dark = true;
    saveData(_dark);
    _darkDef = await getMode;
    debugPrint("$_darkDef");
    notifyListeners();
  }

  ThemeData get theme {
    if (_darkDef == true)
      return dark;
    else
      return default1;
  }

  void saveData(bool value) async {
    SharedPreferences sp = await SharedPreferences.getInstance();

    sp.setBool("dark", value);
  }

  Future<bool> get getMode async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    bool value = await sp.getBool("dark")!;
    if (value != null)
      return value;
    else
      return false;
  }

  bool get getThemeMode {
    return _darkDef;
  }
}
