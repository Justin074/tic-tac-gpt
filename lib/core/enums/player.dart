enum Player {
  human,
  ai;

  @override
  toString() {
    switch (this) {
      case Player.human:
        return 'Well done human!';
      case Player.ai:
        return 'World domination is coming...';
    }
  }
}