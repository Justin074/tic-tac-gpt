import 'package:flutter/material.dart';
import 'package:tic_tac_gpt/core/enums/game_state.dart';
import 'package:tic_tac_gpt/core/models/game_board.dart';
import 'package:tic_tac_gpt/core/providers/game_logic_provider.dart';
import 'package:tic_tac_gpt/lib/widgets/neo_tile.dart';

class TicTacGrid extends StatefulWidget {
  const TicTacGrid({Key? key}) : super(key: key);

  @override
  State<TicTacGrid> createState() => _TicTacGridState();
}

class _TicTacGridState extends State<TicTacGrid> {
  late GameLogicProvider gameLogicProvider;

  @override
  void initState() {
    gameLogicProvider = GameLogicProvider();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: gameLogicProvider.valueProvider,
      builder: (BuildContext context, GameBoard value, Widget? child) {
        return Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.16,
            ),
            if (value.gameState == GameState.complete)
              Text(
                value.winner?.toString() ?? '',
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.surface,
                ),
              ),
            Text(
              value.gameState.toString(),
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).colorScheme.surface,
              ),
            ),
            if (value.gameState == GameState.complete ||
                value.gameState == GameState.draw ||
                value.gameState == GameState.error)
              TextButton(
                onPressed: () {
                  gameLogicProvider.reState();
                },
                child: Text(
                  'RESET',
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.surface,
                  ),
                ),
              ),
            const SizedBox(
              height: 15,
            ),
            Expanded(
              child: GridView(
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                children: List.generate(
                  value.board.length,
                  (index) => GestureDetector(
                    onTap: () {
                      if (value.board[index] == '') {
                        gameLogicProvider.makeAMove(index);
                      }
                    },
                    child: NeoTile(
                      height: MediaQuery.of(context).size.width * 0.3,
                      width: MediaQuery.of(context).size.width * 0.3,
                      text: value.board[index],
                      winner: value.winningPositions.contains(index),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
