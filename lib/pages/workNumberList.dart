import 'package:flutter/material.dart';
import 'package:routetest/myWidgest/myWidgets.dart';

List<String> data = [];

// ignore: camel_case_types
class numberList extends StatefulWidget {
  //Listedeki datalari temizle
  void clearData() {
    data.clear();
  }

  addNumber(List<String> numbers) {
    for (int i = 0; i < numbers.length; i++) {
      data.add(numbers[i]);
    }
  }

  const numberList({super.key});

  static const routeName = "/list";

  @override
  State<numberList> createState() => _numberListState();
}

class _numberListState extends State<numberList> {
  PaginatedDataTable pageData() {
    List<DataColumn> dc = [
      DataColumn(
        label: Text(
          "Sıra no",
          style: styleMe(
            20,
            Colors.purple,
          ),
        ),
      ),
      DataColumn(
        label: Text(
          "Nömrə",
          style: styleMe(
            20,
            Colors.purple,
          ),
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

  @override
  DataRow? getRow(int index) {
    // ignore: todo
    // TODO: implement getRow
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text(
          "${index + 1},",
          style: const TextStyle(
            color: Colors.amber,
            fontSize: 20,
          ),
        )),
        DataCell(
          Text(
            value[index],
            style: const TextStyle(
              color: Colors.amber,
              fontSize: 20,
            ),
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
