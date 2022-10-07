import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:routetest/elements/workElements.dart';
import 'network_constants.dart';

class Network {
  List<String> numberList = [];

  final String number;
  final String categoryKey;
  final String prefixKey;

  final int page;
  final BuildContext context;
  Network(
      {required this.number,
      required this.categoryKey,
      required this.prefixKey,
      required this.page,
      required this.context});

  Future<void> connect() async {
    bool allData = false;
    int counter = page;
    try {
      while (true) {
        //page
        print(counter);

        SnackBar pageInfo = ilanBar(
          "Səhifə sayı $counter",
          "Oldu",
          50,
          () {
            //snackbari gizlet
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        );
        if (categoryKey == "all") {
          allData = true;
        }
        var response = await http.get(
          getBakcell(number, categoryKey, counter, prefixKey, allData),
          headers: await header(0),
        );
        if (response.statusCode == 500) {
          throw Exception("Key xətası");
        }
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

  Future<void> connectNar() async {
    int counter = page;
    try {
      while (true) {
        //page
        print("Page: $counter");

        SnackBar pageInfo = ilanBar(
          "Səhifə sayı $counter",
          "Oldu",
          50,
          () {
            //snackbari gizlet
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        );
        var response = await http.get(
          getNar(number, categoryKey, prefixKey.substring(1, 3), counter),
          headers: await header(1),
        );

        if (response.statusCode == 200) {
          List msis = loadData(response.body);
          if (msis.isEmpty) break;
          for (int i = 0; i < msis.length; i++) {
            numberList.add("${msis[i]['msisdn'].substring(3, 12)}");
          }
          if (counter > 0) ScaffoldMessenger.of(context).showSnackBar(pageInfo);

          counter++;
        } else {
          throw Exception("Key xətası ${response.statusCode}");
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
