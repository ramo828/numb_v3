import 'package:flutter/material.dart';
import 'package:routetest/backent/io/fileProvider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../backent/functions.dart';

List<String> data = [];
String numberData = "";
List<String> numbers = [];
fileProvider fp = fileProvider();
bool isDown = false;
String vcfData = "";
int counterAllData = 0;
//VCF hazirlanacaq prefixler
List<String> prefixList = [
  "055",
  "099",
  "050",
  "051",
  "010",
  "070",
  "077",
];

// ignore: camel_case_types
class numberList extends StatefulWidget {
  static const routeName = "/list";

  void setPrefix(List<String> prefixLst) {
    prefixList.clear();
    prefixList = prefixLst;
  }

  //Listedeki datalari temizle
  void clearData() {
    data.clear();
    numberData = "";
    vcfData = "";
    counterAllData = 0;
  }

  void setNumberList(List<String> num) {
    numbers = num; //listi numbers deyiscenine elave et
  }

//Nomreleri liste elave et
  addNumber() async {
    for (var element in numbers) {
      data.add(func()
          .splitNumberData(element)); //elave etmemisden once ayir xxx-xx-xx

    }
  }

  String getMaxLengthVCF() {
    return counterAllData.toString();
  }

  Future<bool> writeVCF() async {
    isDown = false;
    SharedPreferences sp = await SharedPreferences.getInstance();
    var contactName = sp.getStringList("setting")![2];

    if (numbers != null || contactName != null) {
      for (int count = 0; count < numbers.length; count++) {
        for (int prefixIndex = 0;
            prefixIndex < prefixList.length;
            prefixIndex++) {
          vcfData += func().vcf(contactName, prefixList, prefixIndex,
              numbers[count], counterAllData);
          counterAllData++;
        }
      }
      await fp.fileWrite(vcfData, "numbers.vcf");
    } else {
      isDown = false;
    }
    isDown = true;
    return isDown;
  }

  Future<bool> writeTXT() async {
    isDown = false;
    // ignore: unnecessary_null_comparison

    if (numbers != null) {
      for (var element in numbers) {
        numberData += "$element\n";
      }
      print("yuklendi");

      await fp.fileWrite(numberData, "numbers.txt");
    } else {
      debugPrint("Bos data");
      return isDown;
    }
    isDown = true;
    debugPrint("Yuklendi");
    return isDown;
  }

  const numberList({super.key});

  @override
  State<numberList> createState() => _numberListState();
}

class _numberListState extends State<numberList> {
  PaginatedDataTable pageData() {
    List<DataColumn> dc = [
      const DataColumn(
        label: Text(
          "Sıra no",
          style: TextStyle(fontSize: 25),
        ),
      ),
      const DataColumn(
        label: Text(
          "Nömrə",
          style: TextStyle(fontSize: 25),
        ),
      ),
    ];
    return PaginatedDataTable(
      arrowHeadColor: Colors.amber,
      columns: dc,
      source: dataSource(data),
      rowsPerPage: 100,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          physics: const ScrollPhysics(parent: BouncingScrollPhysics()),
          children: [
            pageData(),
          ],
        ),
      ),
    );
  }
}

class dataSource extends DataTableSource {
  List<String> value;
  dataSource(this.value);
  TextStyle style = const TextStyle(
    fontSize: 20,
    color: Colors.amber,
  );
  @override
  DataRow? getRow(int index) {
    // ignore: todo
    // TODO: implement getRow
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(
          Text(
            "${index + 1}",
            style: style,
          ),
        ),
        DataCell(
          Text(
            value[index],
            style: style,
          ),
        )
      ],
    );
  }

  @override
  // ignore: todo
  // TODO: implement isRowCountApproximate
  bool get isRowCountApproximate => false;

  @override
  // ignore: todo
  // TODO: implement rowCount
  int get rowCount => value.length;

  @override
  // ignore: todo
  // TODO: implement selectedRowCount
  int get selectedRowCount => 0;
}
