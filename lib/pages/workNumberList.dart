import 'package:flutter/material.dart';
import '../backent/functions.dart';

List<String> data = [];

// ignore: camel_case_types
class numberList extends StatefulWidget {
  //Listedeki datalari temizle
  void clearData() {
    data.clear();
  }

  addNumber(List<String> numbers) {
    for (int i = 0; i < numbers.length; i++) {
      data.add(func().splitNumberData(numbers[i]));
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
