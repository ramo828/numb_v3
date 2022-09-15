// ignore: file_names
import 'package:flutter/material.dart';
import 'package:routetest/pages/workNumberList.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../elements/workElements.dart';

class Worker extends StatefulWidget {
  static const String routeName = "/worker";

  const Worker({super.key});

  @override
  State<Worker> createState() => _WorkerState();
}

class _WorkerState extends State<Worker> {
  PageController controller = PageController();
  List<String> pageName = ["Axtarış", "Nömrələr"];
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(pageName[index]),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: PageView(
              controller: controller,
              onPageChanged: (value) => setState(() {
                value == 0 ? index = 0 : index = 1;
              }),
              children: const [
                numberTextField(),
                numberList(),
              ],
            ),
          ),
          SmoothPageIndicator(
            controller: controller,
            count: 2,
            axisDirection: Axis.horizontal,
            effect: const SlideEffect(
              spacing: 10,
              activeDotColor: Colors.grey,
              dotHeight: 15,
              dotColor: Colors.blueGrey,
              // paintStyle: PaintingStyle.fill,
              dotWidth: 15,
            ),
          ),
          const SizedBox(height: 5),
        ],
      ),
    );
  }
}
