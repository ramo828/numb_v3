// ignore: file_names
import 'package:flutter/material.dart';
import 'package:routetest/pages/activeNumbers/work/workNumberList.dart';
import 'package:routetest/pages/activeNumbers/work/workSettings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../elements/workElements.dart';

bool isLoading = false;
bool testType = false;
List<String> popMenu = ["Text", "VCF", "CSV", "Google CSV"];

//ayar bilgileri ayar acilan kimi yuklensin
Future<List<String>?> initSettingData() async {
  try {
    SharedPreferences sp = await SharedPreferences.getInstance();
    settings = sp.getStringList("setting") as List<String>;
  } catch (e) {
    print(e);
  }
  return settings;
}

class Worker extends StatefulWidget {
  static const String routeName = "/worker";

  const Worker({super.key});
  @override
  State<Worker> createState() => _WorkerState();
}

class _WorkerState extends State<Worker> {
  @override
  void initState() {
    initSettingData();
    // TODO: implement initState
    super.initState();
  }

  PageController controller = PageController();
  List<String> pageName = ["Axtarış", "Nömrələr"];
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(pageName[index]),
        actions: [
          index == 0
              ? IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, workSettings.routeName);
                  },
                  icon: const Icon(
                    Icons.settings,
                  ),
                )
              : Container(),
          index == 1
              ? isLoading
                  ? const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      ),
                    )
                  : Container()
              : Container(),
          index == 1 ? myPopMenu() : Container(),
        ],
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
                numberTextField(), // nomre daxil etme hissesi
                numberList(), //siyahi halinda olan nomreler
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

  PopupMenuButton<int> myPopMenu() {
    return PopupMenuButton(
      onSelected: ((value) {
        exportData(value);
      }),
      icon: const Icon(Icons.list),
      itemBuilder: (context) {
        return List.generate(popMenu.length, (index) {
          return PopupMenuItem(
            value: index,
            child: Text(popMenu[index]),
          );
        });
      },
    );
  }

  void VCF() async {
    setState(() {
      //tusa basildigi anda loadinbari aktif et
      isLoading = true;
    });
    const numberList().clearData();
    testType = await const numberList().writeVCF(); // nomreleri fayla yaz
    String maxVCF = const numberList().getMaxLengthVCF();
    setState(() {
      testType != null
          ? isLoading = false
          : isLoading =
              true; //eger yazma emeliyyatinda true gelmeyibse loading bar aktif qalsin
    });
    ScaffoldMessenger.of(context).showSnackBar(
      ilanBar(
        "Yuklendi $maxVCF",
        "Oldu",
        4000000,
        () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      ),
    );
  }

  void TXT() async {
    setState(() {
      //tusa basildigi anda loadinbari aktif et
      isLoading = true;
    });
    const numberList().clearData();
    testType = await const numberList().writeTXT(); // nomreleri fayla yaz
    setState(() {
      testType != null
          ? isLoading = false
          : isLoading =
              true; //eger yazma emeliyyatinda true gelmeyibse loading bar aktif qalsin
    });
    ScaffoldMessenger.of(context).showSnackBar(
      ilanBar(
        "Yuklendi",
        "Oldu",
        4000000,
        () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      ),
    );
  }

  void CSV() {}
  void googleCSV() {}

  void exportData(int index) async {
    switch (index) {
      case 0:
        TXT();
        break;
      case 1:
        VCF();
        break;
      case 2:
        CSV();
        break;
      case 3:
        googleCSV();
        break;
      default:
        throw Exception("Bilinməyən index");
    }
  }
}
