import 'package:flutter/material.dart';
import 'ticTacToe.dart';

class Ss1 extends StatefulWidget {
  const Ss1({super.key});

  @override
  State<Ss1> createState() => _Ss1State();
}

class _Ss1State extends State<Ss1> {
  int gridSize = 3;
  int tm = 3;
  List<int> time = [3, 5, 10];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Grid", style: TextStyle(fontWeight: FontWeight.bold)),
              ElevatedButton(
                  onPressed: () {
                    if (gridSize == 3) {
                      setState(() {
                        gridSize = 4;
                      });
                    } else {
                      setState(() {
                        gridSize = 3;
                      });
                    }
                  },
                  child: Text(
                    "$gridSize x $gridSize",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Time", style: TextStyle(fontWeight: FontWeight.bold)),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      int index = time.indexOf(tm);
      
                      if (index == time.length - 1) {
                        tm = time[0];
                      } else {
                        tm = time[index + 1];
                      }
                    });
                  },
                  child: Text(
                    "$tm",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              TicTacToe(gridSize: gridSize, moveTime: tm)),
                    );
                  },
                  child: Text("play"))
            ],
          )
        ],
      ),
    );
  }
}
