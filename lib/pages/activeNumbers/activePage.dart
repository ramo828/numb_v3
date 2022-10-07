import 'package:flutter/material.dart';
import 'package:routetest/elements/homePageElements.dart';
import 'package:routetest/elements/workElements.dart';
import 'package:routetest/myWidgest/myWidgets.dart';
import 'package:routetest/pages/activeNumbers/activeNetwork.dart';
import 'package:routetest/pages/activeNumbers/work/workNumberList.dart';
import 'package:routetest/pages/activeNumbers/work/workPage.dart';

bool isEnd = false;
List<String> myListReal = [];
List<String> myListReferance = [];
String operator = "";
bool statusActive = false;
activeNetwork net = activeNetwork();
int lastNumberCount = 0;
int activeNumberCount = 0;
bool stop = false;
bool isDown = false;
bool _isLoading = false;
List<String> _activePopMenu = ["Text", "VCF"];

class activePage extends StatefulWidget {
  static const routeName = "/activePage";
  const activePage({super.key});

  @override
  State<activePage> createState() => _activePageState();

  void addList(String numData) {
    myListReal.add(numData);
  }
}

void initNumberData() async {
  try {
    myListReferance.clear();
    myListReferance = await net.readNumberList();
  } catch (e) {
    print(e);
  }
  // print(myListReferance);
}

