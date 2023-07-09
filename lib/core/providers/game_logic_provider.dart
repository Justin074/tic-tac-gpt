import 'package:tic_tac_gpt/core/enums/game_state.dart';
import 'package:tic_tac_gpt/core/enums/player.dart';
import 'package:tic_tac_gpt/core/models/game_board.dart';
import 'package:tic_tac_gpt/core/providers/base_provider.dart';
import 'package:tic_tac_gpt/core/services/open_ai_service.dart';

class GameLogicProvider extends BaseProvider<GameBoard> {
  GameLogicProvider() : super(classCreator: () => GameBoard());

  void makeAMove(int index) {
    if (valueProvider.value.board[index] != '') return;
    switch (valueProvider.value.gameState) {
      case GameState.initial:
        _updateBoard(index, 'X');
        if (!_detectWinner()) {
          valueProvider.value.gameState = GameState.aiTurn;
          drawCheck();
          _makeAiMove();
        }
        break;
      case GameState.playerTurn:
        _updateBoard(index, 'X');
        if (!_detectWinner()) {
          valueProvider.value.gameState = GameState.aiTurn;
          drawCheck();
          _makeAiMove();
        }
        break;
      case GameState.aiTurn:
        break;
      case GameState.draw:
        break;
      case GameState.complete:
        break;
      case GameState.error:
        break;
    }
    notifyClients();
  }

  // TicTacToe Win Detection Logic {Yucky Ifs}
  bool _detectWinner() {
    try {
      final List<String> board = valueProvider.value.board;
      final List<int> winningPositions = <int>[];
      bool hasWon = false;

      // Horizontal win on first row
      if (board[0] == board[1] &&
          board[1] == board[2] &&
          board[0] != '' &&
          board[1] != '' &&
          board[2] != '') {
        hasWon = true;
        winningPositions.addAll(<int>[0, 1, 2]);
      }
      // Horizontal win on second row
      if (board[3] == board[4] &&
          board[4] == board[5] &&
          board[3] != '' &&
          board[4] != '' &&
          board[5] != '') {
        hasWon = true;
        winningPositions.addAll(<int>[3, 4, 5]);
      }
      // Horizontal win on third row
      if (board[6] == board[7] &&
          board[7] == board[8] &&
          board[6] != '' &&
          board[7] != '' &&
          board[8] != '') {
        hasWon = true;
        winningPositions.addAll(<int>[6, 7, 8]);
      }

      // Vertical win on first column
      if (board[0] == board[3] &&
          board[3] == board[6] &&
          board[0] != '' &&
          board[3] != '' &&
          board[6] != '') {
        hasWon = true;
        winningPositions.addAll(<int>[0, 3, 6]);
      }
      // Vertical win on second column
      if (board[1] == board[4] &&
          board[4] == board[7] &&
          board[1] != '' &&
          board[4] != '' &&
          board[7] != '') {
        hasWon = true;
        winningPositions.addAll(<int>[1, 4, 7]);
      }
      // Vertical win on third column
      if (board[2] == board[5] &&
          board[5] == board[8] &&
          board[2] != '' &&
          board[5] != '' &&
          board[8] != '') {
        hasWon = true;
        winningPositions.addAll(<int>[2, 5, 8]);
      }

      // Diagonal win from top left
      if (board[0] == board[4] &&
          board[4] == board[8] &&
          board[0] != '' &&
          board[4] != '' &&
          board[8] != '') {
        hasWon = true;
        winningPositions.addAll(<int>[0, 4, 8]);
      }
      // Diagonal win from top right
      if (board[2] == board[4] &&
          board[4] == board[6] &&
          board[2] != '' &&
          board[4] != '' &&
          board[6] != '') {
        hasWon = true;
        winningPositions.addAll(<int>[2, 4, 6]);
      }

      if (hasWon) {
        valueProvider.value.winningPositions.addAll(winningPositions);
        valueProvider.value.winner =
        valueProvider.value.gameState == GameState.playerTurn
            ? Player.human
            : Player.ai;
        valueProvider.value.gameState = GameState.complete;
        notifyClients();
      }

      return hasWon;
    } catch (e) {
      valueProvider.value.gameState = GameState.error;
      return false;
    }
  }

  void reState() {
    valueProvider.value.reinstate();
    notifyClients();
  }

  void _updateBoard(int index, String value) {
    valueProvider.value.updateBoard(index, value);
    notifyClients();
  }

  void drawCheck() {
    if (!valueProvider.value.board.any((String element) => element == '') &&
        valueProvider.value.gameState != GameState.complete &&
        valueProvider.value.gameState != GameState.error) {
      valueProvider.value.gameState = GameState.draw;
    }
  }

  Future<void> _makeAiMove() async {
    if (valueProvider.value.gameState == GameState.draw) return;

    final String answer = await OpenAiService.getChatAnswer(
      valueProvider.value,
    );

    _processNewBoard(answer);

    if (!_detectWinner()) {
      valueProvider.value.gameState = GameState.playerTurn;
    }

    drawCheck();

    notifyClients();
  }

  void _processNewBoard(String guess) {
    final RegExp regExp = RegExp(
      r'\[.*',
      multiLine: true,
      caseSensitive: false,
    );

    final String? match = regExp.stringMatch(guess);

    if (match == null) {
      valueProvider.value.gameState = GameState.error;
      notifyClients();
      return;
    }

    String foundAnswer = match.replaceAll(' ', '');
    foundAnswer = foundAnswer.replaceAll('[', '');
    foundAnswer = foundAnswer.replaceAll(']', '');
    foundAnswer = foundAnswer.replaceAll('#', '');
    foundAnswer = foundAnswer.replaceAll('\'', '');
    valueProvider.value.board = foundAnswer.split(',');
    notifyClients();
  }
}
