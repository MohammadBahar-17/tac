import 'dart:io';

void main() {
  bool gameRunning = true;
  while (gameRunning) {
    playGame();
    print('Do you want to play again? (y/n): ');
    String? playAgain = stdin.readLineSync();
    if (playAgain?.toLowerCase() != 'y') {
      gameRunning = false;
    }
  }
}

void playGame() {
  List<String> board = List.filled(9, ' ');
  String currentPlayer = 'X';
  bool gameWon = false;
  int turns = 0;

  while (!gameWon && turns < 9) {
    displayBoard(board);
    print('Player $currentPlayer, enter a number (1-9) to make your move:');
    String? input = stdin.readLineSync();

    if (input != null && input.isNotEmpty) {
      int move = int.tryParse(input) ?? 0;

      if (move >= 1 && move <= 9 && board[move - 1] == ' ') {
        board[move - 1] = currentPlayer;
        turns++;
        gameWon = checkWinner(board, currentPlayer);
        if (gameWon) {
          displayBoard(board);
          print('Player $currentPlayer wins!');
        } else if (turns == 9) {
          displayBoard(board);
          print('The game is a draw!');
        } else {
          currentPlayer = (currentPlayer == 'X') ? 'O' : 'X';
        }
      } else {
        print('Invalid move. Try again.');
      }
    }
  }
}

void displayBoard(List<String> board) {
  print('---+---+---');
  for (int i = 0; i < 3; i++) {
    print('${board[i * 3]} | ${board[i * 3 + 1]} | ${board[i * 3 + 2]}');
    if (i < 2) print('---+---+---');
  }
  print('---+---+---');
}

bool checkWinner(List<String> board, String player) {
  List<List<int>> winningCombinations = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6],
  ];

  for (var combination in winningCombinations) {
    if (board[combination[0]] == player &&
        board[combination[1]] == player &&
        board[combination[2]] == player) {
      return true;
    }
  }
  return false;
}
