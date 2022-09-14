import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:routetest/elements/workElements.dart';
import 'network_constants.dart';

class Network {
  List<String> numberList = [];

  final String number;
  final String categoryKey;
  final int page;
  final BuildContext context;
  Network(
      {required this.number,
      required this.categoryKey,
      required this.page,
      required this.context});

  Future connect() async {
    int counter = page;
    try {
      while (true) {
        print(counter);

        SnackBar pageInfo = ilanBar(
          "Səhifə sayı $counter",
          "Oldu",
          50,
          () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        );
        var response = await http.get(
          getBakcell(number, categoryKey, counter),
          headers: header(token),
        );
        if (response.statusCode == 200) {
          var data = loadData(response.body);
          List msis = data[0]['freeMsisdnList'];
          if (msis.isEmpty) break;
          for (int i = 0; i < msis.length; i++) {
            numberList.add(msis[i]['msisdn']);
          }
          if (counter > 0) ScaffoldMessenger.of(context).showSnackBar(pageInfo);

          counter++;
        }
      }
      // ignore: empty_catches

    } on RangeError catch (_, e) {
      print(e);
    } catch (e) {
      SnackBar error = ilanBar(
        "Xəta: $e",
        "Oldu",
        4000000,
        () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      );
      ScaffoldMessenger.of(context).showSnackBar(error);
      print(e.toString());
    }
  }
}
