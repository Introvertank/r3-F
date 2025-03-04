import 'package:flutter/material.dart';
import 'package:tomdo_list/main.dart';

class TicTacToe extends StatefulWidget {
  final int gridSize;
  final int moveTime;
  const TicTacToe({super.key, required this.gridSize, required this.moveTime});

  @override
  State<TicTacToe> createState() => _TicTacToeState();
}

class _TicTacToeState extends State<TicTacToe> {
  // List<String> board = List.filled(9,"");
  // .filled makes a list with certain no. of members and initializes them with same value, thus preventing null values
  late List<String> board;
  bool isXTurn = true;
  String winner = "";

  @override
  void initState() {
    //method used to initialize state of an widget before   build method is called
    super.initState();
    board = List.filled(widget.gridSize * widget.gridSize, "");
  }

  void _handleTap(int index) {
    if (board[index] == "" && winner == "") {
      setState(() {
        board[index] = isXTurn ? "X" : "O";
        isXTurn = !isXTurn;
        _checkwinner();
      });

      _startTimer();
    }
  }

  void _startTimer() {
    Future.delayed(Duration(seconds: widget.moveTime), () {
      if (mounted && winner == "") {
        setState(() {
          isXTurn = !isXTurn; //switch turn if no move made in chosen time
        });
      }
    });
  }

  void _checkwinner() {
    int size = widget.gridSize;
    int winLength = (size == 3) ? 3 : 4;

    //check rows
    for (var i = 0; i < size; i++) {
      for (var j = 0; j <= size - winLength; j++) {
        if (board[i * size + j] != "" &&
            board[i * size + j] == board[i * size + j + 1] &&
            board[i * size + j] == board[i * size + j + 2] &&
            (winLength == 3 ||
                board[i * size + j] == board[i * size + j + 3])) {
          setState(() {
            winner = "${board[i * size + j]} wins";
          });
          return;
        }
      }
    }

    // Check columns
    for (int i = 0; i < size; i++) {
      for (int j = 0; j <= size - winLength; j++) {
        if (board[j * size + i] != "" &&
            board[j * size + i] == board[(j + 1) * size + i] &&
            board[j * size + i] == board[(j + 2) * size + i] &&
            (winLength == 3 ||
                board[j * size + i] == board[(j + 3) * size + i])) {
          setState(() {
            winner = "${board[j * size + i]} Wins!!!";
          });
          return;
        }
      }
    }

    // Check main diagonals
    for (int i = 0; i <= size - winLength; i++) {
      for (int j = 0; j <= size - winLength; j++) {
        if (board[i * size + j] != "" &&
            board[i * size + j] == board[(i + 1) * size + (j + 1)] &&
            board[i * size + j] == board[(i + 2) * size + (j + 2)] &&
            (winLength == 3 ||
                board[i * size + j] == board[(i + 3) * size + (j + 3)])) {
          setState(() {
            winner = "${board[i * size + j]} Wins!!!";
          });
          return;
        }
      }
    }

    // Check anti-diagonals
    for (int i = 0; i <= size - winLength; i++) {
      for (int j = winLength - 1; j < size; j++) {
        if (board[i * size + j] != "" &&
            board[i * size + j] == board[(i + 1) * size + (j - 1)] &&
            board[i * size + j] == board[(i + 2) * size + (j - 2)] &&
            (winLength == 3 ||
                board[i * size + j] == board[(i + 3) * size + (j - 3)])) {
          setState(() {
            winner = "${board[i * size + j]} Wins!!!";
          });
          return;
        }
      }
    }

    //draw scenario
    if (!board.contains("") && winner == "") {
      setState(() {
        winner = "draw";
      });
    }
  }

  void _resetGame() {
    setState(() {
      board = List.filled(widget.gridSize * widget.gridSize, "");
      isXTurn = true;
      winner = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 50,
          ),
          Text(
            winner.isEmpty ? "${isXTurn ? "X" : "O"}'s turn" : winner,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.bold, color: Colors.grey),
          ),
          Container(
            child: SizedBox(
              height: 150,
            ),
          ),
          Expanded(
            child: GridView.builder(
                padding: EdgeInsets.symmetric(horizontal: 10),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: widget.gridSize, //3 or 4
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10),
                itemCount: widget.gridSize * widget.gridSize, //9 or 16
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => _handleTap(index),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.blueGrey,
                          borderRadius: BorderRadius.circular(8)),
                      alignment: Alignment.center,
                      child: Text(
                        board[index],
                        style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  );
                }),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _resetGame,
            child: Text("restart"),
          ),
          SizedBox(
            height: 10,
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
        ],
      ),
    );
  }
}
