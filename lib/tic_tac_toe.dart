import 'package:flutter/material.dart';

class TicTacToe extends StatefulWidget {
  const TicTacToe({super.key});

  @override
  State<StatefulWidget> createState() => _TicTacToeState();
}

class _TicTacToeState extends State<TicTacToe> {
  List<String> board = List.filled(9, "");
  String currentPlayer = "X";
  String winner = "";
  bool isTie = false;
  int player1Score = 0;
  int player2Score = 0;

  void movePlayer(int index) {
    if (winner != "" || board[index] != "") {
      return;
    }

    setState(() {
      board[index] = currentPlayer;
      currentPlayer = currentPlayer == "X" ? "O" : "X";
      checkForWinner();
      trackScore();
    });
  }

  void checkForWinner() {
    List<List<int>> combos = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (List<int> combo in combos) {
      if (board[combo[0]] == "" &&
          board[combo[1]] == "" &&
          board[combo[2]] == "") {
        continue;
      }

      if (board[combo[0]] == board[combo[1]] &&
          board[combo[1]] == board[combo[2]]) {
        setState(() {
          winner = board[combo[0]];
        });
        return;
      }
    }

    if (!board.contains("")) {
      setState(() {
        isTie = true;
      });
    }
  }

  void trackScore() {
    if (winner == "X") {
      setState(() {
        player1Score++;
      });
    } 
    else if (winner == "O") {
      setState(() {
        player2Score++;
      });
    }
  }

  void resetGame() {
    setState(() {
      board.fillRange(0, 9, "");
      currentPlayer = "X";
      winner = "";
      isTie = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Displaying The Players.
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: currentPlayer == "X"
                          ? Colors.amber
                          : Colors.transparent,
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black38,
                        blurRadius: 3,
                      ),
                    ]),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.person,
                        color: Colors.white38,
                        size: 60,
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Player 1",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "X",
                        style: TextStyle(
                          color: Colors.cyan,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Score: $player1Score",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: size.width * 0.08),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: currentPlayer == "O"
                          ? Colors.amber
                          : Colors.transparent,
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black38,
                        blurRadius: 3,
                      ),
                    ]),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.person,
                        color: Colors.white38,
                        size: 60,
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Player 2",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "O",
                        style: TextStyle(
                          color: Colors.orange,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Score: $player2Score",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: size.height * 0.04),
          if (winner != "")
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  winner,
                  style: const TextStyle(
                    fontSize: 40,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  " WON!",
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          if (isTie)
            const Text(
              "IT'S A TIE!",
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
                color: Colors.redAccent,
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: GridView.builder(
              itemCount: 9,
              padding: const EdgeInsets.all(10),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => movePlayer(index),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black38,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        board[index],
                        style: TextStyle(
                          fontSize: 50,
                          color:
                              board[index] == "X" ? Colors.cyan : Colors.orange,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          if (winner != "" || isTie)
            ElevatedButton(
              onPressed: resetGame,
              child: const Text(
                "Play Again!",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Colors.deepPurple,
                ),
              ),
            ),
        ],
      ),
    );
  }
}