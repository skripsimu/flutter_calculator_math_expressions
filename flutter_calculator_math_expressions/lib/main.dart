import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(CalcApp());
}

class CalcApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Calculator(),
      ),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  TextEditingController _calController = new TextEditingController();
  String _result = "";
  void _calc(String string1) {
    setState(() {
      Parser p = new Parser();
      Expression exp = p.parse(string1);
      String result = exp
          .evaluate(EvaluationType.REAL, null)
          .toString(); // if context is not available replace it with null.
      print(result);
      setState(() {
        _result = result;
        print(_result);
      });
    });
  }

  Widget _bodyCalc(BuildContext context) {
    return ListView(
      children: <Widget>[
        _pageForm(),
      ],
    );
  }

  Widget _pageForm() {
    return Container(
      color: Colors.lightBlue,
      height: 500,
      padding: EdgeInsets.all(20.0),
      child: Stack(
        overflow: Overflow.visible,
        children: <Widget>[
          Positioned(
            top: 140,
            left: 10,
            right: 10,
            child: Container(
              height: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 90.0,
                    child: Column(
                      children: <Widget>[
                        Text("Your Result"),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          _result,
                          style: TextStyle(fontSize: 36),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: TextFormField(
                      controller: _calController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "Input your value",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Container(
                    child: Divider(
                      thickness: 2,
                      color: Colors.blue[800],
                    ),
                    padding:
                        EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 90.0,
            left: 10.0,
            right: 10.0,
            child: CircleAvatar(
              child: Image.asset('assets/images/math.png'),
              maxRadius: 50,
              backgroundColor: Colors.transparent,
            ),
          ),
          Positioned(
            top: 410,
            left: 10,
            right: 10,
            child: MaterialButton(
              child: Container(
                width: 200,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.blue[800],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    "CALC",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
              onPressed: () {
                _calc(_calController.text);
              },
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: <Widget>[_bodyCalc(context)],
      ),
    );
  }
}
