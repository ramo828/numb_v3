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
                    MyContainer(
                      shadowColor: Colors.blueGrey,
                      boxColor: Colors.blueGrey.shade200,
                      height: 60,
                      width: 250,
                      child: Center(
                        child: outputFileType(),
                      ),
                    ),
                    divider,

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
                              context: context);
                          await network.connect();
                          //listedeki kohne datalari sil
                          const numberList().clearData();
                          //yeni datalari elave et
                          const numberList().addNumber(network.numberList);

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
        menuItem("Nar", "Nar", false),
      ],
      onChanged: (value) {
        setState(() {
          operatorValue = value;
          value == "Bakcell" ? prefixValue = "055" : prefixValue = "070";
          value == "Bakcell" ? prefixValue == "055" : categoryValue == "Sadə";
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
                  : categoryValue = "General";
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
      menuItem("Prestige", "Prestige", true),
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

  DropdownButton outputFileType<String>() {
    List<DropdownMenuItem<dynamic>>? fileType = [
      menuItem("Text", "Text", true),
      menuItem("VCF", "VCF", true),
      menuItem("CSV", "CSV", true),
      menuItem("Google CSV", "Google CSV", true),
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
          outputFileValue!,
          style: style,
        ),
      ),
      items: fileType,
      onChanged: (value) {
        setState(() {
          outputFileValue = value;
        });
      },
    );
  }

  var maskFormatter = MaskTextInputFormatter(
      mask: '###-##-##',
      filter: {"#": RegExp(r'[0-9xX]')},
      type: MaskAutoCompletionType.lazy);
}

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
