import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
// import 'colors.dart';

void main() {
  runApp(const MaterialApp(
    home: CalcApp(),
  ));
}

class CalcApp extends StatefulWidget {
  const CalcApp({super.key});

  @override
  State<CalcApp> createState() => _CalcAppState();
}

class _CalcAppState extends State<CalcApp> {
  double firstNum = 0.0;
  double secondNum = 0.0;
  var input = '';
  var output = '';
  var operation = '';
  final List<String> _history = [];

  onButtonClick(value) {
    //print(value);
    if (value == "AC") {
      input = '';
      output = '';
    } else if (value == "<-") {
      if (input.isNotEmpty) {
        input = input.substring(0, input.length - 1);
      }
    } else if (value == "=") {
      if (input.isNotEmpty) {
        var userInput = input;
        Parser p = Parser();
        Expression expression = p.parse(userInput);
        ContextModel cm = ContextModel();

        var finalValue = expression.evaluate(EvaluationType.REAL, cm);
        output = finalValue.toString();
        if (output.endsWith(".0")) {
          output = output.substring(0, output.length - 2);
        }
      }
      _history.add(input);
      _history.add('$output\n');
      //  _history.add("");

      // print(_history);
      input = output;
      input = '';
    } else {
      input = input + value;
    }
    setState(() {});
  }

  onLongPress() {
    if (input.isNotEmpty) {
      input = '';
      setState(() {});
    }
  }

  static const buttonColor = Color(0xff191919);
  final opnColor = const Color.fromARGB(255, 37, 37, 37);
  final orange = const Color.fromARGB(255, 245, 112, 3);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Stack(children: [
            Container(
              padding: const EdgeInsets.only(top: 15),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                color: Colors.white.withOpacity(0.3),
                width: 1,
              ))),
              child: SizedBox(
                height: 200,
                child: ListView.builder(
                  padding: const EdgeInsets.only(left: 30, top: 50),
                  itemCount: _history.length,
                  itemBuilder: (context, position) {
                    return Text(
                      _history[position],
                      style: ((position.isEven)
                          ? const TextStyle(fontSize: 20, color: Colors.white)
                          : TextStyle(
                              fontSize: 15,
                              color: Colors.white.withOpacity(0.7))),
                    );
                  },
                ),
              ),
            ),
          ]),

          Flexible(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(12),
                width: double.infinity,

                //color: Colors.amber,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        input,
                        style: const TextStyle(
                          fontSize: 35,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        output,
                        key: const Key('output'),
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.white.withOpacity(0.7),
                        ),
                      )
                    ]),
              ),
            ),
          ),

          //buttons
          Expanded(
            child: Row(
              children: [
                button(text: "AC", buttonBgColor: opnColor, tcolor: orange),
                buttonDel(text: "<-", buttonBgColor: opnColor, tcolor: orange),
                button(text: "", buttonBgColor: Colors.transparent),
                button(text: "/", buttonBgColor: opnColor, tcolor: orange),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                button(text: "7"),
                button(text: "8"),
                button(text: "9"),
                button(text: "*", buttonBgColor: opnColor, tcolor: orange),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                button(text: "4"),
                button(text: "5"),
                button(text: "6"),
                button(text: "-", buttonBgColor: opnColor, tcolor: orange),
              ],
            ),
          ),

          Expanded(
            child: Row(
              children: [
                button(text: "1"),
                button(text: "2"),
                button(text: "3"),
                button(text: "+", tcolor: orange, buttonBgColor: opnColor),
              ],
            ),
          ),

          Expanded(
            child: Row(
              children: [
                button(text: "%", buttonBgColor: opnColor, tcolor: orange),
                button(text: "0", buttonBgColor: opnColor, tcolor: orange),
                button(text: ".", buttonBgColor: opnColor, tcolor: orange),
                button(text: "=", buttonBgColor: orange),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buttonDel({text, tcolor = Colors.white, buttonBgColor = buttonColor}) {
    return Expanded(
      child: GestureDetector(
        child: Container(
          margin: const EdgeInsets.all(8),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: buttonBgColor,
              padding: const EdgeInsets.all(22),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () => onButtonClick(text),
            onLongPress: () => onLongPress(),
            child: Text(
              text,
              style: TextStyle(
                fontSize: 18,
                color: tcolor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget button({text, tcolor = Colors.white, buttonBgColor = buttonColor}) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(8),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonBgColor,
            padding: const EdgeInsets.all(22),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: () => onButtonClick(text),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 18,
              color: tcolor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
