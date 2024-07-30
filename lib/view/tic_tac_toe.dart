import 'package:flutter/material.dart';

class TicTacToe extends StatefulWidget {
  const TicTacToe({super.key});

  @override
  State<TicTacToe> createState() => _TicTacToeState();
}

class _TicTacToeState extends State<TicTacToe> {
  // Border state to keep track of moves
  final List<String> board = List.filled(9, "");
  // Current Player(x or 0)
  String currentPlayer = "X";
  // Variable to store the winner
  String winner = "";
  // Flag to indicate a tie
  bool isTie = false;
  // Variable store the Scores
  int scoreX = 0;
  int scoreO = 0;
  // Function to handle a player's move
 void player(int index) {
    if (winner != '' || board[index] != "") {
      return; // If the game is allready won or the cell is not empty do nothing
    }
    setState(() {
      board[index] =
          currentPlayer; // set the current cell to the current palyer's symballs
      currentPlayer = currentPlayer == "X"
          ? "O"
          : "X"; // switch to the one to another palyer

      checkForWinner();
      // List<List<int>> lines = [
        // [0, 1, 2],
        // [3, 4, 5],
        // [6, 7, 8],
        // [0, 3, 6],
        // [0, 4, 7],
        // [2, 5, 8],
        // [2, 4, 6],
      // ];
      // // Check each winning combination
      // for (List<int> line in lines) {
      //   String palyer1 = board[line[0]];
      //   String palyer2 = board[line[1]];
      //   String palyer3 = board[line[2]];
      //   if (palyer1 == "" || palyer2 == "" || palyer3 == "") {
      //     continue; // If any cell in the combination is empty, skip theis combination
      //   }
      //   if (palyer1 == palyer2 && palyer2 == palyer3) {
      //     setState(() {
      //       winner =
      //           palyer1; // If all cells in the combination are the same, set the winner
      //     });
      //     return;
      //   }
      // }
      // // Check for a tie
      // if (!board.contains("")) {
      //   setState(() {
      //     isTie = true; //if no cell are empty and there's no winner its' a tie
      //   });
      // }
    });
  }

  // Function for check for a winner or a tie
  void checkForWinner() {
    List<List<int>> lines = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];
    // Check each winning combination
    for (List<int> line in lines) {
      String palyer1 = board[line[0]];
      String palyer2 = board[line[1]];
      String palyer3 = board[line[2]];
      if (palyer1 == "" || palyer2 == "" || palyer3 == "") {
        continue; // If any cell in the combination is empty, skip theis combination
      }
      if (palyer1 == palyer2 && palyer2 == palyer3) {
        setState(() {
          winner =
              palyer1; // If all cells in the combination are the same, set the winner
              if(winner == "X"){
                scoreX ++;
              } else {
                scoreO ++;
              }
        });
        return;
      }
    }
    if (!board.contains("")) {
      setState(() {
        isTie = true; //if no cell are empty and there's no winner its' a tie
      });
    }
  }

  // Function to reset the game state and play the new game
  resetGame() {
    setState(() {
      board.fillRange(0, 9, ''); // clear the board
      currentPlayer = 'X';
      winner = ''; // clear the winner
      isTie = false; // Clear the tie flag
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.deepPurpleAccent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: currentPlayer == "X"
                              ? Colors.amber
                              : Colors.transparent),
                      boxShadow: const [
                        BoxShadow(color: Colors.black38, blurRadius: 3)
                      ]),
                  child:  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        const Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 55,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "BOT 1",
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "$scoreX",
                          style: const TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: size.width * 0.08,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: currentPlayer == "O"
                              ? Colors.amber
                              : Colors.transparent),
                      boxShadow: const [
                        BoxShadow(color: Colors.black38, blurRadius: 3)
                      ]),
                  child:  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        const Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 55,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "BOT 2",
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "$scoreO",
                          style: const TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: size.height * 0.04,
            ),
            // Dispaly the winner message
            if (winner != "")
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    winner,
                    style: const TextStyle(
                        fontSize: 35,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    " WON!",
                    style: TextStyle(
                        fontSize: 35,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            // Dispaly the Tie message
            if (isTie)
              const Text(
                "It's a Tie",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
              ),
            // For Game board
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
                    onTap: () {
                      player(index);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black38,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          board[index],
                          style: const TextStyle(
                              fontSize: 50, color: Colors.white),
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
                child:const Text("Play Again"),
              )
          ],
        ),
      ),
    );
  }
}
