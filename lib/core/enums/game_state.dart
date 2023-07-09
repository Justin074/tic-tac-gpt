enum GameState {
  initial,
  playerTurn,
  aiTurn,
  error,
  draw,
  complete;

  @override
  toString() {
    switch (this) {
      case GameState.initial:
        return 'Make a move to start the game';
      case GameState.playerTurn:
        return 'Make your move';
      case GameState.aiTurn:
        return 'M. Robot is thinking...';
      case GameState.complete:
        return 'Good game!';
      case GameState.draw:
        return 'No victors here!';
      case GameState.error:
        return 'Whoops! Something went wrong. Please reset';
    }
  }
}