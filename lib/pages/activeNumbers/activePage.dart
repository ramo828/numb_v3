import 'package:flutter/material.dart';
import 'package:routetest/elements/homePageElements.dart';
import 'package:routetest/elements/workElements.dart';
import 'package:routetest/myWidgest/myWidgets.dart';
import 'package:routetest/pages/activeNumbers/activeNetwork.dart';

bool isEnd = false;
List<String> myListReal = [];
List<String> myListReferance = [];

bool statusActive = false;
activeNetwork net = activeNetwork();
int lastNumberCount = 0;
int activeNumberCount = 0;
bool stop = false;

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
              height: 80,
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
                    height: 30,
                    width: 300,
                    child: Center(
                      child: Text(
                        "Tapılan nömrələr: $activeNumberCount",
                        style: textInfo,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 500,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                  style: const ButtonStyle(animationDuration: Duration(seconds: 1)),
                  onPressed: () async {
                    if (myListReferance.isNotEmpty) {
                      setState(() {
                        isEnd = true;
                        stop = false;
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
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
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
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
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
                      stop = true;
                    });
                  },
                  child: const Text("Durdur"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> controlOperator(String number) async {
    List<String> narPrefix = ["99470", "99477"];
    if (number.length >= 9) {
      for (int i = 0; i < narPrefix.length; i++) {
        statusActive = await net.activeNumbers(
            "${narPrefix[i]}${number.substring(2, number.length)}");
        if (statusActive) {
          setState(() {
            myListReal
                .add("${narPrefix[i]}${number.substring(2, number.length)}");
            activeNumberCount++;
          });
        }
      }

      setState(() {
        lastNumberCount++;
      });
    }
  }
}
