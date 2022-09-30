import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:routetest/backent/network.dart';
import 'package:routetest/myWidgest/myWidgets.dart';
import 'package:routetest/pages/workNumberList.dart';

// ignore: camel_case_types
class numberTextField extends StatefulWidget {
  const numberTextField({
    Key? key,
  }) : super(key: key);

  @override
  State<numberTextField> createState() => _numberTextFieldState();
}

class _numberTextFieldState extends State<numberTextField> {
  String? prefixValue = "055";
  String? operatorValue = "Bakcell";
  String? categoryValue = "Sadə";
  String? outputFileValue = "Text";
  String? numberValue = "XXXXXXX";
  bool loading = false;
  bool nulControl = true;

  TextStyle style = const TextStyle(
      fontSize: 30, color: Colors.black54, fontFamily: 'esasFont');
  Divider divider = Divider(
    color: Colors.grey.shade900,
    height: 5,
  );

  @override
  Widget build(BuildContext context) {
    bool pane1 = true;
    bool pane2 = false;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Scaffold(
        backgroundColor: Colors.grey.shade400,
        body: ListView(
          children: [
            Center(
              child: MyContainer(
                // mesafe: 2,
                radius: 25,
                height: 700,
                width: 500,
                spreadRadius: 10,
                shadowColor: Colors.grey,
                boxColor: Colors.grey.shade400,
                child: Column(
                  children: [
                    loading
                        // ignore: prefer_const_constructors
                        ? SizedBox(
                            child: const LinearProgressIndicator(
                              minHeight: 5,
                            ),
                          )
                        : Container(),

                    //operator
                    MyContainer(
                      shadowColor: Colors.blueGrey,
                      boxColor: Colors.blueGrey.shade200,
                      mesafe: 10,
                      height: 60,
                      width: 200,
                      child: Center(child: operators()),
                    ),
                    divider,

                    //textFiled
                    MyContainer(
                      shadowColor: Colors.blueGrey,
                      boxColor: Colors.blueGrey.shade200,
                      mesafe: 10,
                      height: 70,
                      width: 350,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: TextFormField(
                            initialValue: "",
                            decoration: InputDecoration(
                              hoverColor: Colors.blueAccent,
                              prefixIcon: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: prefix(),
                              ),
                              hintText: "XXX-XX-XX",
                              hintStyle: const TextStyle(
                                  fontSize: 30,
                                  color: Colors.black26,
                                  decorationColor: Colors.pink),
                              fillColor: Colors.grey,
                              border: InputBorder.none,
                            ),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 30, color: Colors.amber),
                            inputFormatters: [maskFormatter],
                            onChanged: (value) {
                              numberValue = value.replaceAll("-", "");
                            },
                          ),
                        ),
                      ),
                    ),
                    divider,

                    //Category
                    MyContainer(
                      shadowColor: Colors.blueGrey,
                      boxColor: Colors.blueGrey.shade200,
                      height: 60,
                      width: 250,
                      child: Center(child: category()),
                    ),
                    divider,
                    //
                    operatorPrefix((index, isExpanded) {
                      setState(() {
                        if (index == 0) {
                          isExpanded ? pane1 = false : pane1 = true;
                        } else if (index == 1) {
                          isExpanded ? pane2 = false : pane2 = true;
                        }
                      });
                    }),
                    MyContainer(
                      shadowColor: Colors.blueGrey,
                      boxColor: Colors.blue.shade200,
                      height: 50,
                      width: 120,
                      child: Center(
                        child: Text(
                          "Axtar",
                          style: style,
                        ),
                      ),
                      onPress: () async {
                        //  yoxla
                        try {
                          setState(() {
                            loading = true;
                          });
                          Network network = Network(
                              number: numberValue!,
                              categoryKey: categoryValue!,
                              page: 0,
                              prefixKey: prefixValue!,
                              context: context);
                          if (operatorValue == 'Bakcell') {
                            debugPrint("Bakcell selected");
                            await network.connect();
                            //listedeki kohne datalari sil
                            const numberList().clearData();
                            //yeni datalari elave et
                            const numberList()
                                .setNumberList(network.numberList);
                            // datalari liste elave et
                            const numberList().addNumber();
                          } else if (operatorValue == 'Nar') {
                            await network.connectNar();
                            //listedeki kohne datalari sil
                            const numberList().clearData();
                            //yeni datalari elave et
                            const numberList()
                                .setNumberList(network.numberList);
                            const numberList().addNumber();

                            // datalari liste elave et
                          }

                          setState(() {
                            loading = false;
                            ScaffoldMessenger.of(context).showSnackBar(
                              ilanBar(
                                "Tapılan nömrə sayı: ${network.numberList.length}"
                                    .toString(),
                                "Oldu",
                                4000000,
                                () {
                                  ScaffoldMessenger.of(context)
                                      .hideCurrentSnackBar();
                                },
                              ),
                            );
                          });
                        } catch (e) {
                          var data = ilanBar(e.toString(), "Oldu", 1000000, () {
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          });
                          ScaffoldMessenger.of(context).showSnackBar(data);
                        }
                      },
                    ),
                    divider,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  DropdownMenuItem<String> menuItem(
    String text,
    String value,
    bool enabled,
  ) {
    return DropdownMenuItem(
      value: value,
      enabled: enabled,
      child: Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: style,
        ),
      ),
    );
  }

  DropdownButton operators<String>() {
    return DropdownButton(
      isExpanded: true,
      borderRadius: const BorderRadius.all(
        Radius.circular(15.0),
      ),
      disabledHint: Text(
        "Aktiv deyil",
        style: style,
      ),
      iconSize: 40,
      focusColor: Colors.blue,
      iconEnabledColor: Colors.green.shade300,
      iconDisabledColor: Colors.red.shade300,
      dropdownColor: Colors.grey.shade300,
      alignment: Alignment.center,
      enableFeedback: true,
      hint: Center(
        child: Text(
          operatorValue!,
          textAlign: TextAlign.center,
          style: style,
        ),
      ),
      items: [
        menuItem("Bakcell", "Bakcell", true),
        menuItem("Nar", "Nar", true),
      ],
      onChanged: (value) {
        setState(() {
          print("SECILDI");
          operatorValue = value;

          value == "Bakcell"
              ? categoryValue = "Sadə"
              : value == "Bakcell"
                  ? categoryValue = "Sadə099"
                  : categoryValue = "GENERAL";

          value == "Nar" ? prefixValue = "070" : prefixValue == "055";
          value == "Bakcell" ? prefixValue = "055" : prefixValue == "070";
        });
      },
    );
  }

  DropdownButton prefix<String>() {
    List<DropdownMenuItem<dynamic>>? bakcell = [
      menuItem("055", "055", true),
      menuItem("099", "099", true),
    ];
    List<DropdownMenuItem<dynamic>>? nar = [
      menuItem("070", "070", true),
      menuItem("077", "077", true),
    ];

    return DropdownButton(
      borderRadius: const BorderRadius.all(
        Radius.circular(15.0),
      ),
      disabledHint: Text(
        "Aktiv deyil",
        style: style,
      ),
      iconSize: 40,
      focusColor: Colors.blue,
      iconEnabledColor: Colors.green.shade300,
      iconDisabledColor: Colors.red.shade300,
      dropdownColor: Colors.grey.shade300,
      hint: Center(
        child: Text(
          prefixValue!,
          style: style,
          textAlign: TextAlign.center,
        ),
      ),
      items: operatorValue == "Bakcell" ? bakcell : nar,
      onChanged: (value) {
        setState(() {
          prefixValue = value;
          value == "055"
              ? categoryValue = "Sadə"
              : value == "099"
                  ? categoryValue = "Sadə099"
                  : categoryValue = "GENERAL";
        });
      },
    );
  }

  DropdownButton category<String>() {
    List<DropdownMenuItem<dynamic>>? bakcell055 = [
      menuItem("Sadə", "Sadə", true),
      menuItem("Xüsusi 1", "Xüsusi 1", true),
      menuItem("Xüsusi 2", "Xüsusi 2", true),
    ];
    List<DropdownMenuItem<dynamic>>? bakcell099 = [
      menuItem("Sadə099", "Sadə099", true),
      menuItem("Bürünc", "Bürünc", true),
      menuItem("Gümüş", "Gümüş", true),
      menuItem("Qızıl", "Qızıl", true),
      menuItem("Platin", "Platin", true),
    ];
    List<DropdownMenuItem<dynamic>>? nar = [
      menuItem("GENERAL", "GENERAL", true),
      menuItem("Prestige", "PRESTİGE", true),
      menuItem("Prestige1", "PRESTİGE1", true),
      menuItem("Prestige2", "PRESTİGE2", true),
      menuItem("Prestige3", "PRESTİGE3", true),
      menuItem("Prestige4", "PRESTİGE4", true),
      menuItem("Prestige5", "PRESTİGE5", true),
      menuItem("Prestige6", "PRESTİGE6", true),
      menuItem("Prestige7", "PRESTİGE7", true),
      menuItem("Prestige7", "PRESTİGE8", true),
      menuItem("Hamısı", "", true),
    ];

    return DropdownButton(
      isExpanded: true,
      borderRadius: const BorderRadius.all(
        Radius.circular(15.0),
      ),
      disabledHint: Center(
        child: Text(
          "Aktiv deyil",
          style: style,
        ),
      ),
      iconSize: 40,
      focusColor: Colors.blue,
      iconEnabledColor: Colors.green.shade300,
      iconDisabledColor: Colors.red.shade300,
      dropdownColor: Colors.grey.shade300,
      hint: Center(
        child: Text(
          categoryValue!,
          style: style,
          textAlign: TextAlign.center,
        ),
      ),
      items: operatorValue == "Bakcell" && prefixValue == "055"
          ? bakcell055
          : operatorValue == "Bakcell"
              ? bakcell099
              : nar,
      onChanged: (value) {
        setState(() {
          categoryValue = value;
        });
      },
    );
  }
}

var maskFormatter = MaskTextInputFormatter(
    mask: '###-##-##',
    filter: {"#": RegExp(r'[0-9xX]')},
    type: MaskAutoCompletionType.lazy);

SnackBar ilanBar(
  String text,
  String buttonText,
  int time,
  void Function() onPress,
) =>
    SnackBar(
      duration: Duration(microseconds: time),
      content: Text(
        text,
        style: const TextStyle(
          fontSize: 17,
        ),
      ),
      action: SnackBarAction(
        textColor: Colors.amber,
        label: buttonText,
        onPressed: onPress,
      ),
    );

ExpansionPanelList operatorPrefix(
    void Function(int index, bool isExpanded) callback) {
  return ExpansionPanelList(
    animationDuration: const Duration(milliseconds: 600),
    expansionCallback: callback,
    children: [
      ExpansionPanel(
        canTapOnHeader: true,
        headerBuilder: (BuildContext context, bool isExpanded) {
          return const Center(
            child: ListTile(
              title: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Aktiv nömrələri tap'),
              ),
            ),
          );
        },
        body: Column(),
      ),
    ],
  );
}