class _activePageState extends State<activePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          _isLoading
              ? const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  ),
                )
              : Container(),
          isEnd == false ? myPopMenu() : Container(),
        ],
        centerTitle: true,
        title: const Text(
          "ActivePage",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            isEnd ? const LinearProgressIndicator() : Container(),
            MyContainer(
              height: 140,
              width: 300,
              shadowColor: Colors.grey,
              boxColor: Colors.grey.shade300,
              child: Column(
                children: [
                  MyContainer(
                    boxColor: Colors.grey.shade100,
                    mesafe: 5,
                    height: 30,
                    width: 300,
                    child: Center(
                      child: Text(
                        "Axtarılacaq nömrələr: ${(myListReferance.length - lastNumberCount) == 1 ? 0 : (myListReferance.length - lastNumberCount)}",
                        style: textInfo,
                      ),
                    ),
                  ),
                  MyContainer(
                    boxColor: Colors.grey.shade100,
                    mesafe: 5,
                    height: 40,
                    width: 300,
                    child: Center(
                      child: Text(
                        "Tapılan nömrələr: $activeNumberCount",
                        style: textInfo,
                      ),
                    ),
                  ),
                  operator.isNotEmpty
                      ? MyContainer(
                          boxColor: Colors.grey.shade100,
                          mesafe: 5,
                          height: 30,
                          width: 300,
                          child: Center(
                              child: Text(
                            "Prefix: ${operator.substring(3, operator.length)}",
                            style: textInfo,
                          )),
                        )
                      : MyContainer(
                          boxColor: Colors.grey.shade100,
                          mesafe: 5,
                          height: 30,
                          width: 300,
                          child: Center(
                              child: Text(
                            "Prefix: ",
                            style: textInfo,
                          )),
                        ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Container(
                height: 450,
                width: 300,
                color: Colors.grey.shade300,
                child: ListView.builder(
                  itemCount: myListReal.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      tileColor: Colors.grey.shade300.withOpacity(0.1),
                      title: Center(
                        child: Text(
                          "${index + 1} - ${myListReal[index]}",
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            MyContainer(
              mesafe: 10,
              shadowColor: Colors.grey,
              height: 50,
              width: 300,
              radius: 10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                    style: const ButtonStyle(
                        animationDuration: Duration(seconds: 1)),
                    onPressed: () async {
                      if (myListReferance.isNotEmpty) {
                        setState(() {
                          isEnd = true;
                          stop = false;
                          myListReal.clear();
                          activeNumberCount = 0;
                          lastNumberCount = myListReal.length;
                        });
                        for (var numberActive in myListReferance) {
                          if (stop) {
                            break;
                          }

                          await controlOperator(numberActive);
                        }
                        isEnd = false;
                        ScaffoldMessenger.of(context).showSnackBar(
                          ilanBar(
                            "Aktiv nömrə sayı: ${myListReal.length}",
                            "Oldu",
                            4000000,
                            () {
                              ScaffoldMessenger.of(context)
                                  .hideCurrentSnackBar();
                            },
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          ilanBar(
                            "Siyahı boşdur",
                            "Oldu",
                            500000,
                            () {
                              ScaffoldMessenger.of(context)
                                  .hideCurrentSnackBar();
                            },
                          ),
                        );
                      }
                    },
                    child: const Text("Yoxla"),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      setState(() {
                        stop = false;
                        myListReal.clear();
                        activeNumberCount = 0;
                        lastNumberCount = myListReal.length;
                        initNumberData();
                      });
                    },
                    child: const Text("Yenilə"),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      setState(() {
                        activeNumberCount = 0;
                        stop = true;
                        lastNumberCount = myListReal.length;
                      });
                    },
                    child: const Text("Durdur"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> controlOperator(String number) async {
    List<String> globalPrefix = [];
    if (number.length >= 9) {
      var prefixInput = number.substring(0, 2);
      if (prefixInput == "55") {
        globalPrefix = ["99499", "99470", "99477"];
        prefixInput = "99";
      } else if (prefixInput == "99") {
        globalPrefix = ["99455", "99470", "99477"];
        prefixInput = "55";
      } else if (prefixInput == "70") {
        globalPrefix = ["99477", "99455", "99499"];
      } else if (prefixInput == "77") {
        globalPrefix = ["99470", "99455", "99499"];
      }
      await global(number, globalPrefix, prefixInput);
    }
    setState(() {
      lastNumberCount++;
    });
  }

  Future<void> global(
    String number,
    List<String> prefixList,
    String prefixInput,
  ) async {
    List<String> pref = [];

    try {
      for (int i = 0; i < prefixList.length; i++) {
        if (prefixList[i] == "99455" || prefixList[i] == "99499") {
          setState(() {
            operator = prefixList[i];
          });
          print("Bakcell");
          pref.clear();
          if (prefixList[i] == "99455") {
            pref.add("055");
          } else if (prefixList[i] == "99499") {
            pref.add("099");
          }
          statusActive = await net
              .activeNUmbersBakcell(
                  number.substring(2, number.length), prefixInput)
              .then((value) => !value);
        } else if (prefixList[i] == "99470" || prefixList[i] == "99477") {
          setState(() {
            operator = prefixList[i];
          });
          print("Nar");
          pref.clear();
          if (prefixList[i] == "99470") {
            pref.add("070");
          } else if (prefixList[i] == "99477") {
            pref.add("077");
          }
          statusActive = await net
              .activeNumbers(
                  "${prefixList[i]}${number.substring(2, number.length)}")
              .then((value) => value);
        }
        if (statusActive) {
          setState(() {
            myListReal.add("${pref[0]}${number.substring(2, number.length)}");
            activeNumberCount++;
          });
        }
        operator = "";
        operator = "";
      }
    } catch (e, stack) {
      ScaffoldMessenger.of(context).showSnackBar(
        ilanBar(
          "$e\n$stack",
          "Oldu",
          4000000,
          () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      );
    }
  }

  void exportData(int index) async {
    switch (index) {
      case 0:
        TXT();
        break;
      case 1:
        VCF();
        break;
      case 2:
        // CSV();
        break;
      case 3:
        // googleCSV();
        break;
      default:
        throw Exception("Bilinməyən index");
    }
  }

  void VCF() async {
    setState(() {
      //tusa basildigi anda loadinbari aktif et
      isLoading = true;
    });
    const numberList().clearData();
    testType =
        await const numberList().writeVCFraw(myListReal); // nomreleri fayla yaz
    myListReal.clear();

    String maxVCF = const numberList().getMaxLengthVCFraw();

    setState(() {
      testType != null
          ? isLoading = false
          : isLoading =
              true; //eger yazma emeliyyatinda true gelmeyibse loading bar aktif qalsin
    });
    ScaffoldMessenger.of(context).showSnackBar(
      ilanBar(
        "Yuklendi $maxVCF",
        "Oldu",
        4000000,
        () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      ),
    );
  }

  // ignore: non_constant_identifier_names
  void TXT() async {
    setState(() {
      //tusa basildigi anda loadinbari aktif et
      _isLoading = true;
    });
    print(myListReal);
    testType =
        await const numberList().writeTXTraw(myListReal); // nomreleri fayla yaz
    myListReal.clear();

    setState(() {
      testType != null
          ? _isLoading = false
          : _isLoading =
              true; //eger yazma emeliyyatinda true gelmeyibse loading bar aktif qalsin
    });
    ScaffoldMessenger.of(context).showSnackBar(
      ilanBar(
        "Yuklendi",
        "Oldu",
        4000000,
        () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      ),
    );
  }

  PopupMenuButton<int> myPopMenu() {
    return PopupMenuButton(
      onSelected: ((value) {
        exportData(value);
      }),
      icon: const Icon(Icons.list),
      itemBuilder: (context) {
        return List.generate(_activePopMenu.length, (index) {
          return PopupMenuItem(
            value: index,
            child: Text(_activePopMenu[index]),
          );
        });
      },
    );
  }
}
