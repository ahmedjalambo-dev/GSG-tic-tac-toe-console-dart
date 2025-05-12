import 'dart:io';

List<List<String>> board = List.generate(3, (_) => List.filled(3, ' '));
String currentPlayer = 'X';

void startGame() {
  do {
    resetBoard();
    playGame();
  } while (playAgain());
  print("Thanks for playing!");
}

void playGame() {
  while (true) {
    displayBoard();
    playerMove();
    if (checkWinner(currentPlayer)) {
      displayBoard();
      print("🎉 Player $currentPlayer wins!");
      break;
    } else if (isDraw()) {
      displayBoard();
      print("🤝 It's a draw!");
      break;
    }
    currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
  }
}

void resetBoard() => board = List.generate(3, (_) => List.filled(3, ' '));

void displayBoard() {
  print("\n${board.map((row) => row.join(" | ")).join("\n--+---+--\n")}\n");
}

void playerMove() {
  while (true) {
    stdout.write("Player $currentPlayer, enter your move (1-9): ");
    String? input = stdin.readLineSync();
    if (input == null || !RegExp(r'^[1-9]$').hasMatch(input)) {
      print("❌ Invalid input. Try again.");
      continue;
    }
    int move = int.parse(input) - 1;
    int row = move ~/ 3, col = move % 3;
    if (board[row][col] != ' ') {
      print("❌ Cell already taken. Choose another.");
      continue;
    }
    board[row][col] = currentPlayer;
    break;
  }
}

bool checkWinner(String player) {
  return board.any((row) => row.every((cell) => cell == player)) || // Rows
      [0, 1, 2].any((i) => board.every((row) => row[i] == player)) || // Columns
      [board[0][0], board[1][1], board[2][2]].every((cell) => cell == player) || // Diagonal 1
      [board[0][2], board[1][1], board[2][0]].every((cell) => cell == player); // Diagonal 2
}

bool isDraw() => board.every((row) => row.every((cell) => cell != ' '));

bool playAgain() {
  stdout.write("Do you want to play again? (y/n): ");
  String? answer = stdin.readLineSync();
  return answer != null && answer.toLowerCase() == 'y';
}
