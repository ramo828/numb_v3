import 'package:flutter/material.dart';
import 'package:routetest/pages/workNumberList.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../myWidgest/workElements.dart';

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
      backgroundColor: Colors.grey.shade600,
      appBar: AppBar(
        centerTitle: true,
        title: Text(pageName[index]),
        backgroundColor: Colors.grey.shade500,
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
              activeDotColor: Colors.white54,
              dotHeight: 15,
              dotColor: Colors.blue,
              dotWidth: 15,
            ),
          ),
          const SizedBox(height: 5),
        ],
      ),
    );
  }
}
