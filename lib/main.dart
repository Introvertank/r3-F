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
      debugShowCheckedModeBanner: false,
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
    "Reaction time",
    "3"
  ]; // Only 3 buttons now

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black26,
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
                  if (name == "tic-tac-toe") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              Ss1()), //navigation to selectionPage1
                      // MaterialPageRoute(builder: (context) => ReactionSpeed()),
                    );
                  } else if (name == "Reaction time") {
                    Navigator.push(
                      context,
                      // MaterialPageRoute(builder: (context) => Ss1()),  //navigation to selectionPage1
                      MaterialPageRoute(builder: (context) => ReactionSpeed()),
                    );
                  } else {
                    print("$name button pressed, but no action assigned yet");
                  }

                  print("Button $name pressed");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Color.fromARGB(255, 48, 48, 48), // Button color
                  fixedSize: Size(150, 150),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // Rounded edges
                  ),
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                ),
                child: Text(
                  name,
                  style: TextStyle(
                    fontSize: 22,
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
