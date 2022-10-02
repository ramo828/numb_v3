import 'package:flutter/material.dart';
import 'package:routetest/pages/activeNumbers/activeNetwork.dart';

List<String> myListReal = [];

class activePage extends StatefulWidget {
  static const routeName = "/activePage";
  const activePage({super.key});

  @override
  State<activePage> createState() => _activePageState();
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
      body: Column(
        children: [
          Container(
            height: 500,
            width: double.infinity,
            color: Colors.grey.shade300,
            child: ListView.builder(
              itemCount: myListReal.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Center(
                    child: Text(
                      myListReal[index],
                    ),
                  ),
                );
              },
            ),
          ),
          OutlinedButton(
            onPressed: () async {
              activeNetwork net = activeNetwork();
              net.activeNumbers().then((value) {
                print("Bitdi");
              });
            },
            child: const Text("Yoxla"),
          ),
        ],
      ),
    );
  }
}
