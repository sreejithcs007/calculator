import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calc extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CalcState();
}

class CalcState extends State<Calc> {
  var buttonnames = [
    'AC',
    "☒",
    "()󠀥󠀥󠀥󠀥",
    "/",
    "7",
    "8",
    "9",
    "x",
    "4",
    "5",
    "6",
    "-",
    "1",
    "2",
    "3",
    "+",
    "%",
    "0",
    ".",
    "="
  ];
  var addind = 0;
  var text1 = "";
  var oper = "";
  var answer = "";
  var pressed = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.black12, Colors.grey])),
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.29,
              width: double.infinity,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0, right: 10),
                    child: Text(
                      text1,
                      style: const TextStyle(fontSize: 35),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40.0, right: 10),
                    child: Text(
                      answer,
                      style: const TextStyle(fontSize: 40),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                child: GridView.builder(
                    //    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4, childAspectRatio: 1),
                    itemCount: buttonnames.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0, left: 8, right: 8, bottom: 8),
                        child: GestureDetector(
                          onTap: () {
                            String buttonName = buttonnames[index];
                            if (buttonName == "=") {
                              equals(text1, oper);
                            } else if (buttonName == "AC") {
                              setState(() {
                                text1 = "";
                                oper = "";
                                answer = "";
                              });
                            } else if (buttonName == "☒") {
                              setState(() {
                                text1 = text1.substring(0, text1.length - 1);
                                pressed = 0;
                              });
                            } else if (buttonName == "+" ||
                                buttonName == "x" ||
                                buttonName == "/" ||
                                buttonName == "-") {
                              if (pressed == 0) {
                                setState(() {
                                  text1 += buttonName;
                                  oper = buttonName;
                                  pressed = 1;
                                });
                              }
                            } else {
                              setState(() {
                                text1 += buttonName;
                                pressed = 0;
                              });
                            }
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.3,
                            width: MediaQuery.of(context).size.height * 0.2,
                            decoration: BoxDecoration(
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.black45,
                                    spreadRadius: 0.2,
                                    blurRadius: 6)
                              ],
                              gradient: (index + 1) % 4 == 0 && index != 19
                                  ? const LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                          Colors.green,
                                          Colors.lightBlueAccent
                                        ])
                                  : (index == 1 || index == 2)
                                      ? const LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [
                                              Colors.green,
                                              Colors.lightBlueAccent
                                            ])
                                      : (index == 0)
                                          ? const LinearGradient(
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                              colors: [
                                                  Colors.deepOrangeAccent,
                                                  Colors.orange
                                                ])
                                          : index == 19
                                              ? const LinearGradient(
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                  colors: [
                                                      Colors.blue,
                                                      Colors.deepPurpleAccent
                                                    ])
                                              : index == 16
                                                  ? const LinearGradient(
                                                      begin: Alignment.topLeft,
                                                      end:
                                                          Alignment.bottomRight,
                                                      colors: [
                                                          Colors.green,
                                                          Colors.lightBlueAccent
                                                        ])
                                                  : const LinearGradient(
                                                      begin: Alignment.topLeft,
                                                      end:
                                                          Alignment.bottomRight,
                                                      colors: [
                                                          Colors.white,
                                                          Colors.pinkAccent
                                                        ]),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                                child: Text(
                              buttonnames[index],
                              style:
                                  const TextStyle(fontSize: 25, color: Colors.black),
                            )),
                          ),
                        ),
                      );
                    }),
              ),
            )
          ],
        ),
      )),
    );
  }

  void equals(String text1, String oper) {
    var num = text1;
    num = text1.replaceAll('x', '*');
    num = text1.replaceAll('%', '/100');
    Parser p = Parser();
    Expression exp = p.parse(num);

    ContextModel cm = ContextModel();

    double eval = exp.evaluate(EvaluationType.REAL, cm);

    setState(() {
      answer = eval.toString();
    });


  }
}
