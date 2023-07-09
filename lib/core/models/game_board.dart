import 'package:tic_tac_gpt/core/enums/game_state.dart';
import 'package:tic_tac_gpt/core/enums/player.dart';

class GameBoard {
  List<String> board = List.filled(9, '');
  final List<int> winningPositions = <int>[];
  GameState gameState = GameState.initial;
  Player? winner;

  void updateBoard(int index, String value) {
    board[index] = value;
  }

  void reinstate() {
    board = List.filled(9, '');
    gameState = GameState.initial;
    winner = null;
    winningPositions.clear();
  }

  String get mapToGPT {
    String newBoard = '[';
    for (String element in board) {
      newBoard += '\'$element\',';
    }
    newBoard = newBoard.substring(0, newBoard.length - 1);
    newBoard += ']';
    return newBoard;
  }
}