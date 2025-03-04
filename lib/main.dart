import 'package:flutter/material.dart';
import 'ticTacToe.dart';
import 'selectionPage1.dart';
import 'Reaction.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title});

  final String title;
  final List<String> gameNames = [
    "tic-tac-toe",
    "2",
    "3"
  ]; // Only 3 buttons now

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // Centering the buttons
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Align in center
          children: widget.gameNames.map((name) {
            //converts each item of a list into an widget, returns an iterable which can be converted to list using .toList()
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    // MaterialPageRoute(builder: (context) => TicTacToe()),
                    // MaterialPageRoute(builder: (context) => Ss1()),  //navigation to selectionPage1
                    MaterialPageRoute(builder: (context) => ReactionSpeed()),
                  );
                  print("Button $name pressed");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey, // Button color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8), // Rounded edges
                  ),
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                ),
                child: Text(
                  name,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
