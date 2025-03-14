//fix the early tap message
import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:math';
import 'main.dart';

class ReactionSpeed extends StatefulWidget {
  const ReactionSpeed({super.key});

  @override
  State<ReactionSpeed> createState() => _ReactionSpeedState();
}

class _ReactionSpeedState extends State<ReactionSpeed> {
  DateTime? startTime; // Stores when the screen becomes tappable
  String message = "wait for green...";
  bool isTappable = false;
  Timer? _timer;

  void _startGame() {
    setState(() {
      message = "wait for green...";
      isTappable = false;
    });

    // Cancel any existing timer before starting a new one
    _timer?.cancel();

    //wait for random delay (1.5-5.5 sec)
    int delay = Random().nextInt(4000) + 1500; //1500ms to 5500ms

    _timer = Timer(Duration(milliseconds: delay), () {
      setState(() {
        message = "Tap now!";
        isTappable = true;
        startTime = DateTime.now();
      });
    });
  }

  void _handleTap() {
    print("tapped");
    if (!isTappable) {
      setState(() {
        message = "Too early! restarting...";
      });

      //cancel current timer and restart after a delay
      _timer?.cancel;
      Future.delayed(Duration(seconds: 2), _startGame);
      _startGame();
      return;
    }

    DateTime endTime = DateTime.now();
    int reactionTime = endTime.difference(startTime!).inMilliseconds;

    setState(() {
      message = "Time is ${reactionTime}ms\n Tap to retry!";
      isTappable = false;
    });

    _timer = Timer(Duration(seconds: 5), _startGame);
  }

  @override
  void initState() {
    super.initState();
    _startGame();
  }

  @override
  void dispose() {
    _timer?.cancel(); //cancel timer when widget is removed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        onTap: () => _handleTap(),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Expanded(
            child: Container(
              alignment: Alignment.center,
              width: 412,
              color: isTappable ? Colors.green : Colors.black,
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          MyApp()), // Replace MainScreen with your actual main screen widget
                  (route) =>
                      false, // This removes all previous screens from the stack
                );
              },
              child: Text("back"))
        ]),
      ),
    );
  }
}
