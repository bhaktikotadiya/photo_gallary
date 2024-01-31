import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main()
{
  runApp(MaterialApp(
    home: demo_game(),
  ));
}
class demo_game extends StatefulWidget {
  const demo_game({super.key});

  @override
  State<demo_game> createState() => _demo_gameState();
}

class _demo_gameState extends State<demo_game> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CROSS AXIS"),
        backgroundColor: Colors.yellow,
        centerTitle: true,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.black,
        child: Column(crossAxisAlignment: CrossAxisAlignment.end,children: [
          Expanded(
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,children: [
              Expanded(
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  color: Colors.green,
                  child: Text("1"),
                ),
              ),
              Expanded(
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  color: Colors.teal,
                  child: Center(child: Text("2")),
                ),
              ),
              Expanded(
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  color: Colors.pinkAccent,
                  child: Center(child: Text("3")),
                ),
              )
            ],),
          ),
          Expanded(
            child: Row(children: [
              Expanded(
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  color: Colors.deepOrange,
                  child: Center(child: Text("4")),
                ),
              ),
              Expanded(
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  color: Colors.deepPurple,
                  child: Center(child: Text("5")),
                ),
              ),
              Expanded(
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  color: Colors.brown,
                  child: Center(child: Text("6")),
                ),
              )
            ],),
          ),
          Expanded(
            child: Row(children: [
              Expanded(
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  color: Colors.yellow,
                  child: Center(child: Text("7")),
                ),
              ),
              Expanded(
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  color: Colors.orange,
                  child: Center(child: Text("8")),
                ),
              ),
              Expanded(
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  color: Colors.blueGrey,
                  child: Center(child: Text("9")),
                ),
              )
            ],),
          )
        ]),
      ),
    );
  }
}
