import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class home_screen extends StatefulWidget {
  const home_screen({super.key});

  @override
  State<home_screen> createState() => _home_screenState();
}

class _home_screenState extends State<home_screen> {
  String input_text = '';
  String result = '0';
  List<String> button_text = [
    'C',
    '(',
    ')',
    '/',
    '7',
    '8',
    '9',
    '*',
    '4',
    '5',
    '6',
    '+',
    '1',
    '2',
    '3',
    '-',
    'AC',
    '0',
    '.',
    '=',
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          child: Column(
            children: [
              Flexible(
                child: result_widget(),
                flex: 1,
              ),
              Flexible(
                child: button_widget(),
                flex: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget result_widget() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerRight,
            child: Text(
              input_text,
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerRight,
            child: Text(
              result,
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget button_widget() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
      ),
      itemCount: button_text.length,
      itemBuilder: (BuildContext context, int index) {
        return button(button_text[index]);
      },
    );
  }

  Widget button(String text) {
    return Container(
      child: MaterialButton(
        onPressed: () {
          setState(() {
            user_input(text);
          });
        },
        color: getcolor(text),
        textColor: Colors.white,
        child: Text(text),
        shape: CircleBorder(),
      ),
      margin: EdgeInsets.all(10),
    );
  }

  getcolor(String text) {
    if (text == '/' ||
        text == '*' ||
        text == '+' ||
        text == '-' ||
        text == '=') {
      return Colors.orangeAccent;
    }
    if (text == 'C' || text == 'AC') {
      return Colors.red;
    }
    if (text == '(' || text == ')') {
      return Colors.blueGrey;
    }
    return Colors.blue;
  }

  user_input(String text) {
    if (text == 'AC') {
      input_text = '';
      result = '0';
      return;
    }
    if (text == 'C') {
      input_text = input_text.substring(0, input_text.length - 1);
      return;
    }
    if (text == '=') {
      result = calculate();
      return;
    }
    input_text = input_text + text;
  }

  String calculate() {
    try {
      var exp = Parser().parse(input_text);
      var calculation = exp.evaluate(EvaluationType.REAL, ContextModel());
      var price = calculation.toStringAsFixed(2);
      return price;
    } catch (e) {
      return 'ERROR';
    }
  }
}
