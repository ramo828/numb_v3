import 'package:flutter/material.dart';
import 'package:routetest/elements/workElements.dart';
import 'package:routetest/pages/activeNumbers/activeNetwork.dart';

bool isEnd = false;
List<String> myListReal = [];
bool statusActive = false;

class activePage extends StatefulWidget {
  static const routeName = "/activePage";
  const activePage({super.key});

  @override
  State<activePage> createState() => _activePageState();

  void addList(String numData) {
    myListReal.add(numData);
  }
}

class _activePageState extends State<activePage> {
  activeNetwork activeNet = activeNetwork();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "ActivePage",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          children: [
            isEnd ? LinearProgressIndicator() : Container(),
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
                  onPressed: () async {
                    setState(() {
                      isEnd = true;
                    });
                    activeNetwork net = activeNetwork();
                    for (int i = 0; i < net.an.length; i++) {
                      statusActive = await net.activeNumbers(net.an[i]);
                      if (statusActive) {
                        setState(() {
                          myListReal.add(net.an[i]);
                          print(net.an[i]);
                        });
                      } else {}
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
                  },
                  child: const Text("Yoxla"),
                ),
                OutlinedButton(
                  onPressed: () {
                    setState(() {
                      myListReal.clear();
                    });
                  },
                  child: Text("Təmizlə"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
